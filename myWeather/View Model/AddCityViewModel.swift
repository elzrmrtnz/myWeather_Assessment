//
//  AddCityViewModel.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/17/22.
//

import Foundation

class AddCityViewModel: ObservableObject {
    
    var city: String = ""
    
    func getCity(completion: @escaping (ForecastViewModel) -> Void) {
        
        WebService().getForecastBy(city: city.trimmedAndEscaped()) { result in
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
