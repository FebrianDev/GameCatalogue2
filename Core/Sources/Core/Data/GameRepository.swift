//
//  GameRepository.swift
//  GameCatalogue2
//
//  Created by Febrian on 02/04/24.
//

import Foundation
import Combine

public protocol GameRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[Game], Error>
    func getGameDetail(gameId:Int) -> AnyPublisher<GameDetail, Error>
    func addGameFavorite(game:Game)-> AnyPublisher<Bool, any Error>
    func getGamesFavorite() -> AnyPublisher<[Game], any Error>
    func deleteGameFavorite(id:Int)-> AnyPublisher<Bool, any Error>
    func isExistFavorite(id:Int)-> AnyPublisher<Bool, any Error>
    
}

public final class GameRepository: NSObject {
    
    typealias GameInstance = (LocalDataSource, RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localRepo, remoteRepo in
        return GameRepository(local: localRepo, remote: remoteRepo)
    }
}
extension GameRepository: GameRepositoryProtocol {
    public func addGameFavorite(game: Game) -> AnyPublisher<Bool, any Error> {
        return self.local.addGameFavorite(game: FavoriteMapper.mapFavoriteDomainsToEntities(input: game)).eraseToAnyPublisher()
    }
    
    public func getGamesFavorite() -> AnyPublisher<[Game], any Error> {
        return self.local.getGamesFavorite()
            .map{FavoriteMapper.mapFavoriteEntitiesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
    
    public func deleteGameFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return self.local.deleteGameFavorite(id: id).eraseToAnyPublisher()
    }
    
    public func isExistFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return self.local.isExistFavorite(id: id).eraseToAnyPublisher()
    }
    
    
    public func getGames() -> AnyPublisher<[Game], Error> {
        return self.local.getGames().flatMap{ result -> AnyPublisher<[Game], Error> in
            if result.isEmpty {
                return self.remote.getGames()
                    .map{GameMapper.mapGameResponsesToEntities(input: $0)}
                    .flatMap{self.local.addGames(from: $0)}
                    .filter { $0 }
                    .flatMap { _ in self.local.getGames()
                            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
                    }
                    .eraseToAnyPublisher()
            }else{
                return self.local.getGames()
                    .map{GameMapper.mapGameEntitiesToDomains(input: $0)}
                    .eraseToAnyPublisher()
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func getGameDetail(gameId:Int) -> AnyPublisher<GameDetail, Error> {
        return self.remote.getGameDetail(id:gameId)
            .map{GameDetailMapper.mapGameResponsesToDomain(input: $0)}
            .eraseToAnyPublisher()
    }
    
}

