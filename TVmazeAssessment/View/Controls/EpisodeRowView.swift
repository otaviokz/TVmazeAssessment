//
//  EpisodeRowView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode
    var body: some View {
        VStack {
            HStack {
                Text("Episode: \(episode.number)")
                Spacer()
                Text(episode.name)
                    .lineLimit(3)
                    
            }
            .foregroundColor(.primary.opacity(0.6))
            .frame(minHeight: 40)
            Divider()
        }
        .padding(.leading, 8)
    }
}

#Preview {
    EpisodeRowView(episode: Episode())
}
