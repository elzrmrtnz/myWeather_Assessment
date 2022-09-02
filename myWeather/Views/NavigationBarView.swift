//
//  NavigationBarView.swift
//  myWeather
//
//  Created by eleazar.martinez on 8/9/22.
//

import SwiftUI

struct NavigationBarView: View {
    
    @State private var isAnimated: Bool = false
    
    var body: some View {
        Text("myWeather")
            .font(.title)
            .foregroundColor(Color("iconColor"))
            .opacity(isAnimated ? 1 : 0)
            .offset(x: 0, y: isAnimated ? 0 : -25)
            .onAppear(perform: {
                withAnimation(.easeOut(duration: 0.5)) {
                    isAnimated.toggle()
                }
            })
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
