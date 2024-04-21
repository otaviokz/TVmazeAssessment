//
//  OverViewView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 20/04/2024.
//

import SwiftUI
import WebKit

struct SummaryView: View {
    let summary: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Overview:")
                .font(.title3.weight(.semibold))
            
            Text(summary)
                .font(.headline.weight(.regular))
                .multilineTextAlignment(.leading)
        }
        .padding(.top, 8)
    }
}

#Preview {
    NavigationView {
        SummaryView(summary: "Very long summary that should fill at least a few lines with a latge font.")
    }
}
