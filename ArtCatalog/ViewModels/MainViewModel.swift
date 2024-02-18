//
//  MainViewModel.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import Foundation


class MainViewModel {
    var filteredArtists: [MainCellViewModel] = []
    private var allArtists: [MainCellViewModel] = []
    private var dataSource: ModelTwo?

    func numberOfRows(in section: Int) -> Int {
           return filteredArtists.count
       }
       

           func artist(at index: Int) -> MainCellViewModel? {
                  return filteredArtists[index]
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
                          allArtists = model.artists?.compactMap {
                              MainCellViewModel(imageArtist: $0.image ?? "", bioLabel: $0.bio ?? "", name: $0.name ?? "")
                          } ?? []
                          filteredArtists = allArtists
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
    
    func filterArtists(by searchText: String) {
            if searchText.isEmpty {
                filteredArtists = allArtists
            } else {
                filteredArtists = allArtists.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
}
