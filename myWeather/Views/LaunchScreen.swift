//
//  LaunchScreen.swift
//  myWeather
//
//  Created by eleazar.martinez on 11/8/22.
//

import SwiftUI

struct LaunchScreen: View {

    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            ListScreen()
        } else {
            VStack {
                VStack {
                    Image("launch-image")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: .center)
                        .cornerRadius(12)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation() {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct LaunchScreenSplashView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
