//
//  CompatibleProgressView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 24/04/2024.
//

import SwiftUI

struct CompatibleProgressView: View {
    var body: some View {
        if #available(iOS 17.0, *) {
            ProgressView().controlSize(.extraLarge)
        } else {
            ProgressView().controlSize(.large)
        }
    }
}

struct SmallCompatibleProgressView: View {
    var body: some View {
        if #available(iOS 17.0, *) {
            ProgressView()
        } else {
            ProgressView()
        }
    }
}

#Preview {
    NavigationView {
        CompatibleProgressView()
    }
}
