//
//  AddCityViewModel.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/17/22.
//

import Foundation

class AddCityViewModel: ObservableObject {
    
    var city: String = ""
    
    func add(completion: @escaping (ForecastViewModel) -> Void) {
        
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

    func getTemperatureUnit(unit: TemperatureUnit) -> Double {
        switch unit {
            case .celsius:
                return myWeather.temperature0
            case .fahrenheit:
                return 1.8 * myWeather.temperature0 + 32
        }
    }

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
}
