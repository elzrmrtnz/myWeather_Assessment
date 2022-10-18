//
//  CurrentWeatherList.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/19/22.
//

import SwiftUI

struct CurrentWeatherCell: View {
    
    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                Text("My Location")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(myWeather.cityName)
                    .font(.system(size: 13))
                }
                Spacer()
                Text("\(myWeather.date.formatAsString2())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getWeatherIconFor(icon: myWeather.icon))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit))°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke())
    }
}

struct CurrentWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen(coreDM: CoreDataManager())
    }
}

struct WeatherCell: View {
    
    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(myWeather.cityName)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(" ")
                        .font(.system(size: 13))
                }
                Spacer()
                Text("\(myWeather.date.formatAsString2())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getWeatherIconFor(icon: myWeather.icon))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit))°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke())
    }
}
