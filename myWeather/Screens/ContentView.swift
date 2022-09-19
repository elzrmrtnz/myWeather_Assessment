//
//  ContentView.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/9/22.
//

import SwiftUI

struct ContentView: View {
    // Replace YOUR_API_KEY in WeatherManager with your own API key for the app to work
    @StateObject var locationManager = LocationViewModel()
    var webService = WebService()
    @State var myWeather: MyWeather!
    @EnvironmentObject var store: Store
    
    var body: some View {
        
        ZStack {
            
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
//                NavigationBarView()
//                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                HStack{
                    Text(" ")
                }
               Spacer()
                
                VStack {
                    
                    
                    if let location = locationManager.location {
                        if let myWeather = myWeather {
                            CurrentWeatherView(myWeather: myWeather)
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
                        if locationManager.isLoading {
                            LoadingView()
                        } else {
                            WelcomeView()
                                .environmentObject(locationManager)
                        }
                    }
                }//vstack
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .edgesIgnoringSafeArea(.bottom)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color.gray]), startPoint: .top, endPoint: .bottom))
                    .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                   
            }//Vstack
            
        }//Zstack
//        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
