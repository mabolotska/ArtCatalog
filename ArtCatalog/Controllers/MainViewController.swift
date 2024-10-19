//
//  ViewController.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 12/02/24.
//

import UIKit
import SnapKit


class MainViewController: UIViewController {

    var viewModel: MainViewModel = MainViewModel()
    var artistsDataSource: [MainCellViewModel] = []
   
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
          let searchBar = UISearchBar()
          searchBar.delegate = self
          return searchBar
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.readJSONFile { [weak self] in
                   self?.tableView.reloadData()
               }
    }
    
    func openDetails(artistName: String) {
        guard let artist = viewModel.retriveArtist(withId: artistName) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailsViewModel(artist: artist)
            let controller = DetailVC(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredArtists.count
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        let artist = viewModel.filteredArtists[indexPath.row]
               cell.setupCell(viewModel: artist)
             
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = viewModel.filteredArtists[indexPath.row]
    
        self.openDetails(artistName: artist.name)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterArtists(by: searchText)
        tableView.reloadData()
    }
}

extension MainViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
          title = "Artists"
        
      
        searchBar.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                    make.leading.trailing.equalToSuperview()
                }
                
                tableView.snp.makeConstraints { make in
                    make.top.equalTo(searchBar.snp.bottom)
                    make.leading.trailing.bottom.equalToSuperview()
                }
     
    }
}

