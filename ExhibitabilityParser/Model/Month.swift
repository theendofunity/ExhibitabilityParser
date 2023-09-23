//
//  Month.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 23.09.2023.
//

import Foundation

enum Month: Int, CaseIterable {
    case january = 0
    case february
    case march
    case april
    case may
    case june
    case jule
    case august
    case september
    case october
    case november
    case december
    
    var shortForm: String {
        switch self {
        case .january:
            return "янв"
        case .february:
            return "фев"
        case .march:
            return "мар"
        case .april:
            return "апр"
        case .may:
            return "май"
        case .june:
            return "июн"
        case .jule:
            return "июл"
        case .august:
            return "авг"
        case .september:
            return "сен"
        case .october:
            return "окт"
        case .november:
            return "ноя"
        case .december:
            return "дек"
        }
    }
    
    static func compareByName(_ name: String) -> Month? {
        allCases.first { month in
            month.shortForm == name
        }
    }
}
