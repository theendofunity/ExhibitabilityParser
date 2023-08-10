//
//  ContentView.swift
//  ExhibitabilityParser
//
//  Created by Дмитрий Дудкин on 10.08.2023.
//

import SwiftUI

struct ContentView: View {
    private let viewModel = ViewModel()
    @State private var showingPicker = false
    
    var body: some View {
        VStack {
            Button("Add file") {
                showingPicker = true
            }
        }
        .sheet(isPresented: $showingPicker) {
            DocumentPicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
