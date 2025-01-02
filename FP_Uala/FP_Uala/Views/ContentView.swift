//
//  ContentView.swift
//  FP_Uala
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import SwiftUI

struct ContentView: View {
    let citiesViewModel: CitiesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch citiesViewModel.state {
                case .loading:
                    ProgressView()
                case .error:
                    Text("An error ocurred")
                case .loaded(let cities):
                    ScrollView {
                        VStack {
                            ForEach(cities) { city in
                                Text(city.name)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Cities")
        }
        .task {
            await citiesViewModel.getCities()
        }
    }
}
