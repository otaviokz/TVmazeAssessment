//
//  ShowRowView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import SwiftUI

struct ShowRowView: View {
    let show: Show
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(show.name)
                .font(.headline)
            Spacer()
            if let url = show.mediumPosterURL {
                if let image = ImageCache.shared[url] {
                    image
                        .formattedForShowRowView()
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                            case .success(let image):
                                cacheAndReturnImage(url: url, image: image)
                                    .formattedForShowRowView()
                            default:
                                Image(systemName: "photo")
                                    .formattedForShowRowView()
                        }
                    }
                }
            }
        }
        .frame(height: 82)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
    
    @MainActor func cacheAndReturnImage(url: URL, image: Image) -> Image {
        ImageCache.shared[url] = image
        return image
    }
}

#Preview {
    ShowRowView(show: Show())
        .previewLayout(.sizeThatFits)
}


