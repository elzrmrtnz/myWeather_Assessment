//
//  CurrentDetail.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/17/22.
//

import SwiftUI

struct CurrentDetail: View {
    
    let forecast: CurrentEntity
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // MARK: - Title
                
                VStack(alignment: .center) {
                    Text(forecast.city!)
                        .font(.title)
                        .bold()
                    
                    Text(forecast.date![0].formatAsString())
                        .font(.title2)
                    
                    HStack(alignment: .center){
                        Image(forecast.icon![0])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text("\(forecast.temp![0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }
                    
                    Text(forecast.condition!.capitalized)
                        .font(.title3)
                    
                }
                .padding()
                .foregroundColor(.accentColor)
                
                // MARK: - Detail
                
                CustomStackView {
                    Label {
                        Text("Details")
                    } icon: {
                        Image(systemName: "square.grid.2x2")
                    }
                    
                } contentView: {
                    HStack {
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunrise.fill", name: "Sunrise",
                                      value: forecast.sunrise!.formatAsString3())
                            
                            DetailRow(logo: "wind", name: "Wind speed",
                                      value: "\(forecast.wind!)m/s")
                            
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunset.fill", name: "Sunset",
                                      value: forecast.sunset!.formatAsString3())
                            
                            DetailRow(logo: "humidity", name: "Humidity",
                                      value: "\(forecast.humidity!)%")
                        }
                    }
                }
                
                // MARK: - 5-Day Forecast
                
                CustomStackView {
                    Label {
                        Text("5-Day Forecast")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    
                } contentView: {
                    VStack(spacing: 10) {
                        DailyRow(logo: forecast.iconS![0],
                                 day: "Today",
                                 temp: "\(forecast.temp![0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![1],
                                 day: forecast.date![1].formatAsString1(),
                                 temp: "\(forecast.temp![1])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![2],
                                 day: forecast.date![2].formatAsString1(),
                                 temp: "\(forecast.temp![2])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![3],
                                 day: forecast.date![3].formatAsString1(),
                                 temp: "\(forecast.temp![3])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![4],
                                 day: forecast.date![4].formatAsString1(),
                                 temp: "\(forecast.temp![4])°\(String(store.selectedUnit.displayText.prefix(1)))")
                    }
                }
            }
        }
    }
}

struct CurrentDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}

// MARK: - ForecastDetail

struct ForecastDetail: View {
    
    let forecast: ForecastEntity
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // MARK: - Title
                
                VStack(alignment: .center) {
                    Text(forecast.city!)
                        .font(.title)
                        .bold()
                    
                    Text(forecast.date![0].formatAsString())
                        .font(.title2)
                    
                    HStack(alignment: .center){
                        Image(forecast.icon![0])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text("\(forecast.temp![0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }
                    
                    Text(forecast.condition!.capitalized)
                        .font(.title3)
                    
                }
                .padding()
                .foregroundColor(.accentColor)
                
                // MARK: - Detail
                
                CustomStackView {
                    Label {
                        Text("Details")
                    } icon: {
                        Image(systemName: "square.grid.2x2")
                    }
                    
                } contentView: {
                    HStack {
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunrise.fill", name: "Sunrise",
                                      value: forecast.sunrise!.formatAsString3())
                            
                            DetailRow(logo: "wind", name: "Wind speed",
                                      value: "\(forecast.wind!)m/s")
                            
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunset.fill", name: "Sunset",
                                      value: forecast.sunset!.formatAsString3())
                            
                            DetailRow(logo: "humidity", name: "Humidity",
                                      value: "\(forecast.humidity!)%")
                        }
                    }
                }
                
                // MARK: - 5-Day Forecast
                
                CustomStackView {
                    Label {
                        Text("5-Day Forecast")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    
                } contentView: {
                    VStack(spacing: 10) {
                        DailyRow(logo: forecast.iconS![0],
                                 day: "Today",
                                 temp: "\(forecast.temp![0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![1],
                                 day: forecast.date![1].formatAsString1(),
                                 temp: "\(forecast.temp![1])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![2],
                                 day: forecast.date![2].formatAsString1(),
                                 temp: "\(forecast.temp![2])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![3],
                                 day: forecast.date![3].formatAsString1(),
                                 temp: "\(forecast.temp![3])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()
                        
                        DailyRow(logo: forecast.iconS![4],
                                 day: forecast.date![4].formatAsString1(),
                                 temp: "\(forecast.temp![4])°\(String(store.selectedUnit.displayText.prefix(1)))")
                    }
                }
            }
        }
    }
}
