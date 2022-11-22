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
        newForecast.date = [myWeather.dailyDates[0],
                            myWeather.dailyDates[1],
                            myWeather.dailyDates[2],
                            myWeather.dailyDates[3],
                            myWeather.dailyDates[4]]
        newForecast.temp = [myWeather.getTempByUnit(unit: Store().selectedUnit)[0],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[1],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[2],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[3],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[4]]
        newForecast.icon = [myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[4])]
        newForecast.iconS = [myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])]
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
        newCurrent.date = [myWeather.dailyDates[0],
                            myWeather.dailyDates[1],
                            myWeather.dailyDates[2],
                            myWeather.dailyDates[3],
                            myWeather.dailyDates[4]]
        newCurrent.temp = [myWeather.getTempByUnit(unit: Store().selectedUnit)[0],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[1],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[2],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[3],
                            myWeather.getTempByUnit(unit: Store().selectedUnit)[4]]
        newCurrent.icon = [myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3]),
                            myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[4])]
        newCurrent.iconS = [myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3]),
                             myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])]
        
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
        updateCurrent.date = [myWeather.dailyDates[0],
                              myWeather.dailyDates[1],
                              myWeather.dailyDates[2],
                              myWeather.dailyDates[3],
                              myWeather.dailyDates[4]]
        updateCurrent.temp = [myWeather.getTempByUnit(unit: Store().selectedUnit)[0],
                              myWeather.getTempByUnit(unit: Store().selectedUnit)[1],
                              myWeather.getTempByUnit(unit: Store().selectedUnit)[2],
                              myWeather.getTempByUnit(unit: Store().selectedUnit)[3],
                              myWeather.getTempByUnit(unit: Store().selectedUnit)[4]]
        updateCurrent.icon = [myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]),
                               myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[1]),
                               myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[2]),
                               myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[3]),
                               myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[4])]
        updateCurrent.iconS = [myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0]),
                               myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1]),
                               myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2]),
                               myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3]),
                               myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4])]
        
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
