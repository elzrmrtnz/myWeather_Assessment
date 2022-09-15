//
//  WeatherListScreen.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/5/21.
//

import SwiftUI
//
//enum Sheets: Identifiable {
//    
//    var id: UUID {
//        return UUID()
//    }
//    
//    case addNewCity
//    case settings
//}
//
//struct WeatherListScreen: View {
//
//    @EnvironmentObject var store: Store
//    @State private var activeSheet: Sheets?
//    
//    var body: some View {
//        
//        List {
//            ForEach(store.weatherList, id: \.id) { myWeather in
//                WeatherCell(myWeather: myWeather)
//            }
//            .onDelete(perform: { indexSet in
//                store.weatherList.remove(atOffsets: indexSet)
//            })
//
//            }
//        .listStyle(PlainListStyle())
//        
//        .sheet(item: $activeSheet, content: { (item) in
//            switch item {
//                case .addNewCity:
//                    AddCityScreen().environmentObject(store)
//                case .settings:
//                    SettingsScreen().environmentObject(store)
//            }
//        })
//        
//        .navigationBarItems(leading: Button(action: {
//            activeSheet = .settings
//        }) {
//            Image(systemName: "gearshape")
//        }, trailing: Button(action: {
//            activeSheet = .addNewCity
//        }, label: {
//            Image(systemName: "plus")
//        }))
//        .navigationTitle("Cities")
//        .embedInNavigationView()
//       
//    }
//}
//
//struct WeatherListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherListScreen().environmentObject(Store())
//    }
//}
//
//struct WeatherCell: View {
//    
//    @EnvironmentObject var store: Store
//    let myWeather: ForecastViewModel
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 15) {
//                Text(myWeather.city)
//                    .fontWeight(.bold)
//                HStack {
//                    Text("\(myWeather.date0.formatAsString())")
//                }
//                HStack {
//                    Text("\(myWeather.description0)")
//                }
//            }//Vstack
//            Spacer()
//            URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
//                .frame(width: 50, height: 50)
//
//            Text("\(Int(myWeather.getTemperatureUnit(unit: store.selectedUnit))) \(String(store.selectedUnit.displayText.prefix(1)))")
//        }
//        .padding()
//        .background(Color(#colorLiteral(red: 0.9133135676, green: 0.9335765243, blue: 0.98070997, alpha: 1)))
//        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
//
//    }
//}
