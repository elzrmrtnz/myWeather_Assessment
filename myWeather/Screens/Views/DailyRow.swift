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
    
    var body: some View {
        HStack {
            Today(day: day)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Icon(logo: logo)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Temp(temp: temp)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }//hstack
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(logo: "sun", day: "today", temp: "30°C")
    }
}

//Seperate Views for exact separation by equal sizes
//.frame(maxWidth: .infinity, alignment: .trailing)
struct Today: View {
    
    var day: String
    
    var body: some View {
        Text(day)
            .font(.title3)
    }
}

struct Icon: View {
    
    var logo: String
    
    var body: some View {
        Image(systemName: logo)
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct Temp: View {
    
    var temp: String
    
    var body: some View {
        Text(temp)
            .font(.title3)
    }
}
