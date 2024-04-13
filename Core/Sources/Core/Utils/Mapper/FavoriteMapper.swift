//
//  FavoriteMapper.swift
//  GameCatalogue2
//
//  Created by Febrian on 05/04/24.
//

import Foundation

final class FavoriteMapper{
    static func mapFavoriteEntitiesToDomains(
        input favoriteEntities: [FavoriteEntity]
    ) -> [Game] {
        return favoriteEntities.map { result in
            return Game(
                id: result.id,
                name: result.name,
                backgroundImage: result.backgroundImage,
                released: result.released,
                ratingTop: result.ratingTop
            )
        }
    }
    
    static func mapFavoriteDomainsToEntities(
        input game: Game
    ) -> FavoriteEntity {
        let favoriteEntity = FavoriteEntity()
        favoriteEntity.id = game.id
        favoriteEntity.name = game.name
        favoriteEntity.backgroundImage = game.backgroundImage
        favoriteEntity.released = game.released
        favoriteEntity.ratingTop = game.ratingTop
        return favoriteEntity
        
    }
}
