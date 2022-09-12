//
//  Date+Extensions.swift
//  WeatherAppSwiftUI
//
//  Created by Mohammad Azam on 3/7/21.
//

import Foundation


extension Date {
    
    func formatAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: self)
    }
    
    func formatAsString1() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
    
}
