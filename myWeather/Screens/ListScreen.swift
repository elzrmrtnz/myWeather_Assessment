//
//  FavoriteListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/15/22.
//

import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addNewCity
    case settings
}

struct ListScreen: View {
    
    @EnvironmentObject var store: Store
//    @EnvironmentObject var data: DataStore
    @ObservedObject var networkManager = NetworkManager()
    
    @State var isEditing = false
    @State private var showCancelButton: Bool = false
    @StateObject private var addCityVM = AddCityViewModel()
    @StateObject var locationManager = LocationManager()
    @State var myWeather: ForecastViewModel!
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    @AppStorage("isDarkMode") private var isDark = false
    
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
                                NavigationLink(destination: DetailScreen(city: myWeather.cityName)) {
                                    CurrentWeatherCell(myWeather: myWeather)
                                }
//                                .onAppear(perform: store.loadCurrent)
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
                            NavigationLink(destination: DetailScreen(city: myWeather.cityName )) {
                                CurrentWeatherCell(myWeather: myWeather)
                            }
                        }
                    }
//                        .onAppear(perform: data.loadCurrent)
//                        LoadingView()
//                        .onAppear(perform: data.loadCurrent)
//                    }
//
//                    ForEach(store.currentW, id: \.cityName) { myWeather in
//                        NavigationLink(destination: DetailScreen(city: myWeather.cityName )) {
//                            CurrentWeatherCell(myWeather: myWeather)
//                        }
//                    }
                    
                    // MARK: - Added Cities
                    
                    ForEach(store.weatherList, id: \.cityName) { myWeather in
                        NavigationLink(destination: DetailScreen(city: myWeather.cityName )) {
                            WeatherCell(myWeather: myWeather)
                        }
                    }
                    .onDelete(perform: store.deleteWeather)
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
                                Text(isEditing ? "Done" : "Edit")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        //Theme: Dark or LightMode
                        Button {
                            isDark.toggle()
                        } label: {
                            Label {
                                Text("Theme: ")
                            } icon: {
                                Image(systemName: isDark ? "moon" : "sun.max")
                            }
                        }
                        
                        Divider()
                        
                        Picker(selection: $selectedUnit, label: Text("")) {
                            ForEach(TemperatureUnit.allCases, id: \.self) {
                                Text("\($0.displayText)" as String)
                            }
                        }
                        .pickerStyle(.automatic)
                        
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
                    //Update value when user select a unit
                    .onChange(of: selectedUnit) { newValue in
                        store.selectedUnit = selectedUnit
                    }
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
//            .environmentObject(DataStore())
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
