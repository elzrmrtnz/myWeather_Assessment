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
                    }

                    Text(myWeather.description.capitalized)
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
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[0])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[1]),
                                 day: myWeather.dailyDates[1].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[1])°\(String(store.selectedUnit.displayText.prefix(1)))")
                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[2]),
                                 day: myWeather.dailyDates[2].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[2])°\(String(store.selectedUnit.displayText.prefix(1)))")

                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[3]),
                                 day: myWeather.dailyDates[3].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[3])°\(String(store.selectedUnit.displayText.prefix(1)))")

                        Divider()

                        DailyRow(logo: myWeather.getSystemIcon(icon: myWeather.dailyWeatherIcons[4]),
                                 day: myWeather.dailyDates[2].formatAsString1(),
                                 temp: "\(myWeather.getTempByUnit(unit: store.selectedUnit)[4])°\(String(store.selectedUnit.displayText.prefix(1)))")
                    }
                }
            }
        }
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}

