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
                Text("\(myWeather.dailyDates[0].formatAsString2())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke()).background(.ultraThickMaterial)
        .cornerRadius(15)
    }
}

struct CurrentWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}

struct WeatherCell: View {

    @EnvironmentObject var store: Store
    let forecast: ForecastEntity

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(forecast.city!)
                        .font(.title3)
                        .fontWeight(.bold)

                    Text(" ")
                        .font(.system(size: 13))
                }
                Spacer()
                Text("\(forecast.date0!.formatAsString2())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(forecast.icon0!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)

                    Text("\(forecast.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(forecast.condition!.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke()).background(.ultraThickMaterial)
        .cornerRadius(15)
    }
}

struct WeatherCellTest: View {

    @EnvironmentObject var store: Store
    let forecast: CurrentEntity

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("My Location")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text(forecast.city!)
                        .font(.system(size: 13))
                }
                Spacer()
                Text("\(forecast.date0!.formatAsString2())")
                    .font(.system(size: 15))
            }//Vstack
            Spacer()
            VStack {
                HStack {
                    Image(forecast.icon0!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)

                    Text("\(forecast.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))")
                        .font(.title3)
                }
                Spacer()
                Text(forecast.condition!.capitalized)
                    .font(.system(size: 15))
            }
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke()).background(.ultraThickMaterial)
        .cornerRadius(15)
    }
}
