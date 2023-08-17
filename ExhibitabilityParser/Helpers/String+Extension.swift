//
//  String+Extension.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 17.08.2023.
//

import Foundation

extension String {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yy H:mm"
       
        let date = formatter.date(from: self)
        
        if date == nil {
            print("date == nil", self)
        }
        formatter.dateFormat = "LLLL yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date ?? Date())
    }
    
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yy HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.date(from: self) ?? Date()
    }
}
