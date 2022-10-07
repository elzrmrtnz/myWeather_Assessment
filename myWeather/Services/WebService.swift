//
//  WebService.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import Foundation
import CoreLocation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class WebService: NSObject {
    
    private let locationManager = CLLocationManager()
//    private var completionHandler: ((MyWeather?, LocationAuthError?) -> Void)?
    private var dataTask: URLSessionDataTask?

// MARK: - Get Forecast By Location

    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastViewModel {
        
        guard let url = URL.getForecastByLocation(latitude: latitude, longitude: longitude)
        else { fatalError("Missing URL") }


        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let forecast = try JSONDecoder().decode(Forecast.self, from: data)
        
        return ForecastViewModel(myWeather: MyWeather(forecast: forecast))
    }
    
// MARK: - Get Forecst by City Name

    func getForecastBy(city: String, completion: @escaping (Result<MyWeather?, NetworkError>) -> Void) {
        
        guard let url = URL.getForecastByCity(city)
        else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let forecast = try? JSONDecoder().decode(Forecast.self, from: data)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(MyWeather(forecast: forecast)))
            
        }.resume()
        
    }
      
  }
    
//    func getLocationBy(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping ((Result<MyWeather?,  NetworkError>) -> Void)) {
//        //    func getLocationBy(latitude: lat, longitude: lon, completion: @escaping ((Result<Forecast.City, NetworkError>) -> Void)) {
//
//        guard let url = URL.getForecastByLocation(latitude: latitude, longitude: longitude)
//        else {
//            return completion(.failure(.badURL))
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                return completion(.failure(.noData))
//            }
//
//            guard let forecast = try? JSONDecoder().decode(Forecast.self, from: data)
//            else {
//                return completion(.failure(.decodingError))
//            }
//
//            completion(.success(MyWeather(forecast: forecast)))
//
//        }.resume()
//    }
//}

//public override init() {
//      super.init()
//      locationManager.delegate = self
//    }
//
//    public func loadWeatherData(
//      _ completionHandler: @escaping((MyWeather?, LocationAuthError?) -> Void)
//    ) {
//      self.completionHandler = completionHandler
//      loadDataOrRequestLocationAuth()
//    }
//
//    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
//        guard let url = URL.getForecastByLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
//        else {
//            return
//        }
//
//      URLSession.shared.dataTask(with: url) { data, response, error in
//
//        guard error == nil, let data = data else { return }
//
//        guard let forecast = try? JSONDecoder().decode(Forecast.self, from: data)
//        else {
//            return
//        }
//
//          self.completionHandler?(MyWeather(forecast: forecast), nil)
//
//      }.resume()
//    }
//
//    private func loadDataOrRequestLocationAuth() {
//      switch locationManager.authorizationStatus {
//      case .authorizedAlways, .authorizedWhenInUse:
//        locationManager.startUpdatingLocation()
//      case .denied, .restricted:
//        completionHandler?(nil, LocationAuthError())
//      default:
//        locationManager.requestWhenInUseAuthorization()
//      }
//    }
//  }
//
//  extension WebService: CLLocationManagerDelegate {
//    public func locationManager(
//      _ manager: CLLocationManager,
//      didUpdateLocations locations: [CLLocation]
//    ) {
//      guard let location = locations.first else { return }
//        makeDataRequest(forCoordinates: location.coordinate)
//    }
//
//    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//      loadDataOrRequestLocationAuth()
//    }
//    public func locationManager(
//      _ manager: CLLocationManager,
//      didFailWithError error: Error
//    ) {
//      print("Something went wrong: \(error.localizedDescription)")
//    }
//
//  }
//      public struct LocationAuthError: Error {}
