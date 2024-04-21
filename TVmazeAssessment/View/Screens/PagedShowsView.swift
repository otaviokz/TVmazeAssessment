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
        VStack(spacing: 0) {
            if viewModel.isLoading {
                Spacer()
                buildProgressView()
                Spacer().foregroundColor(.clear)
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
                .listStyle(InsetGroupedListStyle())
                
                HStack(alignment: .center) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(viewModel.selectedPage <= 0 ? .gray.opacity(0.7) : .blue)
                        .disabled(viewModel.selectedPage <= 0)
                        .onTapGesture {
                            viewModel.previousPage()
                        }
                    
                    Spacer().background(Color.gray.opacity(0.1))
                    
                    Text("\(viewModel.selectedPage + 1)")
                        .font(.title2)
                    
                    Spacer().background(Color.gray.opacity(0.1))
                    
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            viewModel.nextPage()
                        }
                }
                .padding(.horizontal, 32)
                .frame(height: 40)
            }
        }
        .background(Color.gray.opacity(0.1))
        .frame(maxWidth: .infinity)
        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMessage) {
            Button("OK") {
                viewModel.showErrorMessage = false
            }
        }
        .onAppear {
            viewModel.onViewAppear()
        }
        .navigationTitle("Shows")
    }
}

#Preview {
    PagedShowsView(viewModel: PagedShowsViewModel())
}
