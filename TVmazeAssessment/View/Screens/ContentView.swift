//
//  ContentView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    

    var body: some View {
        TabView {
            NavigationView {
                PagedShowsView(viewModel: PagedShowsViewModel())
            }.tabItem {
                Label("All shows", systemImage: "tv")
            }
            
            NavigationView {
                ShowSearchView(viewModel: ShowSearchViewModel())
            }.tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    ContentView()
}
