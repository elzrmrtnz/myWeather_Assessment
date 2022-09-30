//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Stephanie Diep on 2021-11-30.
//

import SwiftUI

struct DetailRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: logo)
                .font(.title3)
                .frame(width: 15, height: 15)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)

            
            VStack(alignment: .center, spacing: 0) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
