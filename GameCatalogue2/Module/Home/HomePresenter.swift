//
//  HomePresenter.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation
import Combine
import SwiftUI
import Core

class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var games: [Game] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames() {
        loadingState = true
        homeUseCase.getGames()
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
