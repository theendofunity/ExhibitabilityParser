//
//  ContentView.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPicker = false
    @ObservedObject private var pickerViewModel = DocumentPickerViewModel()
    
    var body: some View {
        VStack {
            Button("Add file") {
                showingPicker = true
            }
        }
        .sheet(isPresented: $showingPicker) {
            DocumentPicker(viewModel: pickerViewModel)
        }
        
        .sheet(isPresented: $pickerViewModel.dataParsed) {
            DataPreview(data: pickerViewModel.data)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
