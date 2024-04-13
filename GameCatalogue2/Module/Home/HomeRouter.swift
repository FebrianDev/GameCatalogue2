//
//  HomeRouter.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import Foundation
import SwiftUI
import Core
class HomeRouter {
    
    func makeDetailView(for gameId:Int) -> some View {
        let detailUseCase = Injection.init().provideDetail()
        let favoriteUseCase = Injection.init().provideFavorite()
        let presenter = DetailPresenter(detailUseCase: detailUseCase, favoriteUseCase: favoriteUseCase, gameId:gameId)
        return DetailView(presenter: presenter)
    }
    
}
