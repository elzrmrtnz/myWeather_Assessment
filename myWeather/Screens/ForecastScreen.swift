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
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                if forecastListVM.loadingState == .loading {
                    LoadingView()
                } else if forecastListVM.loadingState == .success {
                    ForecastListView(myWeather: self.forecastListVM.myWeather!)
                } else if forecastListVM.loadingState == .failed {
                    FailedView()
                }
                Spacer()
            }
            
            .onAppear {
                self.forecastListVM.getForecastByCity(city: self.city)
            }
        }
    }
}


