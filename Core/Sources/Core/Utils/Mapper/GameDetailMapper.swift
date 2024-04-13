//
//  GameDetailMapper.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import Foundation

final class GameDetailMapper {
    static func mapGameResponsesToDomain(
        input gameDetailResponse: GameDetailResponse
    ) -> GameDetail {
        return GameDetail(
            id: gameDetailResponse.id,
            name: gameDetailResponse.name,
            descriptionRaw:gameDetailResponse.descriptionRaw,
            released: gameDetailResponse.released,
            backgroundImage: gameDetailResponse.backgroundImage,
            rating: gameDetailResponse.rating,
            ratingTop: gameDetailResponse.ratingTop
        )
    }
}
