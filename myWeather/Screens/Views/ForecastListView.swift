//
//  ForecastListView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/11/22.
//

import SwiftUI

struct ForecastListView: View {

    let myWeather: DetailViewModel
    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                // MARK: - Title

                VStack(alignment: .center) {
                    Text(myWeather.currentLocation)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Text(myWeather.currentDate.formatAsString())
                        .font(.title2)
                        .foregroundColor(.white)

                    HStack(alignment: .center){
                        Image(myWeather.getIconFor(icon: myWeather.dailyWeatherIcons[0]))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        Text("\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                            .font(.system(size: 50))
                    }//hstack

                    Text(myWeather.currentCondition!.capitalized)
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
                            DetailRow(logo: "sunrise.fill", name: "Sunrise",
                                      value: myWeather.sunrise.formatAsString3())
                            Spacer()
                            DetailRow(logo: "sunset.fill", name: "Sunset",
                                      value: myWeather.sunset.formatAsString3())
                        }

                        HStack {
                            DetailRow(logo: "wind", name: "Wind speed",
                                      value: "\(myWeather.currentWind)m/s")

                            Spacer()
                            DetailRow(logo: "humidity", name: "Humidity",
                                      value: "\(myWeather.currentHumidity)%")
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
                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[0]),
                                 day: "Today",
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                                 max: "\(myWeather.getTempMaxByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))",
//                                 min: "\(myWeather.getTempMinByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1]),
                                 day: myWeather.dailyDates[1].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[1])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                                 max: "\(myWeather.getTempMaxByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))",
//                                 min: "\(myWeather.getTempMinByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2]),
                                 day: myWeather.dailyDates[2].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[2])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                                 max: "\(myWeather.getTempMaxByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))",
//                                 min: "\(myWeather.getTempMinByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3]),
                                 day: myWeather.dailyDates[3].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[3])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                                 max: "\(myWeather.getTempMaxByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))",
//                                 min: "\(myWeather.getTempMinByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )

                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4]),
                                 day: myWeather.dailyDates[4].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[4])°\(String(store.selectedUnit.displayText.prefix(1)))"
//                                 max: "\(myWeather.getTempMaxByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))",
//                                 min: "\(myWeather.getTempMinByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))"
                        )
                    }//vstack
                }
            }//ScrollView
        }//VStack
    }
}
//
//struct ForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastListView()
//    }
//}
