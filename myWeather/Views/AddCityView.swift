//
//  AddCityView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/15/22.
//

import SwiftUI

struct AddCityView: View {
    
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var addCityVM = AddCityViewModel()
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 20) {
                    TextField("Enter city", text: $addCityVM.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        addCityVM.add { myWeather in
                            store.addWeather(myWeather)
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Add")
                    }
                    .padding(10)
                    .frame(maxWidth: UIScreen.main.bounds.width/4)
                    .foregroundColor(.accentColor)
                    .background(Color("iconColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }.padding()
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(RoundedRectangle(cornerRadius: 15).stroke())

             Spacer()
            }//Vstack
            .padding()
        }//Zstack
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView().environmentObject(Store())
    }
}
