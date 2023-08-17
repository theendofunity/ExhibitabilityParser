//
//  FormattedData.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

final class FormattedData {
    static var skipped = 0
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
//    let date: String
    let rawDate: Date
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
//        self.date = data[dateIndex]
        self.rawDate = data[dateIndex].date
        self.link = .jiraUrl + number
        self.projectName = data[projectName]
        self.taskType = TaskType(rawValue: data[taskType]) ?? .strangerBug
        
        guard spendTime != .zero else {
            FormattedData.skipped += 1
            print("skipped", FormattedData.skipped, title, developTime, projectPlan, spendTime)
            return nil
        }
    }
    
    func getString() -> String {
        var array: [String] = []
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        
        array.append("2023")
        array.append(projectName)
        array.append(taskType.rawValue.lowercased())
        array.append(title)
        array.append(link)
        array.append(numberFormatter.string(from: NSNumber(value: developTime)) ?? "")
        array.append(numberFormatter.string(from: NSNumber(value: projectPlan)) ?? "")
        array.append(numberFormatter.string(from:  NSNumber(value: spendTime)) ?? "")

        return array.joined(separator: ";")
    }
}

private extension String {
    static let jiraUrl: String = "https://jira.touchin.ru/browse/"
}
