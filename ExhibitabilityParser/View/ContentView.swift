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
            Button("Start") {
                showingPicker = true
            }
            .padding()
            .buttonStyle(.bordered)
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
