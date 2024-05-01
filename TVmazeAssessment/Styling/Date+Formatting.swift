//
//  Date+Formatting.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 01/05/2024.
//

import Foundation

struct Dates {
    static var dateBuilder: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static var dateStringBuilder: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
