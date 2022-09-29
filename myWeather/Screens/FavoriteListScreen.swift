//
//  FavoriteListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/15/22.
//

import SwiftUI
import CoreLocationUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addNewCity
    case settings
}

struct FavoriteListScreen: View {
    
    @EnvironmentObject var store: Store
//    @EnvironmentObject var locationManager: LocationViewModel
    @State var showAdd = false
    @StateObject private var addCityVM = AddCityViewModel()
    @StateObject var locationManager = LocationViewModel()
    var webService = WebService()
    @State var myWeather: MyWeather!
    
    var body: some View {
        NavigationView {
                VStack {
                    HStack(spacing: 10) {
                        TextField("Search for a city", text: $addCityVM.city, onEditingChanged: {
                            _ in }, onCommit: {
                                addCityVM.add { myWeather in
                                    store.addWeather(myWeather)
                            }
                        })
                        .foregroundColor(.accentColor)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                    
                   List {
                       
                       if let location = locationManager.location {
                           if let myWeather = myWeather {
                               NavigationLink(destination: ForecastScreen(city: myWeather.city)) {
                                   CurrentWeatherCell(myWeather: myWeather)
                               }
                           } else {
                               LoadingView()
                                   .task {
                                       do {
                                           myWeather = try await webService.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                       } catch {
                                           print("Error getting weather: \(error)")
                                       }
                                   }
                           }
                       } else {
                           LoadingView()
                               .onAppear(perform: locationManager.requestLocation)
                       }
                    
                        ForEach(store.weatherList, id: \.city) { myWeather in
                            NavigationLink(destination: ForecastScreen(city: myWeather.city)) {
                                WeatherCell(myWeather: myWeather)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            store.weatherList.remove(atOffsets: indexSet)})
                    }//ScrollView
                }//Vstack
            
// MARK: - NavigationBar
        .navigationBarItems(trailing: EditButton())
        .navigationBarTitle("myWeather")
        .foregroundColor(Color.accentColor)
        }//NvigationView
    }
}

struct FavoriteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListScreen()
            .environmentObject(Store())
    }
}


