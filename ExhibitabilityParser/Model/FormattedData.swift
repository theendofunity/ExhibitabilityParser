//
//  FormattedData.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation
import SwiftUI

final class FormattedData: ObservableObject {
    static var mock: FormattedData {
        let indexes = Column.allCases.enumerated().map({ (index, column) in
            (column, index)
        })
        var data: [Column : Int] = [:]
        for index in indexes {
            data[index.0] = index.1
        }
        return .init(data: ["test", "тестasdadasdasdjashdkjashdkjashdkjahdkajsdhakjsdhkasjdhkajdhakjsdhkajsdhakd","3600","3600","5h","test","test","test","test"], indexes: data)!
    }
    
    static var mock2: FormattedData {
        let indexes = Column.allCases.enumerated().map({ (index, column) in
            (column, index)
        })
        var data: [Column : Int] = [:]
        for index in indexes {
            data[index.0] = index.1
        }
        return .init(data: ["test2", "тестasdadasdasdjashdkjashdkjashdkjahdkajsdhakjsdhkasjdhkajdhakjsdhkajsdhakd","3600","3600","5h","test","test","test","test"], indexes: data)!
    }
    
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
    
    let number: String
    let title: String
    var spendTime: Float
    var developTime: Float
    var projectPlan: Float
//    let date: String
    let rawDate: Date
    let link: String
    let projectName: String
    
    @Published var taskType: TaskType
    
    private let defaultDevelopTime: Float
    private let defaultprojectPlan: Float
    
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
