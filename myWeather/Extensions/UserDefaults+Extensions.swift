//
//  UserDefaults+Extensions.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/16/22.
//

import Foundation

extension UserDefaults {

    var unit: TemperatureUnit {
        guard let value = self.value(forKey: "unit") as? String else {
            return .celsius
        }
        return TemperatureUnit(rawValue: value) ?? .celsius
    }
}

enum TemperatureUnit: String, CaseIterable, Identifiable {
    
    var id: String {
        return rawValue
    }

    case celsius
    case fahrenheit
}

extension TemperatureUnit {

    var displayText: String {
        switch self {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
        }
    }
}
