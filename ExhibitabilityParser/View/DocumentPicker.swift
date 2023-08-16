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

