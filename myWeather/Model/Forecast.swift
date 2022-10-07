//
//  Forecast.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import Foundation

struct Forecast: Codable {
    let city: City
    let list: [DateList]
}

struct City: Codable {
    let name: String
    let sunrise: Date
    let sunset: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sunriseTimeInterval = try container.decode(Int32.self, forKey: .sunrise)
        let sunsetTimeInterval = try container.decode(Int32.self, forKey: .sunset)
        sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseTimeInterval))
        sunset = Date(timeIntervalSince1970: TimeInterval(sunsetTimeInterval))
        name = try container.decode(String.self, forKey: .name)
    }
}

struct DateList: Codable {
    let dt: Date
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dtTimeInterval = try container.decode(Int32.self, forKey: .dt)
        dt = Date(timeIntervalSince1970: TimeInterval(dtTimeInterval))
        main = try container.decode(Main.self, forKey: .main)
        weather = try container.decode([Weather].self, forKey: .weather)
        wind = try container.decode(Wind.self, forKey: .wind)
    }
}

struct Main: Codable {
    let temp: Double
    let max: Double
    let min: Double
    let hum: Double

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case max = "temp_max"
        case min = "temp_min"
        case hum = "humidity"
    }
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

struct MyWeather: Codable {
    let city: String
    let sunrise: Date
    let sunset: Date
    let temperature0: Double
    let tempMax0: Double
    let tempMin0: Double
    let id: Int
    let hum: Double
    let speed: Double
    let icon0: String
    let description0: String
    let date0: Date

    let temperature1: Double
    let tempMax1: Double
    let tempMin1: Double
    let icon1: String
    let description1: String
    let date1: Date

    let temperature2: Double
    let tempMax2: Double
    let tempMin2: Double
    let icon2: String
    let description2: String
    let date2: Date

    let temperature3: Double
    let tempMax3: Double
    let tempMin3: Double
    let icon3: String
    let description3: String
    let date3: Date

    let temperature4: Double
    let tempMax4: Double
    let tempMin4: Double
    let icon4: String
    let description4: String
    let date4: Date

    init(forecast: Forecast) {
        city = forecast.city.name
        sunrise = forecast.city.sunrise
        sunset = forecast.city.sunset
        temperature0 = forecast.list[0].main.temp
        tempMax0 = forecast.list[0].main.max
        tempMin0 = forecast.list[0].main.min
        id = forecast.list[0].weather[0].id
        hum = forecast.list[0].main.hum
        speed = forecast.list[0].wind.speed
        icon0 = forecast.list[0].weather[0].icon
        description0 = forecast.list[0].weather[0].description
        date0 = forecast.list[0].dt

        temperature1 = forecast.list[8].main.temp
        tempMax1 = forecast.list[8].main.max
        tempMin1 = forecast.list[8].main.min
        icon1 = forecast.list[8].weather[0].icon
        description1 = forecast.list[8].weather[0].description
        date1 = forecast.list[8].dt

        temperature2 = forecast.list[16].main.temp
        tempMax2 = forecast.list[16].main.max
        tempMin2 = forecast.list[16].main.min
        icon2 = forecast.list[16].weather[0].icon
        description2 = forecast.list[16].weather[0].description
        date2 = forecast.list[16].dt

        temperature3 = forecast.list[24].main.temp
        tempMax3 = forecast.list[24].main.max
        tempMin3 = forecast.list[24].main.min
        icon3 = forecast.list[24].weather[0].icon
        description3 = forecast.list[24].weather[0].description
        date3 = forecast.list[24].dt

        temperature4 = forecast.list[32].main.temp
        tempMax4 = forecast.list[32].main.max
        tempMin4 = forecast.list[32].main.min
        icon4 = forecast.list[32].weather[0].icon
        description4 = forecast.list[32].weather[0].description
        date4 = forecast.list[32].dt
    }
}
