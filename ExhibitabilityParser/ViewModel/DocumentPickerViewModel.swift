//
//  DocumentPickerViewModel.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation
import UIKit

final class DocumentPickerViewModel: NSObject, UIDocumentPickerDelegate, ObservableObject {
    @Published var dataParsed = false
    @Published var error = false
    var data: FormattedDataViewModel?
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        
        let data = Parser().parse(file: url)
        
        if data.isEmpty {
            error = true
        } else {
            save(data: data)
        }
    }
    
    func save(data: [FormattedData]) {
        self.data = .init(data: data)
        dataParsed = true
    }
}
