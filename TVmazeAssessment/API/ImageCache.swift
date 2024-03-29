//
//  ImageCache.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import Foundation
import SwiftUI

class ImageCache {
    static var shared = ImageCache()
    private var cache: [URL: Image] = [:]
    
    private init() { }
    
    
    
    @MainActor
    subscript(url: URL) -> Image? {
        get {
            cache[url]
        }
        set(newValue) {
            cache[url] = newValue
        }
    }
}
