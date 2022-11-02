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
            TabView {
            LocWeatherScreen()
                    .environmentObject(Store())
                    .tabItem {
                        Image(systemName: "location.fill")
                    }
                
            ListScreen()
                .environmentObject(Store())
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            }
        }
    }
}
