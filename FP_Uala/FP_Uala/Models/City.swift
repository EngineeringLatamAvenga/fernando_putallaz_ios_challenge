//
//  City.swift
//  FP_Uala
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import Foundation

struct City: Codable {
    let country: String
    let name: String
    let _id: Int
    let coord: Coordinates
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}
