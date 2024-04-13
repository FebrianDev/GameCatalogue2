//
//  GameTransform.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation

final class GameMapper {
    static func mapGameResponsesToEntities(
        input gamesResponse: GamesResponse
    ) -> [GameEntity] {
        return gamesResponse.results.map { result in
            let gameEntity = GameEntity()
            gameEntity.id = result.id
            gameEntity.name = result.name
            gameEntity.backgroundImage = result.backgroundImage
            gameEntity.released = result.released
            gameEntity.ratingTop = result.ratingTop
            return gameEntity
        }
    }
    
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [Game] {
        return gameEntities.map { result in
            return Game(
                id: result.id,
                name: result.name,
                backgroundImage: result.backgroundImage,
                released: result.released,
                ratingTop: result.ratingTop
            )
        }
    }
    
}
