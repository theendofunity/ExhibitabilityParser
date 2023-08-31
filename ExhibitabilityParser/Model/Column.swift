//
//  Column.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

enum Column: String, CaseIterable {
    case number = "Ключ проблемы"
    case title = "Тема"
    case spendedTime = "Затраченное время"
    case developTime = "Первоначальная оценка"
    case projectPlan = "Пользовательское поле (Project plan)"
    case date = "Дата решения"
    case type = "Тип задачи"
    case project = "Название проекта"
    case link = "Cсылка"
    
    static var header: String {
        let components: [Column] = [
            .date,
            .project,
            .type,
            .title,
            .link,
            .developTime,
            .projectPlan,
            .spendedTime
        ]
        
        return components.map {$0.rawValue}.joined(separator: ";")
    }
}
