//
//  APIModel.swift
//  iOSAssignment23Combine
//
//  Created by Isaiah Ojo on 05/05/2023.
//

import Foundation

struct Planet: Codable, Identifiable {
    let id = UUID()
    let name: String
    let climate: String
    let terrain: String
    let population: String
    let residents: [URL]
    let films: [URL]
    let imageUrl: URL?

    enum CodingKeys: String, CodingKey {
        case name, climate, terrain, population, residents, films
        case imageUrl = "image_url"
    }
}

struct PlanetList: Codable {
    let results: [Planet]
}

