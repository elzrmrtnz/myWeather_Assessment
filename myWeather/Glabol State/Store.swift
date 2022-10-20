//
//  Store.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/9/21.
//

import Foundation

class Store: ObservableObject {
    
    @Published var selectedUnit: TemperatureUnit = .celsius
    @Published var weatherList:[ForecastViewModel] = []
    
    init() {
        selectedUnit = UserDefaults.standard.unit
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName){
            loadWeather()
        }
    }
    
    func addWeather(_ myWeather: ForecastViewModel) {
        weatherList.append(myWeather)
        saveWeather()
    }
    
    func updateToDo(_ myWeather: ForecastViewModel) {
        guard let index = weatherList.firstIndex(where: { $0.id == myWeather.id}) else { return }
        weatherList[index] = myWeather
        saveWeather()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        weatherList.remove(atOffsets: indexSet)
        saveWeather()
    }
    
    func loadWeather() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    weatherList = try decoder.decode([ForecastViewModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveWeather() {
        print("Saving toDos to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(weatherList)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
