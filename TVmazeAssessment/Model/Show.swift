//
//  Show.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

struct Show: Codable {
    let id: Int
    let name: String
    let images: Images
    let genres: [String]
    let summary: String
    let schedule: Schedule
    let premiered: String
    let ended: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, genres, summary, schedule, premiered, ended
        case images = "image"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Show.CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        images = try container.decode(Images.self, forKey: .images)
        genres = try container.decode([String].self, forKey: .genres)
        summary = try container.decode(String.self, forKey: .summary)
        schedule = try container.decode(Schedule.self, forKey: .schedule)
        premiered = try container.decode(String.self, forKey: .premiered)
        ended = try container.decodeIfPresent(String.self, forKey: .ended)
    }
}
