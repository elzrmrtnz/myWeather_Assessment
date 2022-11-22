//
//  URL+Extensions.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import Foundation
import CoreLocation

extension URL {
    
    static func getForecastByCity(_ city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=4ca353c709486a3fbf0544bacbef1862&units=metric")
    }
    
    static func getForecastByLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=4ca353c709486a3fbf0544bacbef1862&units=metric")
    }
    
    static func weatherIcon(icon: String) -> String {
        return "https://openweathermap.org/img/w/\(icon).png"
    }
    
}
