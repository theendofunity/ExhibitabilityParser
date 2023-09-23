//
//  ContentView.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPicker = false
    @State var inputType: InputType = .tasks
    @ObservedObject private var pickerViewModel = DocumentPickerViewModel(inputType: .tasks)
    
    var body: some View {
        VStack {
            Picker("Input type ", selection: $inputType) {
                ForEach(InputType.allCases, id: \.self) { item in
                    Text(item.rawValue.capitalized)
                }
            }
            .onReceive([self.inputType].publisher.first()) { value in
                pickerViewModel.inputType = value
             }
            .pickerStyle(.segmented)
            
            Spacer()
            
            Button("Select file") {
                showingPicker = true
            }
            .padding()
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .sheet(isPresented: $showingPicker) {
            DocumentPicker(viewModel: pickerViewModel)
        }
        .sheet(isPresented: $pickerViewModel.dataParsed) {
            if let data = pickerViewModel.data {
                DataPreview(data: data)
            }
        }
        .alert("Error", isPresented: $pickerViewModel.error) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
