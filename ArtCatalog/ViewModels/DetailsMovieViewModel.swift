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
    var works: [WorkViewModel]
    
    init(artist: Artist) {
        self.artistData = artist
        self.artistName = artist.name ?? "NO"
        self.artistImage = artist.image ?? ""
        
        // Convert each work into a WorkViewModel and store them in the works array
               self.works = artist.works?.map { WorkViewModel(work: $0) } ?? []
    }
}
