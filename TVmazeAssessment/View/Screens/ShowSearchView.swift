//
//  ShowSearchView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import SwiftUI

struct ShowSearchView: View {
    @ObservedObject var viewModel: ShowSearchViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if viewModel.isLoading {
                Spacer()
                CompatibleProgressView()
                Spacer()
            } else {
                TextField("Type at least 2 letters", text: $viewModel.searchText)
                    .font(.title2)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 32)
                    .padding(.top, 12)
                    .padding(.horizontal, 16)
                
                VStack(alignment: .center, spacing: 0) {
                    List {
                        ForEach(viewModel.shows, id: \.id) { show in
                            NavigationLink(destination: {
                                ShowDetailsView(show: show)
                            }, label: {
                                ShowRowView(show: show)
                            })
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .scrollIndicators(.hidden)
                    .cornerRadius(16)
                }
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMessage) {
            Button("OK") {
                viewModel.showErrorMessage = false
            }
        }
        .navigationTitle("Search")
    }
}

#Preview {
    NavigationView {
        ShowSearchView(viewModel: ShowSearchViewModel())
    }
}
