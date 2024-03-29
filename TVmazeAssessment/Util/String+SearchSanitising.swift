//
//  String+SearchSanitising.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import Foundation

extension String {
    var searchSanitised: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
