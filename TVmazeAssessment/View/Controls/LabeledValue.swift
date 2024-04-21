//
//  LabeledValue.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 20/04/2024.
//

import SwiftUI

struct LabeledText: View {
    let content: String
    let value: String
    var body: some View {
        HStack {
            Text(content)
                .font(.title3.weight(.semibold))
            Spacer()
            Text(value)
                .font(.headline.weight(.bold))
                .foregroundColor(.gray)
                .minimumScaleFactor(0.5)
        }
        .frame(height: 24)
    }
}

#Preview {
    LabeledText(content: "Content", value: "Text")
}
