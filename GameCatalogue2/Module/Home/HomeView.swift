//
//  HomeView.swift
//  GameCatalogue2
//
//  Created by Febrian on 03/04/24.
//

import SwiftUI
import Core

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter = HomePresenter(homeUseCase:Injection.init().provideHome())
    
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
                }.onAppear {
                    if self.presenter.games.count == 0 {
                        self.presenter.getGames()
                    }
                    
                    print("Games \(self.presenter.games)")
                }.navigationBarTitle(
                    Text("Games Apps"),
                    displayMode: .automatic
                )
            }.padding()
        }
    }
}
