//
//  FavoriteView.swift
//  GameCatalogue2
//
//  Created by Febrian on 05/04/24.
//

import SwiftUI
import Core

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter = FavoritePresenter(favoriteUseCase:Injection.init().provideFavorite())
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading){
                ZStack {
                    if presenter.loadingState {
                        VStack {
                            Text("Loading...")
                            ProgressView()
                        }
                    } else {
                        if(self.presenter.games.isEmpty){
                            Text("Tidak ada favorit")
                        }else{
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                                    ForEach(
                                        self.presenter.games,
                                        id: \.id
                                    ) { game in
                                        presenter.linkBuilder(for: game.id){
                                            ItemGameView(game: game)
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }.onAppear {
                    self.presenter.getGamesFavorite()
                }.navigationBarTitle(
                    Text("Favorite Apps"),
                    displayMode: .automatic
                )
            }.padding()
        }
    }
}
