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
        
        VStack (alignment: .center, spacing: 10) {
            Text(myWeather.city)
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text(myWeather.date0.formatAsString())
                .font(.title2)
                .foregroundColor(.white)
        }//vstack
        .padding()
//            ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Text("Today")
                    .font(.title)
                    .bold()
                Text(myWeather.description0)
                        .font(.title3)
//                HStack {
//                    Text(String(format: "L: %.0f˚", myWeather.tempMin0))
//                        .font(.title3)
//                    Text(String(format: "H: %.0f˚", myWeather.tempMax0))
//                        .font(.title3)
//                }
                
                HStack(spacing: 20) {
                    VStack(alignment: .trailing) {
                        
                    URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                        .frame(width: 100, height: 100)
                        
//                    Text(myWeather.description0)
//                            .font(.title3)
//                            .padding()
                        
                    }

                    VStack(alignment: .leading) {
                        Text(String(format: "%.0f°C", myWeather.temperature0))
                            .font(.system(size: 45))
                            .padding()
                        
//                        HStack {
//                            Text(String(format: "L: %.0f˚", myWeather.tempMin0))
//                                .font(.title3)
//                            Text(String(format: "H: %.0f˚", myWeather.tempMax0))
//                                .font(.title3)
//                        }
//                        .padding()
                        
                    }//vstack
                }//hstack
            }//Vstack
            .padding()
            .frame(width: 300, height: 180)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.5))
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)

                HStack {
                    Text(myWeather.date0.formatAsString1().uppercased())
                        .font(.title3)
                    
                    Spacer()
                    
                    URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                        .frame(width: 35, height: 35)
                    
                    Spacer ()
                    
                    HStack {
                        Text(String(format: "L: %.0f˚", myWeather.tempMin0))
                            .font(.title3)
                        Text(String(format: "H: %.0f˚", myWeather.tempMax0))
                            .font(.title3)
                    }
                    
                }//hstack
            .padding()
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.5))
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)

                HStack {
                    Text(myWeather.date1.formatAsString1().uppercased())
                        .font(.title3)
                    
                    Spacer()
                    
                    URLImage(url: URL.weatherIcon(icon: myWeather.icon1))
                        .frame(width: 35, height: 35)
                    
                    Spacer ()
                    
                    HStack {
                        Text(String(format: "L: %.0f˚", myWeather.tempMin1))
                            .font(.title3)
                        Text(String(format: "H: %.0f˚", myWeather.tempMax1))
                            .font(.title3)
                    }
                    
                }//hstack
            .padding()
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.5))
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)

                HStack {
                    Text(myWeather.date2.formatAsString1().uppercased())
                        .font(.title3)
                    
                    Spacer()
                    
                    URLImage(url: URL.weatherIcon(icon: myWeather.icon2))
                        .frame(width: 35, height: 35)
                    
                    Spacer ()
                    
                    HStack {
                        Text(String(format: "L: %.0f˚", myWeather.tempMin2))
                            .font(.title3)
                        Text(String(format: "H: %.0f˚", myWeather.tempMax2))
                            .font(.title3)
                    }
                    
                }//hstack
            .padding()
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.5))
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)

                HStack {
                    Text(myWeather.date3.formatAsString1().uppercased())
                        .font(.title3)
                    
                    Spacer()
                    
                    URLImage(url: URL.weatherIcon(icon: myWeather.icon3))
                        .frame(width: 35, height: 35)
                    
                    Spacer ()
                    
                    HStack {
                        Text(String(format: "L: %.0f˚", myWeather.tempMin3))
                            .font(.title3)
                        Text(String(format: "H: %.0f˚", myWeather.tempMax3))
                            .font(.title3)
                    }
                    
                }//hstack
            .padding()
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.5))
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                
                HStack {
                    Text(myWeather.date4.formatAsString1().uppercased())
                        .font(.title3)
                    
                    Spacer()
                    
                    URLImage(url: URL.weatherIcon(icon: myWeather.icon4))
                        .frame(width: 35, height: 35)
                    
                    Spacer ()
                    
                    HStack {
                        Text(String(format: "L: %.0f˚", myWeather.tempMin4))
                            .font(.title3)
                        Text(String(format: "H: %.0f˚", myWeather.tempMax4))
                            .font(.title3)
                    }
                    
                }//hstack
            .padding()
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.5))
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)

    }

//struct ForecastListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastListView()
//    }
}

