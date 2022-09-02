//
//  LocationManager.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/11/22.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let webService = WebService()
    @Published var myWeather: MyWeather!

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        webService.getLocationBy(latitude: locations.last?.coordinate.latitude ?? 0, longitude: locations.last?.coordinate.longitude ?? 0) { result in
            switch result {
            case .success(let myWeather):
                if let myWeather = myWeather {
                    DispatchQueue.main.async {
                        self.myWeather = myWeather
//                        self.loadingState = .success
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
//                self.loadingState = .failed
            }
        }
        
    }
}


