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

        if components.count > 1 {
            components.removeFirst()
            
            guard let month = components.first, let year = components.last else {
                return ""
            }
            return "\(month) \(year)"
        } else {
            var dashComponents = components.joined(separator: "").components(separatedBy: String.dash)
            dashComponents.removeLast()
            
            guard let month = dashComponents.last, let year = dashComponents.first else {
                return ""
            }
            return "\(month) \(year)"
        }
    }
}
