//
//  SettingsScreen.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/8/21.
//

import SwiftUI

//enum TemperatureUnit: String, CaseIterable, Identifiable {
//    
//    var id: String {
//        return rawValue
//    }
//
//    case celsius
//    case fahrenheit
//}
//
//extension TemperatureUnit {
//
//    var displayText: String {
//        switch self {
//            case .celsius:
//                return "Celsius"
//            case .fahrenheit:
//                return "Fahrenheit"
//        }
//    }
//
//}
//
//struct SettingsScreen: View {
//
//    @EnvironmentObject var store: Store
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .celsius
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("background-image")
//                    .resizable()
//                    .edgesIgnoringSafeArea(.all)
//                VStack {
//                    Picker(selection: $selectedUnit, label: Text("Select temperature unit?")) {
//                        ForEach(TemperatureUnit.allCases, id: \.self) {
//                            Text("\($0.displayText)" as String)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    
//                    Spacer()
//                }
//                .padding()
//                .navigationTitle("Settings")
//                .navigationBarItems(trailing: Button("Done") {
//                    
//                    mode.wrappedValue.dismiss()
//                    store.selectedUnit = selectedUnit
//                    
//                })
//            }
//        }
//    }
//}
//
//struct SettingsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsScreen()
//    }
//}
