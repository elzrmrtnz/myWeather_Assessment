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
    var max: String
    var min: String
    
    var body: some View {
        HStack {
            Text(day)
                .font(.title3)
            
            Spacer()
            
            URLImage(url: logo)
                .frame(width: 35, height: 35)
            
            Spacer ()
            
            HStack {
                Text(min)
                    .font(.title3)
                Text(max)
                    .font(.title3)
            }
            
        }//hstack
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(logo: "sun", day: "today", max: "30", min: "25")
    }
}
