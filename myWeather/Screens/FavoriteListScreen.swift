//
//  FavoriteListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/15/22.
//

import SwiftUI
import CoreLocationUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addNewCity
    case settings
}

struct FavoriteListScreen: View {
    
    @EnvironmentObject var store: Store
    @State var isEditing = false
    @State var showAdd = false
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @StateObject private var addCityVM = AddCityViewModel()
    @StateObject var locationManager = LocationViewModel()
    var webService = WebService()
    @State var myWeather: MyWeather!
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search for a city",
                                  text: $addCityVM.city,
                                  onEditingChanged: { isEditing in self.showCancelButton = true },
                                  onCommit: {addCityVM.add { myWeather in store.addWeather(myWeather)}
                        })
                        .foregroundColor(.accentColor)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                
                List {
                    
                    if let location = locationManager.location {
                        if let myWeather = myWeather {
                            NavigationLink(destination: ForecastScreen(city: myWeather.city)) {
                                CurrentWeatherCell(myWeather: myWeather)
                            }
                        } else {
                            LoadingView()
                                .task {
                                    do {
                                        myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    } catch {
                                        print("Error getting weather: \(error)")
                                    }
                                }
                        }
                    } else {
                        LoadingView()
                            .onAppear(perform: locationManager.requestLocation)
                    }
                    
                    ForEach(store.weatherList, id: \.city) { myWeather in
                        NavigationLink(destination: ForecastScreen(city: myWeather.currentCity)) {
                            WeatherCell(myWeather: myWeather)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        store.weatherList.remove(atOffsets: indexSet)})
                }//ScrollView
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            }//Vstack
            
// MARK: - NavigationBar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            self.isEditing.toggle()
                        } label: {
                            Label {
                                Text(isEditing ? "Done" : "Edit List")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                            
                        }
                        
                        Divider()
                        Button {
//                            selectedUnit = .celsius
                        } label: {
                            Text("Celsius")
                            
                        }
                        
                        Button {
//                            selectedUnit = .fahrenheit
                        } label: {
                            Text("Fahrenheit")
                        }
                        
                        Divider()
                        Button {
                            print("Report an Issue")
                        } label: {
                            Label {
                                Text("Report an Issue")
                            } icon: {
                                Image(systemName: "exclamationmark.bubble")
                            }
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .navigationBarTitle("myWeather")
            .foregroundColor(Color.accentColor)
        }//NvigationView
    }
}

struct FavoriteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListScreen()
            .environmentObject(Store())
    }
}

// Update for iOS 15
// MARK: - UIApplication extension for resgning keyboard on pressing the cancel buttion of the search bar
extension UIApplication {
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
