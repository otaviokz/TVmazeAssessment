//
//  PagedShowsView.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import SwiftUI

struct PagedShowsView: View {
    @ObservedObject var viewModel: PagedShowsViewModel
    
    
    
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Spacer()
                if #available(iOS 17.0, *) {
                    ProgressView()
                        .controlSize(.extraLarge)
                } else {
                    ProgressView()
                        .controlSize(.large)
                }
                Spacer()
            } else {
                List {
                    ForEach(viewModel.shows, id: \.id) { show in
                        NavigationLink(destination: {
                            ShowDetailsView(show: show)
                        }, label: {
                            ShowRowView(show: show)
                        })
                    }
                }
                HStack(alignment: .center) {
                    Button("", systemImage: "arrow.left", action: viewModel.previousPage)
                        .fontWeight(.bold)
                        .disabled(viewModel.selectedPage <= 0)
                    Spacer()
                    Text("\(viewModel.selectedPage)")
                    Spacer()
                    Button("", systemImage: "arrow.right", action: viewModel.nextPage)
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 32)
                .frame(height: 40)
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMessage) {
            Button("OK") {
                viewModel.showErrorMessage = false
            }
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
        .navigationTitle("Shows")
    }
}

#Preview {
    PagedShowsView(viewModel: PagedShowsViewModel())
}
