//
//  FailedView.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/29/22.
//

import SwiftUI

struct FailedView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("It looks like you're not connected to the internet.")
                .font(.system(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}

struct FailedView_Previews: PreviewProvider {
    static var previews: some View {
        FailedView()
    }
}
