//
//  PsgedShowsControls.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 24/04/2024.
//

import SwiftUI

struct PagedShowsControlsView: View {
    @ObservedObject var viewModel: PagedShowsViewModel
    private var previousPageNum: Int {
        viewModel.displayablePage > 10 ? viewModel.displayablePage - 10 : 1
    }
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(alignment: .center) {
                Text("\(previousPageNum)")
                    .font(.title3.weight(.semibold))
                    .opacity(0.8)
                    .disabled(viewModel.displayablePage < 10)
                
                HStack {
                    Text("<<")
                        .font(.title3)
                }
            }
            .foregroundColor(.blue.opacity(0.8))
            .onTapGesture {
                if viewModel.displayablePage >= 10 {
                    viewModel.previousPage(num: 10)
                } else {
                    viewModel.previousPage(num: viewModel.selectedPage)
                }
            }
            
            Text("\(viewModel.displayablePage)")
                .font(.title2.weight(.medium))
                .foregroundColor(.blue.opacity(0.9))
                .frame(width: 50)
            
            HStack(alignment: .center) {
                HStack {
                    Text(">>")
                        .font(.title3)
                }
                
                Text("\(viewModel.displayablePage + 10)")
                    .font(.title3.weight(.semibold))
                    .opacity(0.8)
            }
            .foregroundColor(.blue.opacity(0.8))
            .onTapGesture {
                viewModel.nextPage(num: 10)
            }
        }
    }
}

#Preview {
    PagedShowsControlsView(viewModel: PagedShowsViewModel())
}
