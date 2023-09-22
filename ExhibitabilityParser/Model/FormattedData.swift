//
//  FormattedData.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation
import SwiftUI

final class FormattedData: ObservableObject {    
    enum TaskType: String, CaseIterable {
        case task = "Задача"
        case myBug = "Свой баг"
        case strangerBug = "Чужой баг"
        
        var color: Color {
            switch self {
            case .task:
                return .blue
            case .strangerBug:
                return .yellow
            case .myBug:
                return .green
            }
        }
    }
    
    private let defaultDevelopTime: Float
    private let defaultprojectPlan: Float
    
    private let formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
    let number: String
    let title: String
    var spendTime: Float
    var developTime: Float
    var projectPlan: Float
    let date: String
    let link: String
    let projectName: String
    
    @Published var taskType: TaskType
    
    var formattedDevelopTime: String {
        let formattedValue = formatter.string(from: NSNumber(value: developTime)) ?? ""
        return "\("ОЧР: ")\(formattedValue)"
    }
    
    var formattedProjectPlan: String {
        let formattedValue = formatter.string(from: NSNumber(value: projectPlan)) ?? ""
        return "\("ОП: ")\(formattedValue)"
    }
    
    var formattedSpendTime: String {
        let formattedValue = formatter.string(from: NSNumber(value: spendTime)) ?? ""
        return "\("Факт: ")\(formattedValue)"
    }
    
    init?(data: [String : String]) {
        guard let numberIndex = data[Column.number.rawValue],
              let titleIndex = data[Column.title.rawValue],
              let spendTimeIndex = data[Column.spendedTime.rawValue],
              let developTimeIndex = data[Column.developTime.rawValue],
              let projectPlanIndex = data[Column.projectPlan.rawValue],
              let dateIndex = data[Column.date.rawValue],
              let projectName = data[Column.project.rawValue],
              let taskType = data[Column.type.rawValue] else {
            return nil
        }
        
        self.number = numberIndex
        self.title = titleIndex
        self.spendTime = (Float(spendTimeIndex) ?? .zero) / 3600
        self.developTime = (Float(developTimeIndex) ?? .zero) / 3600
        self.projectPlan = (Float(projectPlanIndex.trimmingCharacters(in: .controlCharacters).dropLast())) ?? spendTime
        self.date = dateIndex
        
        self.link = .jiraUrl + number
        self.projectName = projectName
        self.taskType = TaskType(rawValue: taskType) ?? .strangerBug
        
        self.defaultDevelopTime = developTime
        self.defaultprojectPlan = projectPlan
        
        guard spendTime != .zero else {
            return nil
        }
    }
    
    func getString() -> String {
        var array: [String] = []
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        
        array.append(date.formattedDate)
        array.append(projectName)
        array.append(taskType.rawValue.lowercased())
        array.append(title)
        array.append(link)
        array.append(formatter.string(from: NSNumber(value: developTime)) ?? "")
        array.append(formatter.string(from: NSNumber(value: projectPlan)) ?? "")
        array.append(formatter.string(from:  NSNumber(value: spendTime)) ?? "")

        return array.joined(separator: ";")
    }
    
    func updateTaskType(_ type: TaskType) {
        taskType = type
        
        switch taskType {
        case .task:
            developTime = defaultDevelopTime
            projectPlan = defaultprojectPlan
            
        case .myBug:
            developTime = .zero
            projectPlan = .zero
            
        case .strangerBug:
            developTime = spendTime
            projectPlan = spendTime
        }
    }
}

extension FormattedData: Hashable {
    static func == (lhs: FormattedData, rhs: FormattedData) -> Bool {
        lhs.number == rhs.number
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }
}

private extension String {
    static let jiraUrl: String = "https://jira.touchin.ru/browse/"
}
