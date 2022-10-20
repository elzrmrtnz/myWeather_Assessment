//
//  DataController.swift
//  myWeather
//
//  Created by eleazar.martinez on 10/13/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    @Published var weatherList: [ForecastViewModel] = []
    let container = NSPersistentContainer(name: "WeatherModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
//    func save(context: NSManagedObjectContext) {
//        do {
//            try context.save()
//            print("Data saved!!")
//        } catch {
//            print("We could not save the data..")
//        }
//    }

    func saveData(context: NSManagedObjectContext) {
        
        weatherList.forEach { (data) in
            
            let weatherCard = WeatherCard(context: context)
            weatherCard.cityName = data.cityName
            weatherCard.condition = data.description
            weatherCard.temp = data.temp
            weatherCard.icon = data.icon
            weatherCard.date = data.date
        }
            do {
                try context.save()
                print("Success")
            } catch {
        
                print(error.localizedDescription)
            }

//        save(context: context)
    }
}

//func addWeather(_ myWeather: ForecastViewModel, context: NSManagedObjectContext) {
//    weatherList.append(myWeather)
//
//    save(context: context)
//}
//
//func saveData(context: NSManagedObjectContext) {
//
//    weather.forEach { (data) in
//
//        let weatherCard = WeatherCard(context: context)
//        weatherCard.cityName = data.cityName
//        weatherCard.condition = data.description
//        weatherCard.temp = data.temp
//        weatherCard.icon = data.icon
//        weatherCard.date = data.date
//    }
//
//    do {
//        try context.save()
//        print("Success")
//    } catch {
//
//        print(error.localizedDescription)
//    }
//
//}
