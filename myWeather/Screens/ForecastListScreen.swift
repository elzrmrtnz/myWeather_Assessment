//
//  ForecastListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/10/22.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct ForecastListScreen: View {
    
    @ObservedObject private var forecastListVM: ForecastListViewModel
    @State private var city: String = ""
    
    @State private var showSearch = false
    
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var store: Store
    
    
    init() {
        self.forecastListVM = ForecastListViewModel()
    }
    
    var body: some View {
        
        ZStack {
            if store.showingList == false {
                Image("background-image")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    NavigationBarView()
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    
                    HStack {
                        
                        Button {
                            withAnimation(.easeIn) {
                                print("Locations")
                            }
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .font(.title)
                                .foregroundColor(Color("iconColor"))
                        }

                        Spacer()
                        
                        TextField("Search", text: $city, onEditingChanged: { _ in }, onCommit: {
                            self.forecastListVM.searchByCity(self.city)
                        })
                        .foregroundColor(.accentColor)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }//Hstack
                    .padding(.horizontal)
                    Spacer()
                    
                    if self.forecastListVM.loadingState == .success {
                        ForecastListView(myWeather: self.forecastListVM.myWeather)
                    } else if self.forecastListVM.loadingState == .failed {
                        FailedView()
                    } else if self.forecastListVM.loadingState == .loading {
                        LoadingView()
                    }
                    Spacer()
                    
                    FooterView()
                        .padding(.horizontal)
                }//Vstack
            } else {
                FavoriteListScreen()
            }
        }//Zstack
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ForecastListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForecastListScreen()
            .environmentObject(Store())
    }
}
