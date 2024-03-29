//
//  ShowSearchView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import SwiftUI

struct ShowSearchView: View {
    @ObservedObject var viewModel: ShowSearchViewModel
    @FocusState private var fieldFocus: FieldFocus?
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .controlSize(.extraLarge)/*.frame(width: 120, height: 120).tint(.primary)*/
                Spacer()
            } else {
                TextField("Type at least 2 letters", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 32)
                    .focused($fieldFocus, equals: .searchTextField)
                    .padding(.top, 12)
                    .padding(.horizontal, 16)
                
                VStack(alignment: .center, spacing: 0) {
                    List {
                        ForEach(viewModel.shows, id: \.id) { show in
                            NavigationLink(destination: {
                                //                            ShowDetailsView(movie: movie)
                            }, label: {
                                ShowRowView(show: show)
                            })
                        }
                    }
                    .scrollIndicators(.hidden)
                    .cornerRadius(16)
                }
                
            }
        }
        .onAppear {
            fieldFocus = .searchTextField
        }
    }
}

private extension ShowSearchView {
    enum FieldFocus: Hashable {
        case searchTextField
    }
}

#Preview {
    ShowSearchView(viewModel: ShowSearchViewModel())
}
