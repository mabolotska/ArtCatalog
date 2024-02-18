import UIKit
import SnapKit

class MyViewController: UIViewController {

    let titleLabel = UILabel()
    let scrollView = UIScrollView()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Configure title label
        titleLabel.text = "Title"
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)

        // Configure scroll view
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        // Configure image view
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray // optional, for better visibility
        scrollView.addSubview(imageView)

        // Set up constraints using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview() // Constraint titleLabel to leading and trailing edges
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width).offset(-40) // Adjust as needed
            make.height.equalTo(scrollView.snp.width) // Square scrollView
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Load image into the imageView
        if let image = UIImage(named: "VanGogh2") {
            imageView.image = image
        }
    }
}

