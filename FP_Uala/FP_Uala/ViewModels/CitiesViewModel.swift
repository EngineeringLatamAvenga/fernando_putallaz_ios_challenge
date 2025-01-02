//
//  CitiesViewModel.swift
//  FP_Uala
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import Foundation

@Observable
class CitiesViewModel {
    enum LoadingState {
        case loading
        case loaded(cities: [City])
        case error
    }
    
    var cityList = [City]()
    let api: CityDataAPI?
    var state = LoadingState.loading
    var useMockData: Bool
    
    init(cityList: [City] = [City](), api: CityDataAPI? = nil, useMockData: Bool = false) {
        self.cityList = cityList
        self.api = api
        self.useMockData = useMockData
    }
    
    func getCities() async {
        if useMockData {
            //TODO: Implement mock cities
//            state = .loaded(cities:  )
        } else {
            state = .loading
            do {
                if let api {
                    state = .loaded(cities: try await api.loadCities())
                }
            } catch {
                state = .error
            }
        }
    }
}
