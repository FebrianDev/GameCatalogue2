//
//  Injection.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation
import RealmSwift

public final class Injection : NSObject{
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(local, remote)
    }
    
    public func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    public func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
    public func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    
}
