//
//  Episode.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let number: Int
    let seasonNumber: Int
    let summary: String
    let images: Images
    
    enum CodingKeys: String, CodingKey {
        case id, name, number, summary
        case images = "image"
        case seasonNumber = "season"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Episode.CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        number = try container.decode(Int.self, forKey: .number)
        seasonNumber = try container.decode(Int.self, forKey: .seasonNumber)
        summary = try container.decode(String.self, forKey: .summary)
        images = try container.decode(Images.self, forKey: .images)
    }
}

extension Array where Element == Episode {
    var seasons: [Season] {
        var seasonsAndEpisodes: [Int: [Episode]] = [:]
        for episode in self {
            if seasonsAndEpisodes[episode.seasonNumber] == nil {
                seasonsAndEpisodes[episode.seasonNumber] = [episode]
            } else {
                seasonsAndEpisodes[episode.seasonNumber]?.append(episode)
            }
        }
        var seasons: [Season] = []
        for (seasonNumber, episodes) in seasonsAndEpisodes {
            seasons.append(
                Season(
                    number: seasonNumber,
                    episodes: episodes.sorted { $0.number < $1.number }
                )
            )
        }
        
        return seasons.sorted { $0.number < $1.number }
    }
    
}
