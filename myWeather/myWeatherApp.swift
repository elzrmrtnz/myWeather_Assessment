//
//  myWeatherApp.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import SwiftUI

@main
struct myWeatherApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ListScreen()
                .environmentObject(Store())
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
