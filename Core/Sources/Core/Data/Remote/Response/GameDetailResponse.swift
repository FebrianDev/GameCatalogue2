//
//  GameDetailResponse.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import Foundation

struct GameDetailResponse: Codable, Hashable {
    let id: Int
    let name: String
    let descriptionRaw: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case descriptionRaw = "description_raw"
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
    }
}
