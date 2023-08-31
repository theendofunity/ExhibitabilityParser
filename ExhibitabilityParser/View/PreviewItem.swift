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
        VStack(spacing: 8) {
            HStack {
                Text(data.number)
                    .font(.headline)
                Spacer()
                Text(data.taskType.rawValue)
                    .padding()
                    .frame(height: 30)
                    .background(data.taskType.color)
                    .cornerRadius(16)
                    .foregroundColor(.white)
            }
            
            Text(data.title)
            
            HStack {
                Text(data.formattedDevelopTime)
                    .border(.black)

                Spacer()
                
                Text(data.formattedProjectPlan)
                    .border(.black)
                
                Spacer()

                Text(data.formattedSpendTime)
                    .border(.black)
            }
        }
        .padding()
        .background(.clear)
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke()
        }
        .onTapGesture {
            showPeecker = true
        }
        .sheet(isPresented: $showPeecker) {
            PreviewItemDetails(data: data)
        }
    }
}

//struct PreviewItem_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewItem(data: FormattedData.mock)
//    }
//}
