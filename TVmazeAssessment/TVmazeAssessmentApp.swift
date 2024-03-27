//
//  TVmazeAssessmentApp.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import SwiftUI
import SwiftData

@main
struct TVmazeAssessmentApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
