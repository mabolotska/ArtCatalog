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
            
            // Show navigation bar and tab bar
            self.navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = false
      
    }
}


extension DetailVC {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        //        view.addSubview(nameLabel)
        //        view.addSubview(pictureImageView)
        //
        //        nameLabel.snp.makeConstraints { make in
        //            make.top.leading.equalToSuperview().offset(50)
        //        }
        //
        //        pictureImageView.snp.makeConstraints { make in
        //            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        //            make.width.equalTo(100)
        //            make.centerX.equalToSuperview()
        //        }
        
        
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

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) as? WorkCell else {
//                  return
//              }
//        
//        let fullView = UIView()
//        fullView.backgroundColor = .magenta
//        fullView.frame = UIScreen.main.bounds
//        //Create a title
//       // let title = UILabel.
//              
//              // Create the full-screen image view
//        let newImageView = UIImageView(image: cell.imageView.image)
//          //    newImageView.frame = UIScreen.main.bounds
//              newImageView.backgroundColor = .lightGray
//              newImageView.contentMode = .scaleAspectFit
//              newImageView.isUserInteractionEnabled = true
//        newImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(10)
//            make.height.equalTo(200)
//            make.width.equalTo(200)
//            make.centerX.equalToSuperview()
//        }
//              
////              // Create a dismiss button
////              let dismissButton = UIButton(type: .system)
////              dismissButton.setTitle("< >", for: .normal)
////              dismissButton.addTarget(self, action: #selector(dismissFullscreenImage), for: .touchUpInside)
////              dismissButton.translatesAutoresizingMaskIntoConstraints = false
////              newImageView.addSubview(dismissButton) // Add dismiss button to newImageView
////              
////              // Set dismiss button constraints
////              NSLayoutConstraint.activate([
////                  dismissButton.topAnchor.constraint(equalTo: newImageView.safeAreaLayoutGuide.topAnchor, constant: 20),
////                  dismissButton.leadingAnchor.constraint(equalTo: newImageView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
////                  dismissButton.widthAnchor.constraint(equalToConstant: 80),
////                  dismissButton.heightAnchor.constraint(equalToConstant: 40)
////              ])
//              
//              // Add the full-screen image view to the view hierarchy
//              self.view.addSubview(fullView)
//        fullView.addSubview(newImageView)
//              
//              // Hide navigation bar and tab bar
//              self.navigationController?.isNavigationBarHidden = true
//              self.tabBarController?.tabBar.isHidden = true
//    }
//    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WorkCell else {
            return
        }
        
        let fullView = UIView()
        fullView.backgroundColor = .magenta
        fullView.frame = UIScreen.main.bounds
        self.view.addSubview(fullView)
        
        let title = UILabel()
        title.text = cell.titleLabel.text
        fullView.addSubview(title)
        
        let newImageView = UIImageView(image: cell.imageView.image)
        newImageView.backgroundColor = .lightGray
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        fullView.addSubview(newImageView)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        newImageView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        // Aspect ratio constraint
        newImageView.snp.makeConstraints { make in
            make.width.equalTo(newImageView.snp.height).multipliedBy(0.75)
        }
        
        // Hide navigation bar and tab bar
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
}
