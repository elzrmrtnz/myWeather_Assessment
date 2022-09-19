//
//  FavoriteListScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/15/22.
//

import SwiftUI


enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addNewCity
    case settings
}

struct FavoriteListScreen: View {
    
    @EnvironmentObject var store: Store
    @State var showAdd = false
    @StateObject private var addCityVM = AddCityViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if store.showingList == false {
//                Image("background-image")
//                    .resizable()
//                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack(spacing: 10) {
                        Button(action: {
                            withAnimation(.easeIn) {
                                store.showingList = true
                            }
                        }, label: {
                            Image(systemName: "location.circle.fill")
                                .foregroundColor(Color("iconColor"))
                                .font(.title)
                        })
                        
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
                        ForEach(store.weatherList, id: \.city) { myWeather in
                            NavigationLink(destination: ForecastScreen(city: myWeather.city)) {
                                WeatherCell(myWeather: myWeather)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            store.weatherList.remove(atOffsets: indexSet)})
                    }//ScrollView
                    
                    
                }//Vstack
                } else {
                    ContentView()
                        .navigationBarHidden(true)
                }
            }//Zstack
            
// MARK: - NavigationBar
//        .navigationBarItems(trailing: EditButton())
//        leading: Button(action: {
//            withAnimation(.easeIn) {
//                store.showingList = false
//            }
//        }, label: {
//            Image(systemName: "location.circle.fill")
//                .foregroundColor(Color("iconColor"))
//                .font(.title)
//        }),trailing: EditButton())
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

struct WeatherCell: View {
    
    @EnvironmentObject var store: Store
    let myWeather: ForecastViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(myWeather.city)
                    .fontWeight(.bold)
                HStack {
                    Text("\(myWeather.date0.formatAsString())")
                }
                HStack {
                    Text("\(myWeather.description0)")
                }
            }//Vstack
            Spacer()
            URLImage(url: URL.weatherIcon(icon: myWeather.icon0))
                .frame(width: 50, height: 50)

            Text("\(Int(myWeather.getTemperatureUnit(unit: store.selectedUnit))) \(String(store.selectedUnit.displayText.prefix(1)))")
//            Text(String(format: "%.0f°", myWeather.temperature0))
        }//Hstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).stroke())
//        .background(Color(#colorLiteral(red: 0.9133135676, green: 0.9335765243, blue: 0.98070997, alpha: 1)))
//        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))


    }
}
