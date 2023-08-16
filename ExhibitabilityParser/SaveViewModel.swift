//
//  SaveViewModel.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation

final class SaveViewModel {
    func save(data: String) {
        let url = getDirrectory().appendingPathComponent("testDoc.csv")
        
        do {
            try data.write(to: url, atomically: true, encoding: .utf8)
            
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print("WRITING ERROR", error)
        }
    }
    
    private func getDirrectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
