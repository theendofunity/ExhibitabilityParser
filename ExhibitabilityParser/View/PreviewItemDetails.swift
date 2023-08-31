//
//  PreviewItemDetails.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 29.08.2023.
//

import SwiftUI

struct PreviewItemDetails: View {
    @State private var selectedTaskType: FormattedData.TaskType = .strangerBug
    
    @Environment(\.dismiss) var dismiss
    
    var data: FormattedData
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(data.title)
                    Text(data.link)
                        .onTapGesture {
                            guard let url = URL(string: data.link) else {
                                return
                            }
                            UIApplication.shared.open(url)
                        }
                }
                .padding()
                
                Picker("Тип задачи", selection: $selectedTaskType) {
                    ForEach(FormattedData.TaskType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                Button("Save") {
                    data.updateTaskType(selectedTaskType)
                    dismiss()
                }
                .padding()
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .navigationTitle(data.number)
        }
        
    }
    
    init(data: FormattedData) {
        self.data = data
        self.selectedTaskType = data.taskType
    }
}

//struct PreviewItemDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewItemDetails(data: FormattedData.mock)
//    }
//}
