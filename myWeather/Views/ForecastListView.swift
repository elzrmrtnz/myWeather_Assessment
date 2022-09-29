//
//  ForecastListView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/11/22.
//

import SwiftUI

struct ForecastListView: View {
    
    let myWeather: MyWeather
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // MARK: - Title

                VStack(alignment: .center) {
                    Text(myWeather.city)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text(myWeather.date0.formatAsString())
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    HStack(alignment: .center){
                        URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                            .frame(width: 50, height: 50)
                        
                        Text(String(format: "%.0f°", myWeather.temperature0))
                            .font(.system(size: 50))
                    }//hstack
                    
                    Text(myWeather.description0.capitalized)
                        .font(.title3)
                    
                }//Vstack
                .padding()
                .foregroundColor(.white)
                
                // MARK: - Detail

                CustomStackView {
                    Label {
                        Text("Details")
                    } icon: {
                        Image(systemName: "square.grid.2x2")
                    }
                    
                } contentView: {
                    VStack {
                        HStack {
                            DetailRow(logo: "thermometer", name: "Min temp",
                                      value: (String(format: "%.0f˚", myWeather.tempMin0)))
                            Spacer()
                            DetailRow(logo: "thermometer", name: "Max temp",
                                      value: (String(format: "%.0f˚", myWeather.tempMax0)))
                        }
                        
                        HStack {
                            DetailRow(logo: "wind", name: "Wind speed",
                                      value: (String(format: "%.0fm/s", myWeather.speed)))
                            
                            Spacer()
                            DetailRow(logo: "humidity", name: "Humidity",
                                      value: (String(format: "%.0f%%", myWeather.hum)))
                        }
                    }
                }
                
                // MARK: - 5dayForecast

                CustomStackView {
                    Label {
                        Text("5-Day Forecast")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    
                } contentView: {
                    VStack(alignment: .center, spacing: 10) {
                        DailyRow(logo: URL.weatherIcon(icon: myWeather.icon0),
                                 day: "Today",
                                 max: String(format: "Max: %.0f˚", myWeather.tempMax0),
                                 min: String(format: "Min: %.0f˚", myWeather.tempMin0)
                        )
                        Divider()
                        
                        DailyRow(logo: URL.weatherIcon(icon: myWeather.icon1),
                                 day: myWeather.date1.formatAsString1(),
                                 max: String(format: "Max: %.0f˚", myWeather.tempMax1),
                                 min: String(format: "Min: %.0f˚", myWeather.tempMin1))
                        Divider()
                        
                        DailyRow(logo: URL.weatherIcon(icon: myWeather.icon2),
                                 day: myWeather.date2.formatAsString1(),
                                 max: String(format: "Max: %.0f˚", myWeather.tempMax2),
                                 min: String(format: "Min: %.0f˚", myWeather.tempMin2)
                        )
                        
                        Divider()
                        
                        DailyRow(logo: URL.weatherIcon(icon: myWeather.icon3),
                                 day: myWeather.date3.formatAsString1(),
                                 max: String(format: "Max: %.0f˚", myWeather.tempMax3),
                                 min: String(format: "Min: %.0f˚", myWeather.tempMin3)
                        )
                        
                        Divider()
                        
                        DailyRow(logo: URL.weatherIcon(icon: myWeather.icon4),
                                 day: myWeather.date4.formatAsString1(),
                                 max: String(format: "Max: %.0f˚", myWeather.tempMax4),
                                 min: String(format: "Min: %.0f˚", myWeather.tempMin4)
                        )
                    }//vstack
                }
            }//ScrollView
        }//VStack
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastListView(myWeather: previewWeather)
    }
}
