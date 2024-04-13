//
//  Favorite.swift
//  GameCatalogue2
//
//  Created by Febrian on 05/04/24.
//

import Foundation

struct Favorite: Equatable, Identifiable {
    let id: Int
    let name: String
    let backgroundImage: String
    let released: String
    let ratingTop: Int
}
