//
//  DailyRow.swift
//  myWeather
//
//  Created by eleazar.martinez on 9/29/22.
//

import SwiftUI

struct DailyRow: View {
    var logo: String
    var day: String
    var temp: String
//    var max: String
//    var min: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(day)
                .font(.title3)
            
            Spacer()
            
            Image(systemName: logo)
                .resizable()
                .frame(width: 20, height: 20)
            
            Spacer ()
            
            Text(temp)
                .font(.title3)
//            HStack {
//                Text(min)
//                    .font(.title3)
//                Text(max)
//                    .font(.title3)
//            }
        }//hstack
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(logo: "sun", day: "today", temp: "30°C")
    }
}
