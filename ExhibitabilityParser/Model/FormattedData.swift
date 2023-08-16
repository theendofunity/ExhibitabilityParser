//
//  FormattedData.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

final class FormattedData {
    let number: String
    let title: String
    let spendTime: Float
    let developTime: Float
    let projectPlan: Float
    let date: String
    let link: String
    
    init?(data: [String], indexes: Indexes) {
        guard let numberIndex = indexes[.number],
              let titleIndex = indexes[.title],
              let spendTimeIndex = indexes[.spendedTime],
              let developTimeIndex = indexes[.developTime],
              let projectPlanIndex = indexes[.projectPlan],
              let dateIndex = indexes[.date] else {
            return nil
        }
        
        self.number = data[numberIndex]
        self.title = data[titleIndex]
        self.spendTime = (Float(data[spendTimeIndex]) ?? .zero) / 3600
        self.developTime = (Float(data[developTimeIndex]) ?? .zero) / 3600
        self.projectPlan = (Float(data[projectPlanIndex].trimmingCharacters(in: .controlCharacters).dropLast())) ?? spendTime
        self.date = data[dateIndex]
        self.link = .jiraUrl + number
    }
    
    func getString() -> String {
        var array: [String] = []
        array.append(number)
        array.append(title)
        array.append(link)
        array.append("\(spendTime)")
        array.append("\(developTime)")
        array.append("\(projectPlan)")

        return array.joined(separator: ";")
    }
}

private extension String {
    static let jiraUrl: String = "https://jira.touchin.ru/browse/"
}
