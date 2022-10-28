//
//  DetailCards.swift
//  myWeather
//
//  Created by eleazar.martinez on 10/28/22.
//

import SwiftUI

struct DetailCards: View {
    
    @EnvironmentObject var store: Store
    @State var myWeather: ForecastViewModel!
    let city: String
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    HStack {
                        TabView {
                            
                            //Current Location Weather
                            ForEach(store.currentW) { myWeather in
                            ForecastListView(myWeather: myWeather)
                            }
                            
                            //Added Cities Weather
                            ForEach(store.weatherList, id: \.cityName) { myWeather in
                            ForecastListView(myWeather: myWeather)
                          }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                        .tabViewStyle(PageTabViewStyle())
                    }
                }
                Spacer()
                
                FooterView()
                    .padding(.top)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailCards_Previews: PreviewProvider {
    static var previews: some View {
        DetailCards(city: "")
    }
}
