//
//  DataController.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/14/22.
//

import Foundation
import CoreData

class DatabaseController {

    private init() {}

    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }


    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "DataModel")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

                //TODO: - Add Error Handling for Core Data

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }


        })
        return container
    }()

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

        }
    
    
    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                //You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    /* Support for GRUD Operations */

    // GET / Fetch / Requests
    class func getAllShows() -> Array<ForecastEntity> {
        let all = NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
        var allShows = [ForecastEntity]()

        do {
            let fetched = try DatabaseController.getContext().fetch(all)
            allShows = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return allShows
    }

    // Get Show by uuid
    class func getShowWith(uuid: String) -> ForecastEntity? {
        let requested = NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
        requested.predicate = NSPredicate(format: "uuid == %@", uuid)

        do {
            let fetched = try DatabaseController.getContext().fetch(requested)

            //fetched is an array we need to convert it to a single object
            if (fetched.count > 1) {
                //TODO: handle duplicate records
            } else {
                return fetched.first //only use the first object..
            }
        } catch {
            let nserror = error as NSError
            //TODO: Handle error
            print(nserror.description)
        }

        return nil
    }

    // REMOVE / Delete
    class func deleteShow(with uuid: String) -> Bool {
        let success: Bool = true

        let requested = NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
        requested.predicate = NSPredicate(format: "uuid == %@", uuid)


        do {
            let fetched = try DatabaseController.getContext().fetch(requested)
            for show in fetched {
                DatabaseController.getContext().delete(show)
            }
            return success
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return !success
    }
    
    // Delete ALL SHOWS From CoreData
    class func deleteAllShows() {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ForecastEntity")
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try DatabaseController.getContext().execute(deleteALL)
            DatabaseController.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }

}


