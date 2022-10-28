//
//  myWeatherApp.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import SwiftUI

@main
struct myWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ListScreen()
                .environmentObject(Store())
//                .environmentObject(DataStore())
        }
    }
}
