//
//  WeatherCoreData.swift
//  myWeather
//
//  Created by eleazar.martinez on 10/17/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "WeatherModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func updateWeather() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    
    func deleteCard(weatherCard: WeatherCard) {
        
        persistentContainer.viewContext.delete(weatherCard)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func getAllWeatherCard() -> [WeatherCard] {
        
        let fetchRequest: NSFetchRequest<WeatherCard> = WeatherCard.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func saveWeatherCard(cityName: String, temp: String, date: String, icon: String) {
        
        let weatherCard = WeatherCard(context: persistentContainer.viewContext)
        weatherCard.cityName = cityName
        weatherCard.temp = temp
        weatherCard.date = date
        weatherCard.icon = icon
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save movie \(error)")
        }
        
    }
    
}
