//
//  Parser.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import Foundation
import SwiftCSV

final class Parser {
    func parse(file: URL) -> [FormattedData] {
        guard file.startAccessingSecurityScopedResource(),
              let content = try? String(contentsOf: file),
              let csv = try? CSV<Named>(string:content) else {
            return []
        }
        
        return csv.rows.compactMap {
            FormattedData(data: $0)
        }
    }
}


