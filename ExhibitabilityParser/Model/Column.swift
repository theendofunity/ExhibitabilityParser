//
//  Column.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

enum Column: String, CaseIterable {
    case number = "Ключ проблемы"
    case numberTempo = "Ключ запроса"
    case title = "Тема"
    case titleTempo = "Тема запроса"
    case spendedTime = "Затраченное время"
    case spendedTimeTempo = "Часов"
    case developTime = "Первоначальная оценка"
    case developTimeTempo = "Первоначальная оценка запроса"
    case projectPlan = "Пользовательское поле (Project plan)"
    case date = "Дата решения"
    case dateTempo = "Дата работы"
    case type = "Тип задачи"
    case typeTempo = "Тип запроса"
    case project = "Название проекта"
    case projectTempo = "Имя проекта"

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

enum InputType: String, CaseIterable {
    case tasks
    case tempo
}
