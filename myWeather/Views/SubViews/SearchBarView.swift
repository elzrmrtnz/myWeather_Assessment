//
//  SearchBarView.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/8/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject var store: Store
    @State private var showCancelButton: Bool = false
    @State var myWeather: ForecastViewModel!
    @State var isEditing = false
    @StateObject private var addCityVM = AddCityViewModel()
    @EnvironmentObject var cd: ForecastData
//    @State var forecast: ForecastEntity!
    
    var body: some View {
        
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search for a city",
                          text: $addCityVM.city,
                          onEditingChanged: { isEditing in self.showCancelButton = true },
                          onCommit: {addCityVM.getCity { myWeather in cd.addForecast(myWeather)}
                })
                .foregroundColor(.accentColor)
                
                Button(action: {
                    self.addCityVM.city = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(addCityVM.city == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.addCityVM.city = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}

// Update for iOS 15
// MARK: - UIApplication extension for resgning keyboard on pressing the cancel buttion of the search bar
extension UIApplication {
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
