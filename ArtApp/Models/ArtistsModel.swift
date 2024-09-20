//
//  ArtistModel.swift
//  ArtApp
//
//  Created by Кирилл Бахаровский on 9/21/24.
//

import Foundation

struct Artists: Codable {
    let artists: [Artist]
}

// MARK: - Artist
struct Artist: Codable {
    let name, bio, image: String
    let works: [Work]
}

// MARK: - Work
struct Work: Codable {
    let title, image, info: String
}
