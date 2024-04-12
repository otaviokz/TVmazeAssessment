//
//  PosterHavingType.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation

protocol PosterHavingType {
    var images: Images? { get }
    var mediumPosterURL: URL? { get }
    var originalPosterURL: URL? { get }
}

extension PosterHavingType {
    var mediumPosterURL: URL? {
        guard let medium = images?.medium else { return nil }
        return URL(string: medium)
    }
    
    var originalPosterURL: URL? {
        guard let original = images?.original else { return nil }
        return URL(string: original)
    }
}
