//
//  FavoritePresenter.swift
//  GameCatalogue2
//
//  Created by Febrian on 05/04/24.
//

import Foundation
import Combine
import SwiftUI
import Core

class FavoritePresenter : ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    
    private let favoriteUseCase:FavoriteUseCase
    
    @Published var games: [Game] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(favoriteUseCase:FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getGamesFavorite(){
        loadingState = true
        favoriteUseCase.getGamesFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for id:Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: id)
        ) { content() }
    }
    
}
