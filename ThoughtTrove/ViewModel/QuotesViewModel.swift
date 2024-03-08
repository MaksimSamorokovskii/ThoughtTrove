//
//  QuotesViewModel.swift
//  ThoughtTrove
//
//  Created by Максим Самороковский on 05.03.2024.
//

import Foundation

class QuotesViewModel: ObservableObject {
    @Published var quotes: [Quote]? = nil
    @Published var popularCategories: [String] = []
    
    private let quoteService = QuoteService()
    
    func fetchQuotes(category: String? = nil) {
        quoteService.fetchQuotes(category: category) { quotes in
            DispatchQueue.main.async {
                self.quotes = quotes
            }
        }
    }
}
