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
    @State var weather: [ForecastViewModel]!
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var cd: ForecastData
    @State var forecast: ForecastEntity!
    
    var webService = WebService()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView()
                
                List {
                    // MARK: - Current Location
                    if networkManager.isConnected {
                        if let location = locationManager.location {
                            if let weather = weather {
                                NavigationLink(destination: DetailScreen(myWeather: myWeather)) {
                                    CurrentWeatherCell(myWeather: myWeather)
                                }
                            } else {
                                LoadingView()
                                    .task {
                                        do {
                                           weather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                            
                                            //Save or Update stored data
                                            if cd.savedEntites.isEmpty {
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
                    ForEach(cd.savedEntites) { forecast in
                        NavigationLink(destination: DetailScreen(myWeather: myWeather)) {
                            WeatherCell(forecast: forecast)
                        }
                    }
                    .onDelete(perform: cd.deleteForecast)
  
                    //                    }//end of if else
                }//ScrollView
                .listStyle(PlainListStyle())
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
            .environmentObject(ForecastData())
    }
}


