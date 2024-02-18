//
//  WorkCell.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import UIKit

class WorkCell: UICollectionViewCell {
    // MARK: - Public
        func configure(with info: WorkViewModel) {
            imageView.image = UIImage(named: info.image!)
            titleLabel.text = info.title
            descriptionLabel.text = info.info
        }

        // MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialize()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
   
    // MARK: - Private properties
 let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}


// MARK: - Private methods
private extension WorkCell {
    func initialize() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()

        }
    }
}
