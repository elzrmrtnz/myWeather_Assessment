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
