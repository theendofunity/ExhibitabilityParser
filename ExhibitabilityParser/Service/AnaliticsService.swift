//
//  AnaliticsService.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 22.09.2023.
//

import Foundation

final class AnaliticsService {
    func getAnalitics(from data: [FormattedData]) -> [String] {
        var totalSpendTime: Float = .zero
        var totalDevelopTime: Float = .zero
        var totalProjectTime: Float = .zero
        
        var projectSpendTime: [String: Float] = [:]

        for item in data {
            totalSpendTime += item.spendTime
            totalDevelopTime += item.developTime
            totalProjectTime += item.projectPlan

            let currentProjectTime: Float = projectSpendTime[item.projectName] ?? .zero
            projectSpendTime[item.projectName] = currentProjectTime + item.spendTime
        }
        
        let koef = totalProjectTime / totalSpendTime
        
        var analitics: [String] = [
            "ОЧР: \(totalDevelopTime)",
            "ОП: \(totalProjectTime)",
            "Факт: \(totalSpendTime)",
            "Выставляемость \(koef)"
        ]
        
        analitics.append(contentsOf: projectSpendTime.map({ (key, value) in
            "\(key) - \(value)"
        }))

        return analitics
    }
}
