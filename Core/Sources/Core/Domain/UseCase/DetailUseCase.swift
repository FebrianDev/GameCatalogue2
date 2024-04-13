//
//  DetailUseCase.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import Foundation
import Combine

public protocol DetailUseCase {
    func getGameDetail(gameId:Int) -> AnyPublisher<GameDetail, Error>
}

public class DetailInteractor: DetailUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required init(
        repository: GameRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func getGameDetail(gameId:Int) -> AnyPublisher<GameDetail, Error> {
        return repository.getGameDetail(gameId:gameId)
    }
    
}
