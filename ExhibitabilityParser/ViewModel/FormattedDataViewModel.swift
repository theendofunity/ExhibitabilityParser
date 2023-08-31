//
//  FormattedDataViewModel.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

final class FormattedDataViewModel: ObservableObject {
    @Published var data: [FormattedData] = []
    
    init(data: [FormattedData]) {
        self.data = data
    }
    
    func output() -> String {
        let header = Column.header + "\n"
        let rows = data.map { $0.getString() }.joined(separator: "\n")
        
        return header + rows
    }
    
    func remove(at index: IndexSet) {
        data.remove(atOffsets: index)
    }
}
