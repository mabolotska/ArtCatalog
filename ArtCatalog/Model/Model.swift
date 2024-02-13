//
//  Model.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 12/02/24.
//

import Foundation


// MARK: - ModelTwo
struct ModelTwo: Codable {
    var artists: [Artist]?
}

// MARK: - Artist
struct Artist: Codable {
    let name, bio, image: String?
    let works: [Work]?
}

// MARK: - Work
struct Work: Codable {
    let title, image, info: String?
}
