//
//  EpisodesViewModel.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import Foundation
import SwiftUI

class SeasonsAndEpisodesViewModel: ObservableObject {
    private let api: TVmazeAPIClientType
    @Published var seasons: [Season] = []
    @Published var isLoading: Bool = false
    @Published var series: [Season] = []
    
    init(api: TVmazeAPIClientType = TVmazeAPIClient.shared) {
        self.api = api
    }
    
    func fetchShowEpisodes(showId: Int) {
        Task {
            await searchSeriesAndEpisodes(showId:showId)
        }
    }
    
    @MainActor
    private func searchSeriesAndEpisodes(showId: Int) async {
        isLoading = true
        do {
            let episodes = try await api.fetchEpisodes(showId: showId)
            seasons = episodes.seasons
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }
    
}
