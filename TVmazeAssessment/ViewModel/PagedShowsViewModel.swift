//
//  PagedShowsViewModel.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation
import SwiftUI

enum PageChange {
    case next
    case previous
    case same
}

class PagedShowsViewModel: ObservableObject {
    private let api: TVmazeAPIClientType
    @Published var isLoading: Bool = false
    @Published var shows: [Show] = []
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    private(set) var selectedPage = 0
    
    init(api: TVmazeAPIClientType = TVmazeAPIClient.shared) {
        self.api = api
    }
    
    func nextPage() {
        
        searchForPageWith(change: .next)
    }
    
    func previousPage() {
        guard selectedPage > 0 else { return }
        searchForPageWith(change: .previous)
    }
    
    func onViewAppear() {
        if shows.isEmpty {
            searchForPageWith(change: .same)
        }
    }
    
    private func searchForPageWith(change: PageChange) {
        Task {
            await searchShows(change: change)
        }
    }
    
    @MainActor
    private func searchShows(change pageChange: PageChange) async {
        switch pageChange {
            case .next: selectedPage += 1
            case.previous: selectedPage -= 1
            case .same: break
        }
        showErrorMessage = false
        isLoading = true
        do {
            shows = try await api.fetchShows(page: selectedPage)
            isLoading = false
        } catch {
            switch pageChange {
                case .next: selectedPage -= 1
                case .previous: selectedPage += 1
                case .same: break
            }
            print(error.localizedDescription)
            isLoading = false
            errorMessage = "Unable to load shows, please try again later."
            showErrorMessage = true
        }
    }
}
