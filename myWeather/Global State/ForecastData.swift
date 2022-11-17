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
    @Published var forecastList: [ForecastEntity] = []
    @Published var current: [CurrentEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            }
        }
        fetchForecast()
        fetchCurrent()
    }
    
    func fetchForecast() {
        let request = NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
        
        do {
            forecastList = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addForecast(_ myWeather: ForecastViewModel) {
        let newForecast = ForecastEntity(context: container.viewContext)
        let uuid = UUID()
        
        newForecast.uuid = uuid.uuidString
        newForecast.city = myWeather.cityName
        newForecast.condition = myWeather.description
        newForecast.sunrise = myWeather.sunrise
        newForecast.sunset = myWeather.sunset
        newForecast.humidity = myWeather.currentHumidity
        newForecast.wind = myWeather.currentWind
        newForecast.date0 = myWeather.dailyDates[0]
        newForecast.date1 = myWeather.dailyDates[1]
        newForecast.date2 = myWeather.dailyDates[2]
        newForecast.date3 = myWeather.dailyDates[3]
        newForecast.date4 = myWeather.dailyDates[4]
        newForecast.temp0 = myWeather.getTempByUnit(unit: Store().selectedUnit)[0]
        newForecast.temp1 = myWeather.getTempByUnit(unit: Store().selectedUnit)[1]
        newForecast.temp2 = myWeather.getTempByUnit(unit: Store().selectedUnit)[2]
        newForecast.temp3 = myWeather.getTempByUnit(unit: Store().selectedUnit)[3]
        newForecast.temp4 = myWeather.getTempByUnit(unit: Store().selectedUnit)[4]
        newForecast.icon0 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0])
        newForecast.icon1 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1])
        newForecast.icon2 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2])
        newForecast.icon3 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3])
        newForecast.icon4 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])
        newForecast.iconS0 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0])
        newForecast.iconS1 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1])
        newForecast.iconS2 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2])
        newForecast.iconS3 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3])
        newForecast.iconS4 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])
        
        saveForecast()
    }
    
