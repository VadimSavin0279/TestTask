//
//  ModelForMovie.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import Foundation

struct Content: Codable {
    var docs: [Docs]
    
    struct Docs: Codable {
        let name: String
        let shortDescription: String?
        let poster: Poster
        let type: String
        
        struct Poster: Codable {
            let url: String
        }
    }
}
