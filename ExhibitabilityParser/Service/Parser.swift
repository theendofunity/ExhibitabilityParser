//
//  Parser.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import Foundation


final class Parser {
    
    func parse(file: URL) -> [FormattedData] {
        guard file.startAccessingSecurityScopedResource(),
              let content = try? String(contentsOf: file) else {
            return []
        }
        
        var rows = content.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        let titles = rows.removeFirst().components(separatedBy: ";").map {
            $0.trimmingCharacters(in: .whitespacesAndNewlines)
                .trimmingCharacters(in: .controlCharacters)
        }
        
        let indexes = getIndexes(from: titles)
        
        let data = rows
            .map { $0.components(separatedBy: ";") }
            .filter { $0.count > indexes.count }
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


