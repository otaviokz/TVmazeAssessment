//
//  ShowSearchViewModel.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import Foundation
import SwiftUI

class ShowSearchViewModel: ObservableObject {
    static var searchDelay: TimeInterval = 1
    private let api: TVmazeAPIClientType
    @Published var isLoading: Bool = false
    @Published var shows: [Show] = []
    @Published var searchText: String = "" {
        didSet {
            if searchText.searchSanitised.count >= 2 {
                // Fixes bug where focusing and unfocusing the TextField
                // whold be seen as changing searchText, resulting in
                // new launch of a search timer
                if oldValue.searchSanitised != searchText.searchSanitised {
                    launchSearchTimer()
                }
                
            } else {
                timer?.invalidate()
            }
        }
    }
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    var timer: Timer?
    
    init(api: TVmazeAPIClientType = TVmazeAPIClient()) {
        self.api = api
    }
    
    @MainActor
    private func searchShows() async {
        showErrorMessage = false
        isLoading = true
        do {
            shows = try await api.searchShows(query: searchText)
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
            showErrorMessage = true
            errorMessage = "Unable to search for '\(searchText.searchSanitised)', please try again later."
        }
    }
    
    func launchSearchTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: Self.searchDelay, repeats: false) { [unowned self] _ in
            Task {
                await searchShows()
            }
        }
    }
}
