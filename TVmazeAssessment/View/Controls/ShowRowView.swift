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
                    if let poster = ImageCache.shared[url] {
                        poster
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        AsyncImage(url: url) { phase in
                            switch phase {
                                case .success(let image):
                                    cacheImage(url: url, image: image)
                                        .resizable()
                                default:
                                    Image(systemName: "photo")
                                        .resizable()
                            }
                        }
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
        }
        .frame(height: 80)
        .padding()
    }
    
    @MainActor func cacheImage(url: URL, image: Image) -> Image {
        ImageCache.shared[url] = image
        return image
    }
}



#Preview {
    ShowRowView(show: Show())
        .previewLayout(.sizeThatFits)
}
