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
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell

  
        guard let artist = viewModel.artist(at: indexPath.row) else {
         
              return UITableViewCell()
          }

         cell.setupCell(viewModel: artist)
             
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artist = viewModel.artist(at: indexPath.row) else {
            return
        }
        self.openDetails(artistName: artist.name)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



extension MainViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "Artists"
        
  
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
