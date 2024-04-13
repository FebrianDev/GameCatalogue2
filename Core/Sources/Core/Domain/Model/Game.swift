//
//  Game.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation

public struct Game: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let backgroundImage: String
    public let released: String
    public let ratingTop: Int
    
    public init(id: Int, name: String, backgroundImage: String, released: String, ratingTop: Int) {
           self.id = id
           self.name = name
           self.backgroundImage = backgroundImage
           self.released = released
           self.ratingTop = ratingTop
       }
}
