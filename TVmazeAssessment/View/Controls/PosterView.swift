//
//  PosterView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 01/05/2024.
//

import SwiftUI

struct PosterView: View {
    let images: Images?
    var body: some View {
        if let url = images?.originalPosterURL {
            if let poster = ImageCache.shared[url] {
                poster.posterFormat
            } else {
                AsyncImage(url: url) { phase in
                    switch phase {
                        case .success(let image):
                            image.cacheImage(url: url).posterFormat
                        case .failure:
                            VStack {
                                Image(systemName: "photo").posterFormat
                            }
                        default:
                            CompatibleProgressView()
                                .frame(width: 320, height: 320)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                    }
                }
            }
        }
    }
}

#Preview {
    PosterView(images: Show().images)
}
