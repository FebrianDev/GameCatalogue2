//
//  HomeUseCase.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation

import Combine

public protocol HomeUseCase {
    
    func getGames() -> AnyPublisher<[Game], Error>
    
}

public class HomeInteractor: HomeUseCase {
    
    private let repository: GameRepositoryProtocol
    
    required public init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getGames() -> AnyPublisher<[Game], Error> {
        return repository.getGames()
    }
    
}
