//
//  DocumentPickerViewModel.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 16.08.2023.
//

import Foundation
import UIKit
import SwiftUI

final class DocumentPickerViewModel: NSObject, UIDocumentPickerDelegate, ObservableObject {
    var inputType: InputType
    
    @Published var dataParsed = false
    @Published var error = false
    var data: FormattedDataViewModel?
    
    init(inputType: InputType, dataParsed: Bool = false, error: Bool = false, data: FormattedDataViewModel? = nil) {
        self.inputType = inputType
        self.dataParsed = dataParsed
        self.error = error
        self.data = data
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            return
        }
        
        let data = Parser().parse(file: url, inputType: inputType).sorted(by: <)
        
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
