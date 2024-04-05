//
//  Game.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation

struct Game: Equatable, Identifiable {
    let id: Int
    let name: String
    let backgroundImage: String
    let released: String
    let ratingTop: Int
}
