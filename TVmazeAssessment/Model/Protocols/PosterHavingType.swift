//
//  PosterHavingType.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation

protocol PosterHavingType {
    var images: Images { get }
    var mediumPosterURL: URL? { get }
    var originalPosterURL: URL? { get }
}

extension PosterHavingType {
    var mediumPosterURL: URL? {
        URL(string: images.medium)
    }
    
    var originalPosterURL: URL? {
        URL(string: images.original)
    }
}
