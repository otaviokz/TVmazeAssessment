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
                    
                    PosterView(images: episode.images)
                    
                    Group {
                        LabeledText(content: "Season", value: "\(episode.seasonNumber)")
                        .font(.headline.weight(.semibold))
                        
                        LabeledText(content: "Number:", value: "\(episode.number)")
                        
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
