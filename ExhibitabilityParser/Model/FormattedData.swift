//
//  FormattedData.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

final class FormattedData {
    enum TaskType: String {
        case task = "Задача"
        case myBug = "Свой баг"
        case strangerBug = "Чужой баг"
    }
    
    let number: String
    let title: String
    let spendTime: Float
    let developTime: Float
    let projectPlan: Float
    let date: String
    let link: String
    let projectName: String
    let taskType: TaskType
    
    init?(data: [String], indexes: Indexes) {
        guard let numberIndex = indexes[.number],
              let titleIndex = indexes[.title],
              let spendTimeIndex = indexes[.spendedTime],
              let developTimeIndex = indexes[.developTime],
              let projectPlanIndex = indexes[.projectPlan],
              let dateIndex = indexes[.date],
              let projectName = indexes[.project],
              let taskType = indexes[.type] else {
            return nil
        }
        
        self.number = data[numberIndex]
        self.title = data[titleIndex]
        self.spendTime = (Float(data[spendTimeIndex]) ?? .zero) / 3600
        self.developTime = (Float(data[developTimeIndex]) ?? .zero) / 3600
        self.projectPlan = (Float(data[projectPlanIndex].trimmingCharacters(in: .controlCharacters).dropLast())) ?? spendTime
        self.date = data[dateIndex]
        self.link = .jiraUrl + number
        self.projectName = data[projectName]
        self.taskType = TaskType(rawValue: data[taskType]) ?? .strangerBug
    }
    
    func getString() -> String {
        var array: [String] = []
        array.append(projectName)
        array.append(taskType.rawValue)
        array.append(title)
        array.append(link)
        array.append("\(developTime)")
        array.append("\(projectPlan)")
        array.append("\(spendTime)")

        return array.joined(separator: ";")
    }
}

private extension String {
    static let jiraUrl: String = "https://jira.touchin.ru/browse/"
}
