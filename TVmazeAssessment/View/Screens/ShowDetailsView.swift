//
//  ShowDetailsView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import SwiftUI

struct ShowDetailsView: View {
    @ObservedObject var viewModel: SeasonsAndEpisodesViewModel
    private let show: Show
    @State private var selectedSeason: Int = 0
    @State private var didFetchEpisodes: Bool = false
    init(show: Show, viewModel: SeasonsAndEpisodesViewModel = SeasonsAndEpisodesViewModel()) {
        self.show = show
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollViewReader { scrollReader in
                ScrollView {
                    VStack {
                        if let url = show.originalPosterURL {
                            if let poster = ImageCache.shared[url] {
                                poster.posterFormat
                            } else {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                        case .success(let image):
                                            image.cacheImage(url: url).posterFormat
                                        default:
                                            Image(systemName: "photo").posterFormat
                                    }
                                }
                            }
                        }
                        
                        Spacer().frame(height: 24)
                        if !show.schedule.days.isEmpty {
                            LabeledText(content: "Airing days:", value: show.schedule.days.joined(separator: ", "))
                                .padding(.bottom, 8)
                            Divider()
                        }
                        
                        if !show.schedule.time.isEmpty {
                            LabeledText(content: "Air time:", value: show.schedule.time)
                                .padding(.bottom, 8)
                            Divider()
                        }
                        
                        LabeledText(content: "Genres:", value: show.genres.joined(separator: ", "))
                            .padding(.bottom, 8)
                        Divider()
                        
                        if let summary = show.summary?.removingHTMLTags {
                            VStack(alignment: .leading) {
                                SummaryView(summary: summary)
                                Spacer().frame(height: 24)
                                Divider()
                            }
                        }
                        
                        if viewModel.isLoading {
                            buildProgressView()
                        } else {
                            ForEach(viewModel.seasons, id: \.number) { season in
                                VStack(alignment: .leading, spacing: 0) {
                                    Spacer()
                                    HStack {
                                        LabeledText(content: "Season \(season.number)", value: "\(season.episodes.count) episodes")
                                            .padding(.trailing, 4)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .fontWeight(.bold)
                                            .rotationEffect(
                                                Angle(degrees: season.number == selectedSeason ? 90 : 0)
                                            )
                                            .foregroundColor(.blue)
                                        
                                        
                                    }
                                    .frame(height: 50)
                                    Rectangle()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 0.75)
                                        .foregroundColor(.gray)
                                }
                                .id(season.number)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        if selectedSeason == season.number {
                                            selectedSeason = 0
                                        } else {
                                            selectedSeason = season.number
                                            scrollReader.scrollTo(selectedSeason, anchor: .top)
                                        }
                                    }
                                    
                                }
                                
                                if selectedSeason == season.number {
                                    ForEach(season.episodes, id: \.id) { episode in
                                        NavigationLink(destination: {
                                            EpisodeDetailsView(episode: episode)
                                        }, label: {
                                            EpisodeRowView(episode: episode)
                                        })
                                    }
                                }
                            }
                            Spacer().frame(height: 24)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    if !didFetchEpisodes {
                        didFetchEpisodes = true
                        viewModel.fetchShowEpisodes(showId: show.id)
                    }
                }
                .navigationTitle(show.name)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    NavigationView {
        ShowDetailsView(show: Show())
    }
}
