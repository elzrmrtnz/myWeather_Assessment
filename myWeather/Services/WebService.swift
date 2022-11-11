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
    
    
    func getCurrentW(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<MyWeather?, NetworkError>) -> Void) {
        
        guard let url = URL.getForecastByLocation(latitude: latitude, longitude: longitude)
        else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            guard let forecast = try? JSONDecoder().decode(Forecast.self, from: data!)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(MyWeather(forecast: forecast)))
            
        }.resume()
    }
        
    
    
  }
