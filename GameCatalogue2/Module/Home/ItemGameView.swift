//
//  ItemGameView.swift
//  GameCatalogue2
//
//  Created by Febrian on 04/04/24.
//

import SwiftUI
import Core

struct ItemGameView: View {
    let game:Game
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(minHeight: 172)
            .overlay(
                VStack(alignment:.center) {
                    
                    AsyncImage(url: URL(string: game.backgroundImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 100)
                            .frame(minWidth:(UIScreen.main.bounds.width / 2) - 28, minHeight:100, alignment: .center)
                            .clipped()
                            .cornerRadius(10)
                        
                        
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 100)
                    }
                    
                    Text(game.name)
                        .font(.system(size: 14, weight: .semibold)).padding(.top, 2).padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .leading) // Set maximum width to infinity
                        .lineLimit(1).foregroundColor(.black)
                    
                    Text(game.released).font(.system(size:12)).foregroundColor(.black).frame(maxWidth: .infinity, alignment: .leading) .padding(.horizontal, 8)
                    
                    Text(String(game.ratingTop)).font(.system(size:16, weight: .bold)).foregroundColor(.black).frame(maxWidth:.infinity, alignment: .trailing).padding(.horizontal, 8).padding(.top, 2)
                    
                    Spacer()
                    
                }
            )
            .shadow(radius: 2)
            .padding(.bottom, 4)
    }
}

