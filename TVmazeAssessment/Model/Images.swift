//
//  Images.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

struct Images: Codable {
    let medium: String
    let original: String
    
    var mediumPosterURL: URL? {
        URL(string: medium)
    }
    
    var originalPosterURL: URL? {
        URL(string: original)
    }
}
