//
//  String+Extension.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 17.08.2023.
//

import Foundation

extension String {
    var formattedDate: String {
        var components = self.components(separatedBy: .whitespaces)
            .dropLast()
            .joined()
            .components(separatedBy: String.dateSeparator)
        
        components.removeFirst()
        
        guard let month = components.first, let year = components.last else {
            return ""
        }
        return "\(month) \(year)"
    }
}
