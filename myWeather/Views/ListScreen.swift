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
    @EnvironmentObject var cd: ForecastData
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
                                CurrentWeatherCell(myWeather: myWeather)
                                    .background(NavigationLink("",destination: DetailScreen(myWeather: myWeather)))
                                    .listRowSeparator(.hidden)
                            } else {
                                LoadingView()
                                    .task {
                                        do {
                                            myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
            
                                            if cd.current.isEmpty {
                                                cd.addCurrent(myWeather)
                                            } else {
                                                cd.updateWeather(myWeather)
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
                        ForEach(cd.current, id: \.uuid) { forecast in
                            WeatherCellTest(forecast: forecast)
                                .background(NavigationLink("", destination: DetailCurrent(forecast: forecast)))
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    // MARK: - Added Cities
                    ForEach(cd.forecastList, id: \.uuid) { forecast in
                        WeatherCell(forecast: forecast)
                            .background(NavigationLink("", destination: DetailForecast(forecast: forecast)))
                    }
                    .onDelete(perform: cd.deleteForecast)
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
            
            // MARK: - NavigationBar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    MenuView()
                }
            }
            .navigationBarTitle("myWeather")
            .foregroundColor(Color.accentColor)
        }
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

