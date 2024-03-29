//
//  Season.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import Foundation

struct Season: Equatable {
    let number: Int
    let episodes: [Episode]
    
    static func == (lhs: Season, rhs: Season) -> Bool {
        lhs.episodes == rhs.episodes
    }
}
