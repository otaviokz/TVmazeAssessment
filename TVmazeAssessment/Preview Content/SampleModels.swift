//
//  SampleModels.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import Foundation
import SwiftUI

extension Show {
    init() {
        id = 1
        name = "Under the Dome"
        images = Images(medium: "", original: "")
        genres = ["Drama", "Science-Fiction", "Thriller"]
        summary = "People wake up one day and theres a dome enclosing their city. Drama ensues."
        schedule = Schedule(time: "22:00", days: ["Wednesday"])
        premiered = "2013-06-24"
        ended = "2015-09-10"
        avgRating = 0.7
    }
}

extension Episode {
    init() {
        self.id = 185054
        self.name = "The Enemy Within"
        self.number = 16
        self.seasonNumber = 13
        self.summary = "<p>As the Dome in Chester's Mill comes down, the Resistance makes a final attempt to protect the outside world from the infected townspeople in the Kinship and their new queen.</p>"
        self.images = Images()
    }
}

extension Images {
    init() {
        self.medium = "https://static.tvmaze.com/uploads/images/medium_landscape/17/43622.jpg"
        self.original = "https://static.tvmaze.com/uploads/images/original_untouched/17/43622.jpg"
    }
}
