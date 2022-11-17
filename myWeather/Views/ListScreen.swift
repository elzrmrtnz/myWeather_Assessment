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
//    @State var weather: [ForecastViewModel]!
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var cd: ForecastData
//    @State var forecast: ForecastEntity!
    @State var current: CurrentEntity!
    
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
                                            if cd.current.isEmpty {
                                                cd.addCurrent(myWeather)
                                            } else {
                                                cd.updateWeather(myWeather)
                                            }
//                                            if store.currentW.isEmpty {
//                                                store.addCurrent(myWeather)
//                                            } else {
//                                                store.updateCurrent(myWeather)
//                                            }
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
                        ForEach(cd.current, id: \.uuid) { forecast in
                            NavigationLink(destination: DetailCurrent(forecast: forecast)) {
                                //                                    CurrentWeatherCell(myWeather: myWeather)
                                WeatherCellTest(forecast: forecast)
                            }
                        }
                    }
                    
                    // MARK: - Added Cities
                    //                    if networkManager.isConnected {
                    //                        //Update Stored WeatherList
                    //                          store.updateWeather(myWeather)
                    //                    } else {
                    ForEach(cd.forecastList, id: \.uuid) { forecast in
                        NavigationLink(destination: DetailForecast(forecast: forecast)) {
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


//    if weather != nil {
//        CurrentWeatherCell(myWeather: myWeather)
//    } else {
//    LoadingView()
//        .task {
//            do {
//                CurrentViewModel().getCurrent { forecast in
//                    cd.addForecast(weather)}
//                } catch {
//                    print("Error getting weather: \(error)")
//                }
//            }
//        }
//
//} else {
//    LoadingView()
//        .onAppear(perform: locationManager.requestLocation)
//}
