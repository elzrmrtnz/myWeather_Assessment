//
//  MenuView.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/7/22.
//

import SwiftUI

struct MenuView: View {
    
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
    @AppStorage("isDarkMode") private var isDark = false
    @EnvironmentObject var store: Store
    @State var isEditing = false
   
    var body: some View {
        Menu {
            //Theme: Dark or LightMode
            Button {
                isDark.toggle()
            } label: {
                Label {
                    Text("Theme: ")
                } icon: {
                    Image(systemName: isDark ? "moon" : "sun.max")
                }
            }
            
            Divider()
            //Temperatue Unit
            Picker(selection: $selectedUnit, label: Text("")) {
                ForEach(TemperatureUnit.allCases, id: \.self) {
                    Text("\($0.displayText)" as String)
                }
            }
            .pickerStyle(.automatic)//adapt menu style
            
        } label: {
            Image(systemName: "ellipsis.circle")
        }//End of Menu
        //Update value when user select a unit
        .onChange(of: selectedUnit) { newValue in
            store.selectedUnit = selectedUnit
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
