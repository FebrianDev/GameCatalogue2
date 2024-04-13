//
//  DetailPresenter.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import Foundation
import Combine
import Core

class DetailPresenter : ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    //private let router = HomeRouter()
    private let detailUseCase: DetailUseCase
    private let favoriteUseCase:FavoriteUseCase
    private let gameId:Int
    
    @Published var gameDetail: GameDetail = GameDetail()
    @Published var isExist: Bool = false
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase, favoriteUseCase:FavoriteUseCase, gameId:Int) {
        self.detailUseCase = detailUseCase
        self.favoriteUseCase = favoriteUseCase
        self.gameId = gameId
    }
    
    func getGameDetail() {
        loadingState = true
        detailUseCase.getGameDetail(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { game in
                self.gameDetail = game
            })
            .store(in: &cancellables)
    }
    
    func addGameFavorite(game:Game){
        favoriteUseCase.addGameFavorite(game: game).receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingState = false
            }
        }, receiveValue: { success in
            
        })
        .store(in: &cancellables)
    }
    
    func deleteGameFavorite(){
        favoriteUseCase.deleteGameFavorite(id: self.gameId).receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingState = false
            }
        }, receiveValue: { success in
            
        })
        .store(in: &cancellables)
    }
    
    func isExistFavorite(){
        favoriteUseCase.isExistFavorite(id: self.gameId).receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingState = false
            }
        }, receiveValue: { exist in
            self.isExist = exist
        })
        .store(in: &cancellables)
    }
    
}
