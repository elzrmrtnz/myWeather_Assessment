//
//  ForecastListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import SwiftUI

struct DetailScreen: View {
    
    let city: String
    @ObservedObject var detailVM = DetailViewModel()
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                if detailVM.loadingState == .loading {
                    LoadingView()
                } else if detailVM.loadingState == .success {
                    ForecastListView(myWeather: detailVM)
                } else if detailVM.loadingState == .failed {
                    FailedView()
                }
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                self.detailVM.getForecastByCity(city: self.city)
            }
        }
        .navigationBarHidden(true)
    }
}


