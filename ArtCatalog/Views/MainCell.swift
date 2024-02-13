//
//  MainCell.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 12/02/24.
//

import UIKit

class MainCell: UITableViewCell {
    

    
    
    func setupCell(viewModel: MainCellViewModel) {
        self.imageArtist.image = UIImage(named: viewModel.imageArtist!)
        self.bioLabl.text = viewModel.bioLabel
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageArtist: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    private let bioLabl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
}


extension MainCell {
    func setupUI(){
        contentView.addSubview(imageArtist)
        contentView.addSubview(bioLabl)
        
        imageArtist.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.height.equalTo(100)
            make.width.equalTo(imageArtist.snp.height)
        }
        
        bioLabl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(5)
            make.leading.equalTo(imageArtist.snp.trailing).offset(5)
        }
    }
}
