//
//  ContentView.swift
//  GameCatalogue2
//
//  Created by Febrian on 01/04/24.
//

import SwiftUI
import Core

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(test)
                }
            
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
            
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
        .accentColor(.blue)
    }
}
