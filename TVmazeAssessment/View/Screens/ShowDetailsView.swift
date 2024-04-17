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
    init(show: Show, viewModel: SeasonsAndEpisodesViewModel = SeasonsAndEpisodesViewModel()) {
        self.show = show
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollViewReader { scrollReader in
                ScrollView {
                    VStack {
                        if let url = show.mediumPosterURL {
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
                        
                        Spacer().frame(height: 16)
                        
                        if !show.schedule.days.isEmpty {
                            LabeledContent("Airing days:", value: show.schedule.days.joined(separator: ", "))
                                .padding(.bottom, 8)
                        }
                        
                        if !show.schedule.time.isEmpty {
                            LabeledContent("Air time:", value: show.schedule.time)
                                .padding(.bottom, 8)
                        }
                        
                        LabeledContent("Genres", value: show.genres.joined(separator: ", "))
                            .padding(.bottom, 8)
                        
                        if let summary = show.summary?.removingHTMLTags {
                            LabeledContent("Summary:", value: summary)
                                .padding(.bottom, 8)
                        }
                        
                        if viewModel.isLoading {
                            buildProgressView()
                        } else {
                            Divider()
                            ForEach(viewModel.seasons, id: \.number) { season in
                                VStack(alignment: .leading, spacing: 0) {
                                    Spacer()
                                    HStack(spacing: 0) {
                                        Text("Season \(season.number)")
                                            .font(.title2)
                                            .fontWeight(selectedSeason == season.number ? .bold : .regular)
                                        Spacer()
                                        Text("\(season.episodes.count) episodes")
                                            .padding(.trailing, 4)
                                        if season.number == selectedSeason {
                                            Image(systemName: "arrow.down")
                                        } else {
                                            Image(systemName: "arrow.right")
                                        }
                                    }.frame(height: 30)
                                    Spacer()
                                    Divider()
                                }
                                .frame(height: 40)
                                .id(season.number)
                                .onTapGesture {
                                    withAnimation {
                                        if selectedSeason == season.number {
                                            selectedSeason = 0
                                            scrollReader.scrollTo(1, anchor: .top)
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
                }
                .onAppear {
                    viewModel.fetchShowEpisodes(showId: show.id)
                }
                .navigationTitle(show.name)
                .padding(.horizontal, 16)
            }
        }
        
    }
}

#Preview {
    ShowDetailsView(show: Show())
}
