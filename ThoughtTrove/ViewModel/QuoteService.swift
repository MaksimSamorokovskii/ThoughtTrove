//
//  QuoteService.swift
//  ThoughtTrove
//
//  Created by Максим Самороковский on 05.03.2024.
//

import Foundation

class QuoteService {
    let apiKey = "kTeqiWKhxQkQ0StOxn/fIw==3Fn0KRcHRkrVq4wm"

    func fetchQuotes(category: String? = nil, completion: @escaping ([Quote]?) -> Void) {
        var urlString = "https://api.api-ninjas.com/v1/quotes"
        
        if let category = category {
            urlString += urlString.contains("?") ? "&category=\(category)" : "?category=\(category)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL:", urlString)
            completion(nil)
            return
        }
        
        print("Fetching quotes from URL:", url)
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching quotes:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            print("Received quotes data:", String(data: data, encoding: .utf8) ?? "Unable to decode data")
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                print("Decoded quotes:", quotes)
                completion(quotes)
            } catch {
                print("Error decoding quotes:", error)
                completion(nil)
            }
        }.resume()
    }
}
