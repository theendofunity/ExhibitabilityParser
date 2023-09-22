//
//  AnaliticsViewModel.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 22.09.2023.
//

import Foundation

final class AnaliticsViewModel {
    let data: [FormattedData]
    
    init(data: [FormattedData]) {
        self.data = data
    }
    
    func formattedAnalitics() -> [String] {
        return AnaliticsService().getAnalitics(from: data)
    }
}
