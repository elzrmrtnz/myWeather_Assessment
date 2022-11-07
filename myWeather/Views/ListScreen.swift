//
//  FavoriteListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/15/22.
//

import SwiftUI

struct ListScreen: View {
    
    @AppStorage("isDarkMode") private var isDark = false
    @EnvironmentObject var store: Store
    @ObservedObject var networkManager = NetworkManager()
    @State var myWeather: ForecastViewModel!
    @State var isEditing = false
    @State private var showCancelButton: Bool = false
    @StateObject private var addCityVM = AddCityViewModel()
    @StateObject var locationManager = LocationManager()
   
    var webService = WebService()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // MARK: - Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search for a city",
                                  text: $addCityVM.city,
                                  onEditingChanged: { isEditing in self.showCancelButton = true },
                                  onCommit: {addCityVM.getCity { myWeather in store.addWeather(myWeather)}
                        })
                        .foregroundColor(.accentColor)
                        
                        Button(action: {
                            self.addCityVM.city = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(addCityVM.city == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.addCityVM.city = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                
                List {
                    // MARK: - Current Location
                    if networkManager.isConnected {
                        if let location = locationManager.location {
                            if let myWeather = myWeather {
                                NavigationLink(destination: DetailScreen(myWeather: myWeather)) {
                                    CurrentWeatherCell(myWeather: myWeather)
                                }
                            } else {
                                LoadingView()
                                    .task {
                                        do {
                                            myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                            
                                        //Save or Update stored data
                                            if store.currentW.isEmpty {
                                                store.addCurrent(myWeather)
                                            } else {
                                                store.updateCurrent(myWeather)
                                            }
                                        } catch {
                                            print("Error getting weather: \(error)")
                                        }
                                    }
                            }
                        } else {
                            LoadingView()
                                .onAppear(perform: locationManager.requestLocation)
                        }
                    } else {
                        ForEach(store.currentW, id: \.cityName) { myWeather in
                            NavigationLink(destination: DetailScreen(myWeather: myWeather)) {
                                CurrentWeatherCell(myWeather: myWeather)
                            }
                        }
                    }
                    
                    // MARK: - Added Cities
//                    if networkManager.isConnected {
//                        //Update Stored WeatherList
//                          store.updateWeather(myWeather)
//                    } else {
                        ForEach(store.weatherList, id: \.cityName) { myWeather in
                            NavigationLink(destination: DetailScreen(myWeather: myWeather)) {
                            WeatherCell(myWeather: myWeather)
                        }
                    }
                    .onDelete(perform: store.deleteWeather)
//                    }//end of if else
                }//ScrollView
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            }//Vstack
            
            // MARK: - NavigationBar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    MenuView()
                }
            }
            .navigationBarTitle("myWeather")
            .foregroundColor(Color.accentColor)
        }//NvigationView
        .preferredColorScheme(isDark ? .dark : .light)
    } 
}

struct FavoriteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
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
