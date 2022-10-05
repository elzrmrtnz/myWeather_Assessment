//
//  ForecastListViewModel.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import CoreLocation
import Foundation
import SwiftUI

enum LoadingState {
    case loading, success, failed, none
}
//enum 
class ForecastListViewModel: ObservableObject {
    
    @EnvironmentObject var store: Store
    @Published var loadingState: LoadingState = .none
    @Published var myWeather: MyWeather?
//    @Published var shouldShowLocationError: Bool = false
    
    
    let webService = WebService()
    var city: String = ""
    
    init(myWeather: MyWeather? = nil) {
        self.myWeather = myWeather
    }
    
    let id = UUID()

    func getForecastByCity(city: String) {
        
        webService.getForecastBy(city: city.trimmedAndEscaped()) { result in
            switch result {
            case .success(let myWeather):
                if let myWeather = myWeather {
                    DispatchQueue.main.async {
                        self.myWeather = myWeather
                        self.loadingState = .success
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.loadingState = .failed
            }
        }
    }
    
    var currentCity: String {
        return myWeather!.city
    }
    
    var date: String {
        return (myWeather?.date0.formatAsString2())!
    }
    
    var currentWeatherIcon: String? {
        return dailyWeatherIcons[0]
    }
    var currentTemp: String? {
        return getTempByUnit(unit: store.selectedUnit)[0]
    }
    
    var description: String? {
        return myWeather?.description0.capitalized
    }


    
    
    func getTempByUnit(unit: TemperatureUnit) -> [String] {
        switch unit {
        case .celsius:
            return [ roundedOf(myWeather!.temperature0),
                     roundedOf(myWeather!.temperature1),
                     roundedOf(myWeather!.temperature2),
                     roundedOf(myWeather!.temperature3),
                     roundedOf(myWeather!.temperature4)
            ]
        case .fahrenheit:
            return [ roundedOf(1.8 * (myWeather!.temperature0) + 32),
                     roundedOf(1.8 * (myWeather!.temperature1) + 32),
                     roundedOf(1.8 * (myWeather!.temperature2) + 32),
                     roundedOf(1.8 * (myWeather!.temperature3) + 32),
                     roundedOf(1.8 * (myWeather!.temperature4) + 32)
            ]
        }
    }
    
    //MARK: - WEATHER ICON
    
    var dailyWeatherIcons: [String] {
        return [ myWeather?.icon0 ?? "",
                 myWeather?.icon1 ?? "",
                 myWeather?.icon2 ?? "",
                 myWeather?.icon3 ?? "",
                 myWeather?.icon4 ?? ""
        ]
    }
    
    //MARK: - FUNCTIONS
    func roundedOf(_ roundOf: Double) -> String {
        return String(format: "%.0f°", roundOf)
    }
    
    func getWeatherIconFor(icon: String) -> Image {
           switch icon {
           case "01d":
               return Image("sun")
           case "01n":
               return Image("moon")
           case "02d":
               return Image("cloud")
           case "02n":
               return Image("cloud")
           case "03d":
               return Image("cloud")
           case "03n":
               return Image("cloud")
           case "04d":
               return Image("cloud")
           case "04n":
               return Image("cloud")
           case "09d":
               return Image("rainy")
           case "09n":
               return Image("rainy")
           case "10d":
               return Image("rainy")
           case "10n":
               return Image("rainy")
           case "11d":
               return Image("storm")
           case "11n":
               return Image("storm")
           case "13d":
               return Image("snow")
           case "13n":
               return Image("snow")
           case "50d":
               return Image("tornado")
           case "50n":
               return Image("tornado")
           default:
               return Image("sun")
           }
       }
}
