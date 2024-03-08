//
//  Quote.swift
//  ThoughtTrove
//
//  Created by Максим Самороковский on 05.03.2024.
//

import Foundation

struct Quote: Codable, Identifiable {
    let id = UUID()
    let quote: String
    let author: String
    let category: String
}

