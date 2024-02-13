//
//  MainViewModel.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import Foundation


class MainViewModel {

    private var dataSource: ModelTwo?

       func numberOfRows(in section: Int) -> Int {
           return dataSource?.artists?.count ?? 0
       }
       
       func artist(at index: Int) -> MainCellViewModel? {
           guard let artist = dataSource?.artists?[index] else {
               return nil
           }
           return MainCellViewModel(imageArtist: artist.image ?? "", bioLabel: artist.bio ?? "", name: artist.name ?? "")
       }

       func readJSONFile(completion: @escaping () -> Void) {
           let fileName = "artists"
           let fileType = "json"

           if let path = Bundle.main.path(forResource: fileName, ofType: fileType){
               do{
                   let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                   let decoder = JSONDecoder()
                   let model = try decoder.decode(ModelTwo.self, from: jsonData)
                   dataSource = model
                   completion()
               }
               catch{
                   print("Json file not found")
               }
           } else {
               print("JSON file path not found")
           }
       }
   
    
    func retriveArtist(withId id: String) -> Artist? {
        guard let artist = dataSource?.artists?.first(where: {$0.name == id}) else {
            return nil
        }
        
        return artist
    }
}
