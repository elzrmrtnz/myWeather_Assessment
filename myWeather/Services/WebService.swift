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


class WebService {
    
    func getForecastBy(search: String, completion: @escaping (Result<MyWeather?, NetworkError>) -> Void) {
        
        guard let url = URL.getForecastByCity(search)
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
            
            completion(.success(forecast.myWeather))
            
        }.resume()
        
    }
    
    func getLocationBy(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping ((Result<MyWeather?,  NetworkError>) -> Void)) {
        //    func getLocationBy(latitude: lat, longitude: lon, completion: @escaping ((Result<Forecast.City, NetworkError>) -> Void)) {
        
        guard let url = URL.getForecastByLocation(latitude: latitude, longitude: longitude)
        else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let forecast = try? JSONDecoder().decode(Forecast.self, from: data)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(forecast.myWeather))
            
        }.resume()
    }
}
