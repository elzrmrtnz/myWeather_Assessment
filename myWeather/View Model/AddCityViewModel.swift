//
//  AddCityViewModel.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/17/22.
//

import Foundation


class AddCityViewModel: ObservableObject {
    
    var city: String = ""
    
    func getCity(completion: @escaping (ForecastViewModel) -> Void) {
        
        WebService().getForecastBy(city: city.trimmedAndEscaped()) { result in
            switch result {
            case .success(let myWeather):
                DispatchQueue.main.async {
                    completion(ForecastViewModel(myWeather: myWeather!))
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

struct ForecastViewModel {

    let myWeather: MyWeather

    let id = UUID()

    var city: String {
        return myWeather.city
    }

    var temperature0: Double {
        return myWeather.temperature0
    }

    var icon0: String {
        return myWeather.icon0
    }

    var description0: String {
        return myWeather.description0
    }

    var date0: Date {
        return myWeather.date0
    }
    
    func getTempByUnit(unit: TemperatureUnit) -> [String] {
        switch unit {
        case .celsius:
            return [ roundedOf(myWeather.temperature0),
                     roundedOf(myWeather.temperature1),
                     roundedOf(myWeather.temperature2),
                     roundedOf(myWeather.temperature3),
                     roundedOf(myWeather.temperature4)
            ]
        case .fahrenheit:
            return [ roundedOf(1.8 * (myWeather.temperature0) + 32),
                     roundedOf(1.8 * (myWeather.temperature1) + 32),
                     roundedOf(1.8 * (myWeather.temperature2) + 32),
                     roundedOf(1.8 * (myWeather.temperature3) + 32),
                     roundedOf(1.8 * (myWeather.temperature4) + 32)
            ]
        }
    }
    
    //MARK: - WEATHER ICON
    
    var dailyWeatherIcons: [String] {
        return [ myWeather.icon0,
                 myWeather.icon1,
                 myWeather.icon2,
                 myWeather.icon3,
                 myWeather.icon4
        ]
    }
    
    //MARK: - FUNCTIONS
    func roundedOf(_ roundOf: Double) -> String {
        return String(format: "%.0f", roundOf)
    }
    
    func getWeatherIconFor(icon: String) -> String {
           switch icon {
           case "01d":
               return String("sun")
           case "01n":
               return String("moon")
           case "02d":
               return String("fair")
           case "02n":
               return String("cloud-moon")
           case "03d":
               return String("cloud")
           case "03n":
               return String("cloud")
           case "04d":
               return String("cloud")
           case "04n":
               return String("cloud")
           case "09d":
               return String("rainy")
           case "09n":
               return String("rainy")
           case "10d":
               return String("rainy")
           case "10n":
               return String("rainy")
           case "11d":
               return String("storm")
           case "11n":
               return String("storm")
           case "13d":
               return String("snow")
           case "13n":
               return String("snow")
           case "50d":
               return String("tornado")
           case "50n":
               return String("tornado")
           default:
               return String("sun")
           }
       }
}
