//
//  DocumentPicker.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // empry
    }
    
    let viewModel = DocumentPickerViewModel()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIDocumentPickerViewController(forOpeningContentTypes: [.text])
        viewController.allowsMultipleSelection = false
        viewController.delegate = viewModel
        return viewController
    }
}

final class DocumentPickerViewModel: NSObject, UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        
        print("Parsing started")
        
        guard let url = urls.first else {
            return
        }
        
        Parser().parse(file: url)
    }
}
