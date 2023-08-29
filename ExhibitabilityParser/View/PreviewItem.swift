//
//  PreviewItem.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 28.08.2023.
//

import SwiftUI

struct PreviewItem: View {
    @State private var showPeecker = false
    
    @ObservedObject var data: FormattedData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(data.number)
                    .font(.headline)
                Spacer()
                Text(data.taskType.rawValue)
                    .background(data.taskType.color)
                    .cornerRadius(16)
                    .foregroundColor(.white)
            }
            
            Text(data.title)
            
            HStack {
                Text("\("ОЧР: ")\(data.developTime)")
                    .border(.black)

                Spacer()
                
                Text("\("ОП: ")\(data.projectPlan)")
                    .border(.black)
                
                Spacer()

                Text("\("Факт: ")\(data.spendTime)")
                    .border(.black)
            }
        }
        .border(.black)
        .cornerRadius(16)
        .padding()
        .onTapGesture {
            showPeecker = true
        }
        .sheet(isPresented: $showPeecker) {
            PreviewItemDetails(data: data)
        }
    }
}

struct PreviewItem_Previews: PreviewProvider {
    static var previews: some View {
        PreviewItem(data: FormattedData.mock)
    }
}
