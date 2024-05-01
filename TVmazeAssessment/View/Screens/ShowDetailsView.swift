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
                        
                        PosterView(images: show.images)
                        
                        Spacer().frame(height: 24)
                        if !show.schedule.days.isEmpty {
                            LabeledText(content: "Airing days:", value: show.schedule.days.joined(separator: ", "))
                        }
                        
                        if !show.schedule.time.isEmpty {
                            LabeledText(content: "Air time:", value: show.schedule.time)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Genres:")
                                .font(.title3.weight(.medium))
                                .padding(.bottom, 8)
                            Text(show.genres.joined(separator: ", "))
                                .font(.callout.weight(.medium))
                                .opacity(0.5)
                                .minimumScaleFactor(0.5)
                                .padding(.bottom, 12)
                            Divider()
                        }
                        .frame(height: 70)
                        
                        if let premiered = dateStringFor(show.premiered) {
                            LabeledText(content: "Premiered", value: premiered)
                        }
                        
                        if let ended = dateStringFor(show.ended) {
                            LabeledText(content: "Ended", value: ended)
                        }

                        if let avgRating = show.avgRating {
                            LabeledText(content: "Avg Raring", value: "\(avgRating)")
                        }
                        
                        if let summary = show.summary?.removingHTMLTags {
                            VStack(alignment: .leading) {
                                
                                SummaryView(summary: summary)
                                Spacer().frame(height: 24)
                                Divider()
                            }
                        }
                        
                        if viewModel.isLoading {
                            CompatibleProgressView()
                        } else {
                            ForEach(viewModel.seasons, id: \.number) { season in
                                VStack(alignment: .leading, spacing: 0) {
                                    Spacer()
                                   
                                    HStack {
                                        LabeledText(
                                            content: "Season \(season.number)",
                                            value: "\(season.episodes.count) episodes"
                                        )
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
                                        NavigationLink() {
                                            EpisodeDetailsView(episode: episode)
                                        } label: {
                                            EpisodeRowView(episode: episode)
                                        }
                                    }
                                }
                            }
                            Spacer()
                                .frame(height: 24)
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
    
    func dateStringFor(_ dateString: String?) -> String? {
        guard  let dateString = dateString, let date = Dates.dateBuilder.date(from: dateString) else { return nil }
        return Dates.dateStringBuilder.string(from: date)
    }
}



#Preview {
    NavigationView {
        ShowDetailsView(show: Show())
    }
}
