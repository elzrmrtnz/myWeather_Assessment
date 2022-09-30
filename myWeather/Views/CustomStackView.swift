//
//  WeatherDay.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/20/22.
//

import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
    
    var titleView: Title
    var contentView: Content
    
    init(@ViewBuilder titleView: @escaping ()->Title, contentView: @escaping ()->Content) {
        
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
                .font(.callout)
                .lineLimit(1)
                .padding(.leading)
            //maxHeight..
                .frame(height: 38)
                .frame(maxWidth: 350, alignment: .leading)
                .background(.ultraThinMaterial, in: CustomCorner(corners: [.topLeft,.topRight], radius: 12))
            
            VStack {
                
                Divider()
                
                contentView
                    .padding()
            }
            .frame(maxWidth: 350)
            .background(.ultraThinMaterial, in: CustomCorner(corners: [.bottomLeft,.bottomRight], radius: 12))
        }
    }
}
  

struct WeatherDay_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListScreen()
    }
}
