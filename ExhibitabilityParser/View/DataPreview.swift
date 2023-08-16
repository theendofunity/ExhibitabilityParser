//
//  DataPreview.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 15.08.2023.
//

import SwiftUI

struct DataPreview: View {
    let data: FormattedDataViewModel?
    private let saveViewModel = SaveViewModel()
    
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
    }
}

struct DataPreview_Previews: PreviewProvider {
    static var previews: some View {
        DataPreview(data: .init(data: []))
    }
}
