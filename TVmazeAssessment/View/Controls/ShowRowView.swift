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
                if let url = URL(string: show.images.medium) {
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

private extension Show {
    init() {
        id = 1
        name = "Under the Dome"
        images = Images(medium: "", original: "")
        genres = ["Drama", "Science-Fiction", "Thriller"]
        summary = "People wake up one day and theres a dome enclosing their city. Drama ensues."
        schedule = Schedule(time: "22:00", days: ["Wednesday"])
        premiered = "2013-06-24"
        ended = "2015-09-10"
    }
}

//let id: Int
//let name: String
//let images: Images
//let genres: [String]
//let summary: String
//let schedule: Schedule
//let premiered: String
//let ended: String?
