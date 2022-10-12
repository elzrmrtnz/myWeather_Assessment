//
//  FooterView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/12/22.
//

import SwiftUI

struct FooterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Menu {
                Text("myWeather Application info")
            } label: {
                Image(systemName: "info.circle")
                    .font(.title2)
                    .foregroundColor(Color.accentColor)
            }
            
            Spacer()
            
            Button {
                withAnimation(.easeIn) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundColor(Color.accentColor)
            }
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
