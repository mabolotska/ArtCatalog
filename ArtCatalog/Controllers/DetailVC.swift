//
//  DetailVC.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import UIKit


class DetailVC: UIViewController {
    var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var nameLabel: UILabel = {
       let label = UILabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configView()
    }
    
    func configView() {
        self.title = "Painter Details"
        nameLabel.text = viewModel.artistName
        pictureImageView.image = UIImage(named: viewModel.artistImage)
       
    }
}


extension DetailVC {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(pictureImageView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(50)
        }
        
        pictureImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}
