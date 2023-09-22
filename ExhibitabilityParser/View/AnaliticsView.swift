//
//  AnaliticsView.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 22.09.2023.
//

import SwiftUI

struct AnaliticsView: View {
    let viewModel: AnaliticsViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.formattedAnalitics(), id: \.self) {
                    Text($0)
                }
            }
        }
    }
}
