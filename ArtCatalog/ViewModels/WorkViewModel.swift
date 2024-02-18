//
//  WorkViewModel.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import Foundation
struct WorkViewModel {
    var title: String?
    var image: String?
    var info: String?
    
    init(work: Work) {
        self.title = work.title ?? ""
        self.image = work.image ?? ""
        self.info = work.info ?? ""
    }
}
