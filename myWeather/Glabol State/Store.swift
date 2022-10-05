//
//  Store.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/9/21.
//

import Foundation

class Store: ObservableObject {
    
    @Published var showingList: Bool = false

    @Published var selectedUnit: TemperatureUnit = .celsius
    @Published var weatherList: [ForecastListViewModel] = [ForecastListViewModel]()
    
    init() {
        selectedUnit = UserDefaults.standard.unit
    }
    
    func addWeather(_ myWeather: ForecastListViewModel) {
        weatherList.append(myWeather)
    }
    
}
