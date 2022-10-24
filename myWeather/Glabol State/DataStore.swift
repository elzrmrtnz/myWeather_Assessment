//
//  DataStore.swift
//  MyToDos
//
//  Created by Stewart Lynch on 2021-04-07.
//

import Foundation

class DataStore: ObservableObject {
    
    @Published var selectedUnit: TemperatureUnit = .celsius
    @Published var currentW:[ForecastViewModel] = []
    
    init() {
        selectedUnit = UserDefaults.standard.unit
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: currentFile){
            loadCurrent()
        }
    }
    
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
        print("Saving toDos to file system")
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
