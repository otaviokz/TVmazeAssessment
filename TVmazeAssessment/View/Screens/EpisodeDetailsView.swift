//
//  EpisodeDetailsView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: Episode
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    if let url = episode.originalPosterURL {
                        if let poster = ImageCache.shared[url] {
                            poster
                                .posterFormat
                        } else {
                            AsyncImage(url: url) { phase in
                                switch phase {        
                                case .success(let image):
                                    image.cacheImage(url: url).posterFormat
                                default:
                                    VStack {
                                        Image(systemName: "photo").posterFormat
                                    }
                                }
                            }
                        }
                    }
                    
                    Group {
                        LabeledText(content: "Season", value: "\(episode.seasonNumber)")
                        .font(.headline.weight(.semibold))
                        Divider()
                        LabeledText(content: "Number:", value: "\(episode.number)")
                        Divider()
                        if let summary = episode.summary?.removingHTMLTags {
                            SummaryView(summary: summary)
                        }
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                }
            }
            .onAppear {
                SeasonsAndEpisodesViewModel().fetchShowEpisodes(showId: 1)
            }
            .navigationTitle(episode.name)
            .padding(.horizontal, 32)
            .scrollIndicators(.hidden)
        }
    }
}



#Preview {
    EpisodeDetailsView(episode: Episode())
}
