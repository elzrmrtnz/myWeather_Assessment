//
//  CurrentDetail.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/17/22.
//

import SwiftUI

struct CurrentDetail: View {
    
//    let myWeather: ForecastViewModel?
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
                    
                    Text(forecast.date0!.formatAsString())
                        .font(.title2)
                    
                    HStack(alignment: .center){
                        Image(forecast.icon0!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text("\(forecast.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }//hstack
                    
                    Text(forecast.condition!.capitalized)
                        .font(.title3)
                    
                }//Vstack
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
                        DailyRow(logo: forecast.iconS0!,
                                 day: "Today",
                                 temp: "\(forecast.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()
                        
                        DailyRow(logo: forecast.iconS1!,
                                 day: forecast.date1!.formatAsString1(),
                                 temp: "\(forecast.temp1!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()
                        
                        DailyRow(logo: forecast.iconS2!,
                                 day: forecast.date2!.formatAsString1(),
                                 temp: "\(forecast.temp2!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        
                        Divider()
                        
                        DailyRow(logo: forecast.iconS3!,
                                 day: forecast.date3!.formatAsString1(),
                                 temp: "\(forecast.temp3!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        
                        Divider()
                        
                        DailyRow(logo: forecast.iconS4!,
                                 day: forecast.date4!.formatAsString1(),
                                 temp: "\(forecast.temp4!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                    }//vstack
                }
            }//ScrollView
        }//VStack
    }
}


struct CurrentDetail_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}

// MARK: - ForecastDetail

struct ForecastDetail: View {
    
//    let myWeather: ForecastViewModel?
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
                    
                    Text(forecast.date0!.formatAsString())
                        .font(.title2)
                    
                    HStack(alignment: .center){
                        Image(forecast.icon0!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        Text("\(forecast.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }//hstack
                    
                    Text(forecast.condition!.capitalized)
                        .font(.title3)
                    
                }//Vstack
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
                        DailyRow(logo: forecast.iconS0!,
                                 day: "Today",
                                 temp: "\(forecast.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()
                        
                        DailyRow(logo: forecast.iconS1!,
                                 day: forecast.date1!.formatAsString1(),
                                 temp: "\(forecast.temp1!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()
                        
                        DailyRow(logo: forecast.iconS2!,
                                 day: forecast.date2!.formatAsString1(),
                                 temp: "\(forecast.temp2!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        
                        Divider()
                        
                        DailyRow(logo: forecast.iconS3!,
                                 day: forecast.date3!.formatAsString1(),
                                 temp: "\(forecast.temp3!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        
                        Divider()
                        
                        DailyRow(logo: forecast.iconS4!,
                                 day: forecast.date4!.formatAsString1(),
                                 temp: "\(forecast.temp4!)°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                    }//vstack
                }
            }//ScrollView
        }//VStack
    }
}
