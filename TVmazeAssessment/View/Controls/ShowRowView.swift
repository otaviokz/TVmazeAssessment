//
//  ShowRowView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import SwiftUI

struct ShowRowView: View, PosterHavingType {
    let show: Show
    var images: Images? {
        show.images
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading) {
                Text(show.name)
                    .font(.title3.weight(.medium))
            }

            Spacer()
            
            if let url = show.mediumPosterURL {
                if let image = ImageCache.shared[url] {
                    image
                        .rowViewFormatted
                } else {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            cacheAndReturnImage(url: url, image: image)
                                .rowViewFormatted
                        default:
                            Image(systemName: "photo")
                                .rowViewFormatted
                                .scaledToFit()
                        }
                    }
                }
            }
        }
        .frame(height: 82)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    ShowRowView(show: Show())
        .previewLayout(.sizeThatFits)
}


