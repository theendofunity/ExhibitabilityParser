//
//  DataPreview.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 15.08.2023.
//

import SwiftUI

struct DataPreview: View {
    @ObservedObject var data: FormattedDataViewModel
    @ObservedObject private var saveViewModel = SaveViewModel()
    @State var isAnalitics: Bool = false
    
    init(data: FormattedDataViewModel) {
        self.data = data
    }
    
    var body: some View {
        if !data.data.isEmpty {
            VStack {
                List {
                    ForEach(data.data, id: \.self) {
                        PreviewItem(data: $0)
                            .background(.clear)
                    }
                    .onDelete { index in
                        data.remove(at: index)
                    }
                }
                
                Spacer()
                
                HStack {
                    Button("Save") {
                        saveViewModel.save(data: data.output())
                    }
                    
                    Button("Analitics") {
                        isAnalitics = true
                    }
                }
                
            }
            .background(.clear)

            .alert("Document saved", isPresented: $saveViewModel.isSaved) {
                Button("Share") {
                    showShareSheet(with: [saveViewModel.fileUrl as Any])
                }
                Button("Close", role: .cancel) {}
            } message: {
                Text(verbatim: "path: \(String(describing: saveViewModel.fileUrl?.absoluteString))")
            }
            
            .sheet(isPresented: $isAnalitics, content: {
                AnaliticsView(viewModel: data.analiticsViewModel)
            })
            .background(.clear)
        } else {
            Text("No data")
        }
    }
}

//struct DataPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        DataPreview(data: .init(data: [FormattedData.mock, FormattedData.mock2]))
//    }
//}

private extension View {
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
