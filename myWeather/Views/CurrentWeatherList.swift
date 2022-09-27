//
//  CurrentWeatherList.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/19/22.
//

import SwiftUI

struct CurrentWeatherList: View {
    
    let myWeather: MyWeather
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(myWeather.city)
                    .fontWeight(.bold)
                HStack {
                    Text("\(myWeather.date0.formatAsString2())")
                }
                HStack {
                    Text("\(myWeather.description0.capitalized)")
                }
            }//Vstack
            Spacer()
            URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                .frame(width: 50, height: 50)

            Text(String(format: "%.0f°", myWeather.temperature0))
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke())
    }
}

struct CurrentWeatherList_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherList(myWeather: previewWeather)
    }
}
