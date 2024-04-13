//
//  GameDetail.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import Foundation

public struct GameDetail: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let descriptionRaw: String
    public let released: String
    public let backgroundImage: String
    public let rating: Double
    public let ratingTop: Int
    
    public init(id: Int = 0,
         name: String = "",
         descriptionRaw: String = "",
         released: String = "",
         backgroundImage: String = "",
         rating: Double = 0.0,
         ratingTop: Int = 0) {
        self.id = id
        self.name = name
        self.descriptionRaw = descriptionRaw
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
    }
}
