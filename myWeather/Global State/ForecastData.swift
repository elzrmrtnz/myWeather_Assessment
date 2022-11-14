//
//  CoreData.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/10/22.
//

import Foundation
import CoreData

class ForecastData: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntites: [ForecastEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchForecast()
    }
    
    func fetchForecast() {
        let request = NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
        
        do {
            savedEntites = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addForecast(_ myWeather: [ForecastViewModel]) {
        
        for weather in myWeather {
            let entity = NSEntityDescription.entity(forEntityName: "ShowModel", in: DatabaseController.getContext())
            let newWeather = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())

            // Create a unique ID for the Show.
            let uuid = UUID()
            // Set the data to the entity
            newWeather.setValue(weather.cityName, forKey: "name")
            newWeather.setValue(weather.description, forKey: "condition")
            newWeather.setValue(weather.sunset, forKey: "sunset")
            newWeather.setValue(weather.sunrise, forKey: "sunrise")
            newWeather.setValue(weather.currentHumidity, forKey: "humidity")
            newWeather.setValue(weather.currentWind, forKey: "wind")
            newWeather.setValue(weather.dailyDates[0], forKey: "date0")
            newWeather.setValue(weather.dailyDates[1], forKey: "date1")
            newWeather.setValue(weather.dailyDates[2], forKey: "date2")
            newWeather.setValue(weather.dailyDates[3], forKey: "date3")
            newWeather.setValue(weather.dailyDates[4], forKey: "date4")
            newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[0], forKey: "temp0")
            newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[1], forKey: "temp1")
            newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[2], forKey: "temp2")
            newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[3], forKey: "temp3")
            newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[4], forKey: "temp4")
            newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[0]), forKey: "icon0")
            newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[1]), forKey: "icon1")
            newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[2]), forKey: "icon2")
            newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[3]), forKey: "icon3")
            newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[4]), forKey: "icon4")
            newWeather.setValue(uuid.uuidString, forKey: "uuid")
        }
//        let newForecast = ForecastEntity(context: container.viewContext)
//
//        newForecast.city = myWeather.cityName
//        newForecast.condition = myWeather.description
//        newForecast.sunrise = myWeather.sunrise
//        newForecast.sunset = myWeather.sunset
//        newForecast.humidity = myWeather.currentHumidity
//        newForecast.wind = myWeather.currentWind
//        newForecast.date0 = myWeather.dailyDates[0]
//        newForecast.date1 = myWeather.dailyDates[1]
//        newForecast.date2 = myWeather.dailyDates[2]
//        newForecast.date3 = myWeather.dailyDates[3]
//        newForecast.date4 = myWeather.dailyDates[4]
//        newForecast.temp0 = myWeather.getTempByUnit(unit: Store().selectedUnit)[0]
//        newForecast.temp1 = myWeather.getTempByUnit(unit: Store().selectedUnit)[1]
//        newForecast.temp2 = myWeather.getTempByUnit(unit: Store().selectedUnit)[2]
//        newForecast.temp3 = myWeather.getTempByUnit(unit: Store().selectedUnit)[3]
//        newForecast.temp4 = myWeather.getTempByUnit(unit: Store().selectedUnit)[4]
//        newForecast.icon0 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0])
//        newForecast.icon1 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1])
//        newForecast.icon2 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2])
//        newForecast.icon3 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3])
//        newForecast.icon4 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[4])
        
        saveForecast()
    }
    
//    func updateForecast(entity: ForecastEntity) {
//        guard let index = savedEntities.firstIndex(where: { $0.id == forecast.id}) else { return }
//        savedEntities[index] = forecast
//    }
    
    func deleteForecast(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntites[index]
        container.viewContext.delete(entity)
        saveForecast()
    }
    
    func saveForecast() {
        do {
            try container.viewContext.save()
            fetchForecast()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}
