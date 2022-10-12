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

    var cityName: String {
        return myWeather.city
    }

    var icon: String {
        return myWeather.icon0
    }

    var description: String {
        return myWeather.description0
    }

    var date: Date {
        return myWeather.date0
    }
    
    func getTempByUnit(unit: TemperatureUnit) -> String {
        switch unit {
        case .celsius:
            return roundedOf(myWeather.temperature0)
                     
        case .fahrenheit:
            return roundedOf(1.8 * (myWeather.temperature0) + 32)
        }
    }
    
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
               return String("shower")
           case "09n":
               return String("shower")
           case "10d":
               return String("rain")
           case "10n":
               return String("rain")
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
