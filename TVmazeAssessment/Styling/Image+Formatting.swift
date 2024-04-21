//
//  Image+Formatting.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import SwiftUI

extension Image {
    var posterFormat: some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 320, height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var rowViewFormatted: some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 74, height: 74)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    @MainActor func cacheImage(url: URL) -> Image {
        ImageCache.shared[url] = self
        return  self
    }
}
