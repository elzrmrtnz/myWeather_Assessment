//
//  CurrentViewModel.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/11/22.
//

import Foundation
import CoreLocation

class CurrentViewModel: ObservableObject {
    
    var location = LocationManager().location
    
    func getCurrent(completion: @escaping (ForecastViewModel) -> Void) {
        
        WebService().getCurrentW(latitude: location!.latitude, longitude: location!.longitude) { result in
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
