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
        
        WebService().getForecastBy(search: city) { result in
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
