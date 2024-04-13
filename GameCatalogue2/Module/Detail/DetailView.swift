//
//  DetailView.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import SwiftUI
import Core

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment:.leading) {
                AsyncImage(url: URL(string: presenter.gameDetail.backgroundImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width - 24, height: UIScreen.main.bounds.size.height / 4, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                } placeholder: {
                    ProgressView().frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 100)
                }
                if presenter.loadingState == false {
                    HStack{
                        Text(presenter.gameDetail.name)
                            .font(.system(size: 16, weight: .bold)).padding(.horizontal, 8).padding(.top, 4)
                        Spacer()
                        Button(action: {
                            let game = presenter.gameDetail
                            
                            if presenter.isExist {
                                presenter.deleteGameFavorite()
                                presenter.isExist = false
                            }else{
                                presenter.addGameFavorite(game: Game(
                                    id:game.id, name:game.name, backgroundImage: game.backgroundImage, released: game.released, ratingTop: game.ratingTop
                                ))
                                presenter.isExist = true
                            }
                            
                        }) {
                            Image(systemName: presenter.isExist ? "heart.fill" : "heart" )
                                .foregroundColor(.black)
                        }.padding(.horizontal, 4)
                    }.padding(.top, 8)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), alignment: .center) {
                        VStack(alignment:.center){
                            Text("Released").font(.system(size:12, weight:.light))
                            Text(presenter.gameDetail.released).font(.system(size:13, weight:.regular))
                        }
                        
                        VStack(alignment:.center){
                            Text("Rating").font(.system(size:12, weight:.light))
                            Text(String(format: "%.2f", presenter.gameDetail.rating)).font(.system(size:13, weight:.regular))
                        }
                        
                        VStack(alignment:.center){
                            Text("Rating Top").font(.system(size:12, weight:.light))
                            Text(String(presenter.gameDetail.ratingTop)).font(.system(size:13, weight:.regular))
                        }
                        
                    }.padding(.top, 2).padding(.horizontal, 8)
                    
                    Text("About")
                        .font(.system(size: 14, weight: .semibold)).padding(.top, 4).padding(.horizontal, 8)
                    
                    Text(presenter.gameDetail.descriptionRaw)
                        .font(.system(size: 12)).padding(.horizontal, 8)
                }
            }
        }.padding().onAppear{
            self.presenter.getGameDetail()
            self.presenter.isExistFavorite()
            print("IsExist \(presenter.isExist)")
        }
    }
}


