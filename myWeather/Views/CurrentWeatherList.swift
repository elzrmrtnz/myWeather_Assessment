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
                URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                    .frame(width: 40, height: 40)

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
        CurrentWeatherList(myWeather: previewWeather)
    }
}
