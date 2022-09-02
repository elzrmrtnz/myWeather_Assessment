//
//  ForecastViewModel.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import Foundation

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
