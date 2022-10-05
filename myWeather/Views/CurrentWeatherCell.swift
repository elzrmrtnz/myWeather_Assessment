//
//  CurrentWeatherList.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/19/22.
//

import SwiftUI

struct CurrentWeatherCell: View {
    
    @ObservedObject var forecastListVM = ForecastListViewModel()
    let myWeather: MyWeather
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 0) {
                Text("My Location")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(myWeather.city)
                    .font(.system(size: 12))
                }
                
                Text("\(myWeather.date0.formatAsString2())")
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    forecastListVM.getWeatherIconFor(icon: forecastListVM.dailyWeatherIcons[0])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)

                Text(String(format: "%.0f°", myWeather.temperature0))
                        .font(.system(size: 30))
                }
                Text("\(myWeather.description0.capitalized)")
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke())
    }
}

struct CurrentWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherCell(myWeather: previewWeather)
    }
}

struct WeatherCell: View {
    
    @EnvironmentObject var store: Store
    let myWeather: ForecastListViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(myWeather.currentCity)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(" ")
                        .font(.system(size: 12))
                }
                
                Text("\(myWeather.date)")
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    myWeather.getWeatherIconFor(icon: myWeather.dailyWeatherIcons[0])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])")
//                        .fontWeight(.bold)
//                        .font(.largeTitle)
                }
                Text(myWeather.description!)
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke())
    }
}
