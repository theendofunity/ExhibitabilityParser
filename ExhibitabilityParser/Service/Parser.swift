//
//  Parser.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import Foundation
import SwiftCSV

final class Parser {
    func parse(file: URL, inputType: InputType) -> [FormattedData] {
        guard file.startAccessingSecurityScopedResource(),
              let content = try? String(contentsOf: file),
              let csv = try? CSV<Named>(string:content) else {
            return []
        }
        
        var result: [String : FormattedData] = [:]
        
        for row in csv.rows {
            guard let data = FormattedData(data: row, inputType: inputType) else {
                continue
            }
            
            guard result[data.number] != nil else {
                result[data.number] = data
                continue
            }
            
            result[data.number]?.addSpendTime(data.spendTime)
        }
        
        return Array(result.values)
    }
}


