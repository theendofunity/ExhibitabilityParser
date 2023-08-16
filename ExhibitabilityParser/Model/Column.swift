//
//  Column.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

typealias Indexes = [Column: Int]

enum Column: String {
    case number = "Ключ проблемы"
    case title = "Тема"
    case spendedTime = "Затраченное время"
    case developTime = "Первоначальная оценка"
    case projectPlan = "Пользовательское поле (Project plan)"
    case date = "Дата решения"
    case type = "Тип задачи"
    case project = "Название проекта"
}
