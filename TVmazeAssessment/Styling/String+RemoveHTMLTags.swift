//
//  String+RemoveHTMLTags.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation

extension String {
    var removingHTMLTags: String {
        self
            .replacingOccurrences(of: "<p>", with: "\n\n")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
            .replacingOccurrences(of: "<i>", with: "")
            .replacingOccurrences(of: "</i>", with: "")
            .replacingOccurrences(of: "<br>", with: "\n\n")
            .replacingOccurrences(of: "<br \\>", with: "\n\n")
    }
}
