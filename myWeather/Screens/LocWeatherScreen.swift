//
//  LocWeatherScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/2/22.
//

import SwiftUI
import CoreLocation

//struct LocWeatherScreen: View {
    
//    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
//    @AppStorage("isDarkMode") private var isDark = false
//    @EnvironmentObject var store: Store
//    @ObservedObject var networkManager = NetworkManager()
//    @State var myWeather: ForecastViewModel!
//    @StateObject var locationManager = LocationManager()
//
//    var webService = WebService()
//
//    var body: some View {
//        ZStack {
//            Image("background-image")
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
//
//            VStack {
//                if networkManager.isConnected {
//                    if let location = locationManager.location {
//                        if let myWeather = myWeather {
//                            ForecastListView(myWeather: myWeather)
//                        } else {
//                            LoadingView()
//                                .task {
//                                    do {
//                                        myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
//
//                                        //Save or Update stored data
//                                        if store.currentW.isEmpty {
//                                            store.addCurrent(myWeather)
//                                        } else {
//                                            store.updateCurrent(myWeather)
//                                        }
//                                    } catch {
//                                        print("Error getting weather: \(error)")
//                                    }
//                                }
//                        }
//                    } else {
//                        LoadingView()
//                            .onAppear(perform: locationManager.requestLocation)
//                    }
//                } else {
//                    ForEach(store.currentW, id: \.cityName) { myWeather in
//                        ForecastListView(myWeather: myWeather)
//
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct LocWeatherScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LocWeatherScreen()
//            .environmentObject(Store())
//    }
//}
