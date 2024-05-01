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
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Text(content)
                    .font(.title3.weight(.medium))
                Spacer()
                Text(value)
                    .font(.headline.weight(.medium))
                    .foregroundColor(.primary.opacity(0.5))
                    .minimumScaleFactor(0.5)
            }
            .frame(height: 24)
            .padding(.vertical, 8)
            Divider()
        }
        
    }
}

#Preview {
    LabeledText(content: "Content", value: "Text")
}
