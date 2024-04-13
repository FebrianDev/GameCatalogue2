//
//  FavoriteUseCase.swift
//  GameCatalogue2
//
//  Created by Febrian on 05/04/24.
//

import Foundation
import Combine

public protocol FavoriteUseCase{
    func addGameFavorite(game:Game)-> AnyPublisher<Bool, any Error>
    func getGamesFavorite() -> AnyPublisher<[Game], any Error>
    func deleteGameFavorite(id:Int)-> AnyPublisher<Bool, any Error>
    func isExistFavorite(id:Int)-> AnyPublisher<Bool, any Error>
}

public class FavoriteInteractor : FavoriteUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(
        repository: GameRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    
    public func addGameFavorite(game: Game) -> AnyPublisher<Bool, any Error> {
        return repository.addGameFavorite(game: game)
    }
    
    public func getGamesFavorite() -> AnyPublisher<[Game], any Error> {
        return repository.getGamesFavorite()
    }
    
    public func deleteGameFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return repository.deleteGameFavorite(id: id)
    }
    
    public func isExistFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return repository.isExistFavorite(id: id)
    }
    
    
}
