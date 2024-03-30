//
//  PagedShowsViewModel.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation
import SwiftUI

class PagedShowsViewModel: ObservableObject {
    private let api: TVmazeAPIClientType
    @Published var isLoading: Bool = false
    @Published var shows: [Show] = []
    var showErrorMessage: Bool = false
    var errorMessage: String = ""
    private(set) var selectedPage = 0
    
    init(api: TVmazeAPIClientType = TVmazeAPIClient.shared) {
        self.api = api
    }
    
    func nextPage() {
        selectedPage += 1
        searchForCurrentPage()
    }
    
    func previousPage() {
        guard selectedPage > 0 else { return }
        selectedPage -= 1
        searchForCurrentPage()
    }
    
    func viewDidAppear() {
        if shows.isEmpty {
            selectedPage = 0
            searchForCurrentPage()
        }
    }
    
    private func searchForCurrentPage() {
        Task {
            await searchShows()
        }
    }
    
    @MainActor
    private func searchShows() async {
        showErrorMessage = false
        isLoading = true
        do {
            shows = try await api.fetchShows(page: selectedPage)
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
            showErrorMessage = true
            errorMessage = "Unable to load shows, please try again later."
        }
    }
}
