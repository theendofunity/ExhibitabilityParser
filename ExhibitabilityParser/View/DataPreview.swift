//
//  DataPreview.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 15.08.2023.
//

import SwiftUI

struct DataPreview: View {
    let data: FormattedDataViewModel?
    @ObservedObject private var saveViewModel = SaveViewModel()
    
    init(data: FormattedDataViewModel?) {
        self.data = data
    }
    
    var body: some View {
        let data = data?.output() ?? "no data"
        VStack {
            Text(verbatim: data)
                .padding(.vertical)
            Spacer()
            Button("Save") {
                saveViewModel.save(data: data)
            }
        }
        
        .alert("Documents saved", isPresented: $saveViewModel.isSaved) {
            Button("Share") {
                showShareSheet(with: [saveViewModel.fileUrl])
            }
            Button("Close", role: .cancel) {}
        } message: {
            Text(verbatim: "path: \(String(describing: saveViewModel.fileUrl?.absoluteString))")
        }

    }
}

struct DataPreview_Previews: PreviewProvider {
    static var previews: some View {
        DataPreview(data: .init(data: []))
    }
}

private extension View {
  /// Show the classic Apple share sheet on iPhone and iPad.
  ///
  func showShareSheet(with activityItems: [Any]) {
    guard let source = UIApplication.shared.windows.last?.rootViewController else {
      return
    }

    let activityVC = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: nil)

    if let popoverController = activityVC.popoverPresentationController {
      popoverController.sourceView = source.view
      popoverController.sourceRect = CGRect(x: source.view.bounds.midX,
                                            y: source.view.bounds.midY,
                                            width: .zero, height: .zero)
      popoverController.permittedArrowDirections = []
    }
    source.present(activityVC, animated: true)
  }
}
