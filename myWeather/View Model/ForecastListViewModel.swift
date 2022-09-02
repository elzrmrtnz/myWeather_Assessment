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

class ForecastListViewModel: ObservableObject {
    
    @Published var loadingState: LoadingState = .none
    @Published var myWeather: MyWeather!
    
    let webService = WebService()
    let locationManager = CLLocationManager()
    
    func searchByCity(_ city: String) {
        
        if city.isEmpty {
            return
        }
        
        self.loadingState = .loading
        
        webService.getForecastBy(search: city.trimmedAndEscaped()) { result in
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
    
    func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
            webService.getLocationBy(latitude: latitude, longitude: longitude) { result in
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
