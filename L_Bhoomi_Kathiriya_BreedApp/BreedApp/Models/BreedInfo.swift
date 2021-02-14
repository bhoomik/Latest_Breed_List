//
//  BreedInfo.swift
//  Bhoomi_Kathiriya
//
//  Created by Bhoomi Kathiriya on 13/02/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct BreedInfo: Codable {
    let breeds: [Breed]?
    let id: String?
    let url: String?
    let width, height: Int?
    var strLifeSpan : Int?
    var strLifeEnd : Int?

}

// MARK: - Breed
struct Breed: Codable {
    let weight, height: Eight?
    let id: Int?
    let name: String?
    let countryCode, bredFor, breedGroup: String?
    var lifeSpan, temperament, referenceImageID: String?
    let origin: String?
    var lifeSpanStart : Int?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case countryCode = "country_code"
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case referenceImageID = "reference_image_id"
        case origin
    }
}

// MARK: - Eight
struct Eight: Codable {
    let imperial, metric: String?
}

typealias BreedInfoAlias = [BreedInfo]


