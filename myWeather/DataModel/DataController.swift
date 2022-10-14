//
//  DataController.swift
//  myWeather
//
//  Created by eleazar.martinez on 10/13/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    @Published var weatherList: [ForecastViewModel] = [ForecastViewModel]()
    let container = NSPersistentContainer(name: "WeatherModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!!")
        } catch {
            print("We could not save the data..")
        }
    }

    func addWeatherCard(cityName: String, context: NSManagedObjectContext) {
        let weatherCard = WeatherCard(context: context)
        weatherCard.id = UUID()
        weatherCard.date = String()
        weatherCard.icon = String()
        weatherCard.temp = String()
        weatherCard.cityName = cityName
        
        
        save(context: context)
    }

    func addWeather(_ myWeather: ForecastViewModel, context: NSManagedObjectContext) {
        weatherList.append(myWeather)
        
        save(context: context)
    }
}