//    func updateWeather(_ myWeather: ForecastViewModel) {
//        guard let index = savedEntites.firstIndex(where: { $0.id == myWeather.id}) else { return }
//        savedEntites[index] = myWeather
//        saveForecast()
//    }
    
    func deleteForecast(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = forecastList[index]
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
    
    
    // MARK: - Current

    
    func fetchCurrent() {
        let request = NSFetchRequest<CurrentEntity>(entityName: "CurrentEntity")
        
        do {
            current = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addCurrent(_ myWeather: ForecastViewModel) {
        let newCurrent = CurrentEntity(context: container.viewContext)
        let uuid = UUID()
        
        newCurrent.uuid = uuid.uuidString
        newCurrent.city = myWeather.cityName
        newCurrent.condition = myWeather.description
        newCurrent.sunrise = myWeather.sunrise
        newCurrent.sunset = myWeather.sunset
        newCurrent.humidity = myWeather.currentHumidity
        newCurrent.wind = myWeather.currentWind
        newCurrent.date0 = myWeather.dailyDates[0]
        newCurrent.date1 = myWeather.dailyDates[1]
        newCurrent.date2 = myWeather.dailyDates[2]
        newCurrent.date3 = myWeather.dailyDates[3]
        newCurrent.date4 = myWeather.dailyDates[4]
        newCurrent.temp0 = myWeather.getTempByUnit(unit: Store().selectedUnit)[0]
        newCurrent.temp1 = myWeather.getTempByUnit(unit: Store().selectedUnit)[1]
        newCurrent.temp2 = myWeather.getTempByUnit(unit: Store().selectedUnit)[2]
        newCurrent.temp3 = myWeather.getTempByUnit(unit: Store().selectedUnit)[3]
        newCurrent.temp4 = myWeather.getTempByUnit(unit: Store().selectedUnit)[4]
        newCurrent.icon0 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0])
        newCurrent.icon1 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1])
        newCurrent.icon2 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2])
        newCurrent.icon3 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3])
        newCurrent.icon4 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])
        newCurrent.iconS0 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0])
        newCurrent.iconS1 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1])
        newCurrent.iconS2 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2])
        newCurrent.iconS3 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3])
        newCurrent.iconS4 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])
        
        saveCurrent()
    }
    
    func updateWeather(_ myWeather: ForecastViewModel) {
        let updateCurrent = CurrentEntity(context: container.viewContext)
        let uuid = UUID()
        
        updateCurrent.uuid = uuid.uuidString
        updateCurrent.city = myWeather.cityName
        updateCurrent.condition = myWeather.description
        updateCurrent.sunrise = myWeather.sunrise
        updateCurrent.sunset = myWeather.sunset
        updateCurrent.humidity = myWeather.currentHumidity
        updateCurrent.wind = myWeather.currentWind
        updateCurrent.date0 = myWeather.dailyDates[0]
        updateCurrent.date1 = myWeather.dailyDates[1]
        updateCurrent.date2 = myWeather.dailyDates[2]
        updateCurrent.date3 = myWeather.dailyDates[3]
        updateCurrent.date4 = myWeather.dailyDates[4]
        updateCurrent.temp0 = myWeather.getTempByUnit(unit: Store().selectedUnit)[0]
        updateCurrent.temp1 = myWeather.getTempByUnit(unit: Store().selectedUnit)[1]
        updateCurrent.temp2 = myWeather.getTempByUnit(unit: Store().selectedUnit)[2]
        updateCurrent.temp3 = myWeather.getTempByUnit(unit: Store().selectedUnit)[3]
        updateCurrent.temp4 = myWeather.getTempByUnit(unit: Store().selectedUnit)[4]
        updateCurrent.icon0 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0])
        updateCurrent.icon1 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1])
        updateCurrent.icon2 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2])
        updateCurrent.icon3 = myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3])
        updateCurrent.icon4 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])
        updateCurrent.iconS0 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0])
        updateCurrent.iconS1 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1])
        updateCurrent.iconS2 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2])
        updateCurrent.iconS3 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3])
        updateCurrent.iconS4 = myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])
        
        guard let index = current.firstIndex(where: { $0.id == updateCurrent.id}) else { return }
        current[index] = updateCurrent
        saveForecast()
    }
    
    func deleteCurrent(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = current[index]
        container.viewContext.delete(entity)
        saveCurrent()
    }
    
    func saveCurrent() {
        do {
            try container.viewContext.save()
            fetchCurrent()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}


//for weather in myWeather {
//    let entity = NSEntityDescription.entity(forEntityName: "ShowModel", in: DatabaseController.getContext())
//    let newWeather = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
//
//    // Create a unique ID for the Show.
//    let uuid = UUID()
//    // Set the data to the entity
//    newWeather.setValue(weather.cityName, forKey: "name")
//    newWeather.setValue(weather.description, forKey: "condition")
//    newWeather.setValue(weather.sunset, forKey: "sunset")
//    newWeather.setValue(weather.sunrise, forKey: "sunrise")
//    newWeather.setValue(weather.currentHumidity, forKey: "humidity")
//    newWeather.setValue(weather.currentWind, forKey: "wind")
//    newWeather.setValue(weather.dailyDates[0], forKey: "date0")
//    newWeather.setValue(weather.dailyDates[1], forKey: "date1")
//    newWeather.setValue(weather.dailyDates[2], forKey: "date2")
//    newWeather.setValue(weather.dailyDates[3], forKey: "date3")
//    newWeather.setValue(weather.dailyDates[4], forKey: "date4")
//    newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[0], forKey: "temp0")
//    newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[1], forKey: "temp1")
//    newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[2], forKey: "temp2")
//    newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[3], forKey: "temp3")
//    newWeather.setValue(weather.getTempByUnit(unit: Store().selectedUnit)[4], forKey: "temp4")
//    newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[0]), forKey: "icon0")
//    newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[1]), forKey: "icon1")
//    newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[2]), forKey: "icon2")
//    newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[3]), forKey: "icon3")
//    newWeather.setValue(weather.getIconFor(icon: weather.dailyWeatherIcons[4]), forKey: "icon4")
//    newWeather.setValue(uuid.uuidString, forKey: "uuid")
//}
