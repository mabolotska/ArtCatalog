//
//  DetailsViewModel.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import Foundation


class DetailsViewModel {
    var artistData: Artist
    
    var artistName: String
    var artistImage: String
    
    init(artist: Artist) {
        self.artistData = artist
        self.artistName = artist.name ?? "NO"
        self.artistImage = artist.image ?? ""
    }
}
