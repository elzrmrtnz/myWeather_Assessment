//
//  ForecastListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import SwiftUI

struct ForecastScreen: View {
    
    let city: String
    @ObservedObject var forecastListVM = ForecastListViewModel()
    
    var body: some View {
        VStack {
            
            if forecastListVM.loadingState == .loading {
                LoadingView()
            } else if forecastListVM.loadingState == .success {
                ForecastListView(myWeather: self.forecastListVM.myWeather!)
            } else if forecastListVM.loadingState == .failed {
                FailedView()
            }
            
        }
        
        .onAppear {
            self.forecastListVM.getForecastByCity(city: self.city)
        }
    }
}


