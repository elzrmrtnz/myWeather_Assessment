//
//  Store.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/9/21.
//

import Foundation

class Store: ObservableObject {
    
    @Published var selectedUnit: TemperatureUnit = .celsius
    @Published var weatherList: [ForecastViewModel] = []
    @Published var currentW: [ForecastViewModel] = []
    
    init() {
        selectedUnit = UserDefaults.standard.unit
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: weatherFile){
            loadWeather()
        }
        if FileManager().docExist(named: currentFile){
            loadCurrent()
        }
    }
    
    func addWeather(_ myWeather: ForecastViewModel) {
        weatherList.append(myWeather)
        saveWeather()
    }
    
    func updateWeather(_ myWeather: ForecastViewModel) {
        guard let index = weatherList.firstIndex(where: { $0.id == myWeather.id}) else { return }
        weatherList[index] = myWeather
        saveWeather()
    }
    
    func deleteWeather(at indexSet: IndexSet) {
        weatherList.remove(atOffsets: indexSet)
        saveWeather()
    }
    
    func loadWeather() {
        FileManager().readDocument(docName: weatherFile) { (result) in
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
        print("Saving weatherList to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(weatherList)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: weatherFile) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Current

    func addCurrent(_ myWeather: ForecastViewModel) {
        currentW.append(myWeather)
        saveCurrent()
    }
    
    func updateCurrent(_ myWeather: ForecastViewModel) {
        guard let index = currentW.firstIndex(where: { $0.id == myWeather.id}) else { return }
        currentW[index] = myWeather
        saveCurrent()
    }
    
    func deleteCurrent(at indexSet: IndexSet) {
        currentW.remove(atOffsets: indexSet)
        saveCurrent()
    }
    
    func loadCurrent() {
        FileManager().readDocument(docName: currentFile) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    currentW = try decoder.decode([ForecastViewModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveCurrent() {
        print("Saving currentW to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(currentW)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: currentFile) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

