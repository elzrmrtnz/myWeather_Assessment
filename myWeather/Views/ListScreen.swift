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
    @StateObject var locationManager = LocationManager()
    
    var webService = WebService()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView()
                
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


