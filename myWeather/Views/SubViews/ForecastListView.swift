//
//  ForecastListView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/11/22.
//

import SwiftUI

struct ForecastListView: View {
    
    let myWeather: ForecastViewModel

    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // MARK: - Title

                VStack(alignment: .center) {
                    Text(myWeather.cityName)
                        .font(.title)
                        .bold()

                    Text(myWeather.dailyDates[0].formatAsString())
                        .font(.title2)

                    HStack(alignment: .center){
                        Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }//hstack

                    Text(myWeather.description.capitalized)
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
                                      value: myWeather.sunrise.formatAsString3())

                            DetailRow(logo: "wind", name: "Wind speed",
                                      value: "\(myWeather.currentWind)m/s")

                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            DetailRow(logo: "sunset.fill", name: "Sunset",
                                      value: myWeather.sunset.formatAsString3())

                            DetailRow(logo: "humidity", name: "Humidity",
                                      value: "\(myWeather.currentHumidity)%")
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
                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0]),
                                 day: "Today",
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1]),
                                 day: myWeather.dailyDates[1].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[1])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2]),
                                 day: myWeather.dailyDates[2].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[2])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3]),
                                 day: myWeather.dailyDates[3].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[3])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4]),
                                 day: myWeather.dailyDates[2].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[4])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                    }//vstack
                }
            }//ScrollView
        }//VStack
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}


//let myWeather: ForecastViewModel?
//let forecast: ForecastEntity?
//
//@EnvironmentObject var store: Store
//
//var body: some View {
//    VStack {
//        ScrollView(showsIndicators: false) {
//            // MARK: - Title
//
//            VStack(alignment: .center) {
//                Text(myWeather == nil ? forecast!.city! : myWeather!.cityName)
//                    .font(.title)
//                    .bold()
//
//                Text(myWeather == nil ? forecast!.date0!.formatAsString() : myWeather!.dailyDates[0].formatAsString())
//                    .font(.title2)
//
//                HStack(alignment: .center){
//                    Image(myWeather == nil ? forecast!.icon0! : myWeather!.getIconFor(icon: myWeather!.dailyWeatherIcons[0]))
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//
//                    Text(myWeather == nil ? "\(forecast!.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))" : "\(myWeather!.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
//                        .font(.system(size: 50))
//                }//hstack
//
//                Text(myWeather == nil ? forecast!.condition!.capitalized : myWeather!.description.capitalized)
//                    .font(.title3)
//
//            }//Vstack
//            .padding()
//            .foregroundColor(.accentColor)
//
//            // MARK: - Detail
//
//            CustomStackView {
//                Label {
//                    Text("Details")
//                } icon: {
//                    Image(systemName: "square.grid.2x2")
//                }
//
//            } contentView: {
//                HStack {
//                    VStack(alignment: .leading) {
//                        DetailRow(logo: "sunrise.fill", name: "Sunrise",
//                                  value: myWeather == nil ? forecast!.sunrise!.formatAsString3() : myWeather!.sunrise.formatAsString3())
//
//                        DetailRow(logo: "wind", name: "Wind speed",
//                                  value: myWeather == nil ? "\(forecast!.wind!)m/s" : "\(myWeather!.currentWind)m/s")
//
//                    }
//                    Spacer()
//                    VStack(alignment: .leading) {
//                        DetailRow(logo: "sunset.fill", name: "Sunset",
//                                  value: myWeather == nil ? forecast!.sunset!.formatAsString3() : myWeather!.sunset.formatAsString3())
//
//                        DetailRow(logo: "humidity", name: "Humidity",
//                                  value: myWeather == nil ? "\(forecast!.humidity!)%" : "\(myWeather!.currentHumidity)%")
//                    }
//                }
//            }
//
//            // MARK: - 5-Day Forecast
//
//            CustomStackView {
//                Label {
//                    Text("5-Day Forecast")
//                } icon: {
//                    Image(systemName: "calendar")
//                }
//
//            } contentView: {
//                VStack(spacing: 10) {
//                    DailyRow(logo: myWeather == nil ? forecast!.iconS0! : myWeather!.getSystemIcon(icon: myWeather!.dailyWeatherIcons[0]),
//                             day: "Today",
//                             temp: myWeather == nil ? "\(forecast!.temp0!)°\(String(store.selectedUnit.displayText.prefix(1)))" : "\(myWeather!.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                    )
//                    Divider()
//
//                    DailyRow(logo: myWeather == nil ? forecast!.iconS1! : myWeather!.getSystemIcon(icon: myWeather!.dailyWeatherIcons[1]),
//                             day: myWeather == nil ? forecast!.date1!.formatAsString1() : myWeather!.dailyDates[1].formatAsString1(),
//                             temp: myWeather == nil ? "\(forecast!.temp1!)°\(String(store.selectedUnit.displayText.prefix(1)))" : "\(myWeather!.getTempByUnit(unit: store.selectedUnit)[1])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                    )
//                    Divider()
//
//                    DailyRow(logo: myWeather == nil ? forecast!.iconS2! : myWeather!.getSystemIcon(icon: myWeather!.dailyWeatherIcons[2]),
//                             day: myWeather == nil ? forecast!.date2!.formatAsString1() : myWeather!.dailyDates[2].formatAsString1(),
//                             temp: myWeather == nil ? "\(forecast!.temp2!)°\(String(store.selectedUnit.displayText.prefix(1)))" : "\(myWeather!.getTempByUnit(unit: store.selectedUnit)[2])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                    )
//
//                    Divider()
//
//                    DailyRow(logo: myWeather == nil ? forecast!.iconS3! : myWeather!.getSystemIcon(icon: myWeather!.dailyWeatherIcons[3]),
//                             day: myWeather == nil ? forecast!.date3!.formatAsString1() : myWeather!.dailyDates[3].formatAsString1(),
//                             temp: myWeather == nil ? "\(forecast!.temp3!)°\(String(store.selectedUnit.displayText.prefix(1)))" : "\(myWeather!.getTempByUnit(unit: store.selectedUnit)[3])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                    )
//
//                    Divider()
//
//                    DailyRow(logo: myWeather == nil ? forecast!.iconS4! : myWeather!.getSystemIcon(icon: myWeather!.dailyWeatherIcons[4]),
//                             day: myWeather == nil ? forecast!.date4!.formatAsString1() : myWeather!.dailyDates[2].formatAsString1(),
//                             temp: myWeather == nil ? "\(forecast!.temp4!)°\(String(store.selectedUnit.displayText.prefix(1)))" : "\(myWeather!.getTempByUnit(unit: store.selectedUnit)[4])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                    )
//                }//vstack
//            }
//        }//ScrollView
//    }//VStack
//}
//}
