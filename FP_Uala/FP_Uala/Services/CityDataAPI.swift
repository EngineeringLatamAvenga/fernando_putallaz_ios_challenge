//
//  CityDataAPI.swift
//  FP_Uala
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import Foundation

class CityDataAPI {
    private var session: URLSession
    private var citiesURL: String
    
    init(
        session: URLSession = .shared,
        citiesURL: String = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    ) {
        self.session = session
        self.citiesURL = citiesURL
    }
    
    func loadCities() async throws -> [City] {
        do {
            guard let url = URL(string: citiesURL), url.scheme != nil, url.host != nil else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse )
            }
            
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let cities = try JSONDecoder().decode([City].self, from: data)
            
            return Array(cities.prefix(10))
            
        } catch let error{
            throw error
        }
    }
}
