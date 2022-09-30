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
    
    @Published var loadingState: LoadingState = .none
    @Published var myWeather: MyWeather?
//    @Published var shouldShowLocationError: Bool = false
    
    
    let webService = WebService()
    
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
    
}
