//
//  LocalDataSource.swift
//  GameCatalogue2
//
//  Created by Febrian on 02/04/24.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
    
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func addGames(from game: [GameEntity]) -> AnyPublisher<Bool, Error>
    func addGameFavorite(game:FavoriteEntity) -> AnyPublisher<Bool, any Error>
    func getGamesFavorite() -> AnyPublisher<[FavoriteEntity], any Error>
    func deleteGameFavorite(id:Int) -> AnyPublisher<Bool, any Error>
    func isExistFavorite(id:Int) -> AnyPublisher<Bool, any Error>
    
}

final class LocalDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
    
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], any Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                    
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
        
    }
    
    func addGameFavorite(game:FavoriteEntity)-> AnyPublisher<Bool, any Error>{
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGamesFavorite() -> AnyPublisher<[FavoriteEntity], any Error> {
        return Future<[FavoriteEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                }()
                completion(.success(games.toArray(ofType:FavoriteEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteGameFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                if let favoriteDelete = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id) {
                    do {
                        try realm.write {
                            realm.delete(favoriteDelete)
                            completion(.success(true))
                        }
                        
                    } catch {
                        completion(.failure(DatabaseError.requestFailed))
                    }
                } else {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func isExistFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                if realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id) != nil {
                    completion(.success(true))
                    print("IsExist2 \(id)")
                } else {
                    completion(.failure(DatabaseError.requestFailed))
                    print("IsExist3 \(id)")
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
