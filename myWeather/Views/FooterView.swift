//
//  FooterView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/12/22.
//

import SwiftUI

struct FooterView: View {
    
    @State var showList = false
    @EnvironmentObject var store: Store
    @State var showSettings = false
    
    
    var body: some View {
        HStack {
            Button  {
                withAnimation(.easeIn) {
                    self.showSettings.toggle()
                }
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title)
                    .foregroundColor(Color("iconColor"))
            }
            .sheet(isPresented: $showSettings) {
                SettingsScreen().environmentObject(store)
                }
            
            Spacer()
            
            Button {
                withAnimation(.easeIn) {
                    store.showingList = true
                }
            } label: {
                Image(systemName: "list.bullet")
                    .font(.title)
                    .foregroundColor(Color("iconColor"))
            }
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
