//
//  DetailVC.swift
//  ArtCatalog
//
//  Created by Maryna Bolotska on 13/02/24.
//

import UIKit


class DetailVC: UIViewController {
    var viewModel: DetailsViewModel
    let scrollView = UIScrollView()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        let itemWidth = (UIScreen.main.bounds.width/2 - (layout.minimumInteritemSpacing * 6))
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * (2/3))
          return collectionView
      }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configView()
    }
    
   
    func configView() {
        self.title = "Painter Details"
//              nameLabel.text = viewModel.artistName
//              pictureImageView.image = UIImage(named: viewModel.artistImage)
       
              collectionView.dataSource = self
              collectionView.delegate = self
              collectionView.register(WorkCell.self, forCellWithReuseIdentifier: "WorkCell")
       
    }
    
    
    @objc func dismissFullscreenImage(_ sender: UIButton) {
        sender.superview?.removeFromSuperview()
      
            self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
      
    }
}


extension DetailVC {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
    
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
         
        }
    }
}


extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.works.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkCell", for: indexPath) as! WorkCell
               let work = viewModel.works[indexPath.item]
               cell.configure(with: work)
        
               return cell
    }
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WorkCell else {
            return
        }
        
        let fullView = UIView()
        fullView.frame = UIScreen.main.bounds
        fullView.backgroundColor = .white
        self.view.addSubview(fullView)
        
        let title = UILabel()
        title.text = cell.titleLabel.text
        fullView.addSubview(title)
        
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        fullView.addSubview(scrollView)
        
        let newImageView = UIImageView(image: cell.imageView.image)
        newImageView.backgroundColor = .lightGray
        newImageView.contentMode = .scaleAspectFill
        newImageView.isUserInteractionEnabled = true
        scrollView.addSubview(newImageView)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = cell.descriptionLabel.text
        descriptionLabel.numberOfLines = 0
        fullView.addSubview(descriptionLabel)
        
        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("< >", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissFullscreenImage), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(dismissButton)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
           make.width.equalTo(view.snp.width).offset(-40)
            
            make.height.equalTo(scrollView.snp.width)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-20)
        }
        
        newImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
    //        make.height.equalTo(newImageView.snp.width).multipliedBy(0.75)
        }
        
       
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(newImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.lessThanOrEqualTo(dismissButton.snp.top).offset(-10)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().offset(-50)
        }

        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
 


}
