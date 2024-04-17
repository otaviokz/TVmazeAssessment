//
//  View+ProgressView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 17/04/2024.
//

import SwiftUI

extension View {
    func buildProgressView() -> some View {
        if #available(iOS 17.0, *) {
            ProgressView().controlSize(.extraLarge)
        } else {
            ProgressView().controlSize(.large)
        }
    }
}
