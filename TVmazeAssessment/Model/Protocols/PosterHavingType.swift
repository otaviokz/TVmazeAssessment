//
//  PosterHavingType.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation
import SwiftUI

protocol PosterHavingType {
    var images: Images? { get }
    var mediumPosterURL: URL? { get }
    var originalPosterURL: URL? { get }
}

extension PosterHavingType {
    var mediumPosterURL: URL? {
        images?.mediumPosterURL
    }
    
    var originalPosterURL: URL? {
        images?.originalPosterURL
    }
    
    @MainActor func cacheAndReturnImage(url: URL, image: Image) -> Image {
        ImageCache.shared[url] = image
        return image
    }
}
