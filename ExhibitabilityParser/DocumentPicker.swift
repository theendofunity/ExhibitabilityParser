//
//  DocumentPicker.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    private let viewModel: DocumentPickerViewModel
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // empry
    }
    
    init(viewModel: DocumentPickerViewModel) {
        self.viewModel = viewModel
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIDocumentPickerViewController(forOpeningContentTypes: [.text])
        viewController.allowsMultipleSelection = false
        viewController.delegate = viewModel
        return viewController
    }
}

final class DocumentPickerViewModel: NSObject, UIDocumentPickerDelegate, ObservableObject {
    @Published var dataParsed = false
    var data: FormattedDataViewModel?
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        
        print("Parsing started")
        
        guard let url = urls.first else {
            return
        }
        
        let data = Parser().parse(file: url)
        save(data: data)
    }
    
    func save(data: [FormattedData]) {
        self.data = .init(data: data)
        dataParsed = true
    }
}
