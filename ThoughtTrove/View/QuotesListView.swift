//
//  QuotesListView.swift
//  ThoughtTrove
//
//  Created by Максим Самороковский on 05.03.2024.
//

import SwiftUI

struct QuotesListView: View {
    var category: String
    @ObservedObject var viewModel = QuotesViewModel()
    
    var body: some View {
        VStack {
            Text("Category: \(category)")
                .font(.title)
                .padding()
            
            if let quotes = viewModel.quotes {
                List(quotes) { quote in
                    VStack(alignment: .leading) {
                        Text(quote.quote)
                        Text("- \(quote.author)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                ProgressView("Loading...")
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchQuotes(category: category)
        }
    }
}
