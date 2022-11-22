//
//  ForecastListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import SwiftUI

struct DetailScreen: View {
    
    @State var myWeather: ForecastViewModel!
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ForecastListView(myWeather: myWeather)
                
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
            .environmentObject(Store())
    }
}

// MARK: - CoreData

struct DetailCurrent: View {
    
    @State var forecast: CurrentEntity!
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                CurrentDetail(forecast: forecast)
                
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailForecast: View {

    @State var forecast: ForecastEntity!
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ForecastDetail(forecast: forecast)
                
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
    }
}

