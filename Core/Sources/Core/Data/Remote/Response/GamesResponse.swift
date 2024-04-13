//
//  GameResponse.swift
//  GameCatalogue2
//
//  Created by Febrian on 01/04/24.
//

import Foundation


struct GamesResponse: Codable {
    let results: [GameResponse]
}

struct GameResponse: Codable, Hashable {
    let id: Int
    let name: String
    let backgroundImage: String
    let released: String
    let ratingTop: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case released
        case ratingTop = "rating_top"
    }
}


