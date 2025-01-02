//
//  CityDataTests.swift
//  FP_UalaTests
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import XCTest
@testable import FP_Uala

final class CityDataTests: XCTestCase {
    func test_getCities_returnSuccess() async throws {
        let url = makeCitiesURL()
        let sut = makeSUT(url: url)
        let response = HTTPURLResponse(
            url: URL(string: url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let sampleData = try! JSONEncoder().encode(mockSampleData())
        
        URLSessionMock.mockResponse = (sampleData, response, nil)
        
        let cities = try await sut.loadCities()
        
        XCTAssertEqual(cities.count, 2, "Expected count 2, received: \(cities.count)")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: String) -> CityDataAPI {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        let mockSession = URLSession(configuration: config)
        
        return CityDataAPI(session: mockSession, citiesURL: url)
    }
    
    private func makeCitiesURL() -> String {
        "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"
    }
    
    private func mockSampleData() -> [City] {
        let cities = [
            City(country: "UA", name: "Hurzuf", _id: 707860, coord: Coordinates(lon: 34.283333, lat: 44.549999)),
            City(country: "RU", name: "Novinki", _id: 519188, coord: Coordinates(lon: 37.666668, lat: 55.683334))
        ]
        return cities
    }
}
