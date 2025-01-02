//
//  FP_UalaApp.swift
//  FP_Uala
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import SwiftUI

@main
struct FP_UalaApp: App {
    let api: CityDataAPI
    let citiesViewModel: CitiesViewModel
    
    init() {
        let session = URLSession.shared
        self.api = CityDataAPI(session: session)
        self.citiesViewModel = CitiesViewModel(api: api)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(citiesViewModel: citiesViewModel)
        }
    }
}
