//
//  HTTPClientError.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

public enum HTTPClientError: Error {
    case decode(Error)
    case http(code: Int)
}
