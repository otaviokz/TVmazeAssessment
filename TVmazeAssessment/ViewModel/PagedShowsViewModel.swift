//
//  PagedShowsViewModel.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation
import SwiftUI

enum PageChange {
    case next(num: Int = 1)
    case previous(num: Int = 1)
    case same
}

class PagedShowsViewModel: ObservableObject {
    private let api: TVmazeAPIClientType
    @Published var isLoading: Bool = false
    @Published var shows: [Show] = []
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    private(set) var selectedPage = 0
    var displayablePage: Int {
        selectedPage + 1
    }
    
    init(api: TVmazeAPIClientType = TVmazeAPIClient.shared) {
        self.api = api
    }
    
    func nextPage(num: Int = 1) {
        searchForPageWith(change: .next(num: num))
    }
    
    func firstPage() {
        selectedPage = 0
        searchForPageWith(change: .same)
    }
    
    func previousPage(num: Int = 1) {
        guard selectedPage > 0 else { return }
        searchForPageWith(change: .previous(num: num))
    }
    
    func onViewAppear() {
        if shows.isEmpty {
            searchForPageWith(change: .same)
        }
    }
    
    private func searchForPageWith(change: PageChange) {
        Task { [unowned self] in
            await searchShows(change: change)
        }
    }
    
    @MainActor
    private func searchShows(change pageChange: PageChange) async {
        switch pageChange {
            case .next(let num): selectedPage += num
            case.previous(let num): selectedPage -= num
            case .same: break
        }
        showErrorMessage = false
        isLoading = true
        do {
            shows = try await api.fetchShows(page: selectedPage)
            isLoading = false
        } catch {
            switch pageChange {
                case .next(let num): selectedPage -= num
                case .previous(let num): selectedPage += num
                case .same: break
            }
            print(error.localizedDescription)
            isLoading = false
            errorMessage = "Unable to load shows, please try again later."
            showErrorMessage = true
        }
    }
}
