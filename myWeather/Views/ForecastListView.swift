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
        ScrollView(showsIndicators: false) {
            VStack {
                Text(myWeather.city)
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)

                HStack {
                    VStack(alignment: .center) {
                        Text(myWeather.date0.formatAsString())
                            .font(.title3)
                            .foregroundColor(.accentColor)
                        
                        HStack {
                            URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                                .frame(width: 50, height: 50)
                            
                            Text(myWeather.description0)
                                .font(.title3)
                                .foregroundColor(.accentColor)
                        }//hstack
                    }//vstack
                    .padding()
                    
                    Text(String(format: "%.0f°", myWeather.temperature0))
                        .font(Font.system(size: 60))
                        .foregroundColor(.accentColor)
                        .padding()
                    
                }//Hstack
                .frame(width: 300, height: 120)
                .background(RoundedRectangle(cornerRadius: 10).stroke())
                Spacer()
                
                HStack {
                    VStack(alignment: .center) {
                        Text(myWeather.date1.formatAsString())
                            .font(.title3)
                            .foregroundColor(.accentColor)
                        HStack {
                            URLImage(url: URL.weatherIcon(icon: myWeather.icon1))
                                .frame(width: 50, height: 50)
                            
                            Text(myWeather.description1)
                                .font(.title3)
                                .foregroundColor(.accentColor)
                        }//hstack
                    }//vstack
                    .padding()
                    
                    Text(String(format: "%.0f°", myWeather.temperature1))
                        .font(Font.system(size: 60))
                        .foregroundColor(.accentColor)
                        .padding()
                }//Hstack
                .frame(width: 300, height: 120)
                .background(RoundedRectangle(cornerRadius: 15).stroke())
                Spacer()
                
                HStack {
                    VStack(alignment: .center) {
                        Text(myWeather.date2.formatAsString())
                            .font(.title3)
                            .foregroundColor(.accentColor)
                        HStack {
                            URLImage(url: URL.weatherIcon(icon: myWeather.icon2))
                                .frame(width: 50, height: 50)
                        
                            Text(myWeather.description2)
                                .font(.title3)
                                .foregroundColor(.accentColor)
                        }//hstack
                    }//vstack
                    .padding()
                    
                    Text(String(format: "%.0f°", myWeather.temperature2))
                        .font(Font.system(size: 60))
                        .foregroundColor(.accentColor)
                        .padding()
                }//Hstack
                .frame(width: 300, height: 120)
                .background(RoundedRectangle(cornerRadius: 15).stroke())
                Spacer()
                
                HStack {
                    VStack(alignment: .center) {
                        Text(myWeather.date3.formatAsString())
                            .font(.title3)
                            .foregroundColor(.accentColor)
                        HStack {
                            URLImage(url: URL.weatherIcon(icon: myWeather.icon3))
                                .frame(width: 50, height: 50)
                            
                            Text(myWeather.description3)
                                .font(.title3)
                                .foregroundColor(.accentColor)
                        }//hstack
                    }//vstack
                    .padding()
                    
                    Text(String(format: "%.0f°", myWeather.temperature3))
                        .font(Font.system(size: 60))
                        .foregroundColor(.accentColor)
                        .padding()
                }//Hstack
                .frame(width: 300, height: 120)
                .background(RoundedRectangle(cornerRadius: 15).stroke())
                Spacer()
                
                HStack {
                    VStack(alignment: .center) {
                        Text(myWeather.date4.formatAsString())
                            .font(.title3)
                            .foregroundColor(.accentColor)
                        HStack {
                            URLImage(url: URL.weatherIcon(icon: myWeather.icon4))
                                .frame(width: 50, height: 50)
                            
                            Text(myWeather.description4)
                                .font(.title3)
                                .foregroundColor(.accentColor)
                        }//hstack
                    }//vstack
                    .padding()
                    
                    Text(String(format: "%.0f°", myWeather.temperature4))
                        .font(Font.system(size: 60))
                        .foregroundColor(.accentColor)
                        .padding()
                }//Hstack
                .frame(width: 300, height: 120)
                .background(RoundedRectangle(cornerRadius: 15).stroke())
            }//Vstack
        }//ScrollView
    }

//struct ForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastListView()
//    }
}

