//
//  Parser.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import Foundation

typealias Indexes = [Column: Int]

final class Parser {
    
    func parse(file: URL) -> [FormattedData] {
        guard file.startAccessingSecurityScopedResource(),
              let content = try? String(contentsOf: file) else {
            return []
        }
        
        var rows = content.components(separatedBy: "\n")
        
        let titles = rows.removeFirst().components(separatedBy: ";").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
                .trimmingCharacters(in: .controlCharacters)
        }
        
        let indexes = getIndexes(from: titles)
        
        let data = rows
            .map { $0.components(separatedBy: ";") }
            .compactMap { FormattedData(data: $0, indexes: indexes) }
        
        return data
    }
    
    func getIndexes(from header: [String]) -> Indexes {
        var indexes: Indexes = [:]
        for (index, item) in header.enumerated() {
            guard let usefullIndex = Column(rawValue: item) else {
                continue
            }
            
            indexes[usefullIndex] = index
        }
        
        return indexes
    }
}

enum Column: String {
    case number = "Ключ проблемы"
    case title = "Тема"
    case spendedTime = "Затраченное время"
    case developTime = "Первоначальная оценка"
    case projectPlan = "Пользовательское поле (Project plan)"
    case date = "Дата решения"
}

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
