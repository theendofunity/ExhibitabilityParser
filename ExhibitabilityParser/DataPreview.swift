//
//  DataPreview.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 15.08.2023.
//

import SwiftUI

struct DataPreview: View {
    let data: FormattedDataViewModel?
    
    init(data: FormattedDataViewModel?) {
        self.data = data
    }
    
    var body: some View {
        VStack {
            Text(verbatim: data?.output() ?? "no data")
                .padding(.vertical)
            Spacer()
            Button("Save") {
                
            }
        }
    }
}

struct DataPreview_Previews: PreviewProvider {
    static var previews: some View {
        DataPreview(data: .init(data: []))
    }
}
