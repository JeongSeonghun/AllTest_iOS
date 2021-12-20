//
//  MaterialTopBarVC.swift
//  AllTest
//  
//  Created by jsh on 2021/10/29
//  custom header comment

import Foundation
import UIKit
import MaterialComponents.MaterialAppBar

class MaterialTopBarVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let appBarViewController = MDCAppBarViewController()
    let heroHeaderView = HomeHeaderView()
    
    override func viewDidLoad() {
        appBarViewController.headerView.observesTrackingScrollViewScrollEvents = true // 필수
        
//        appBarViewController.inferTopSafeAreaInsetFromViewController = true
//        appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
        
        self.addChild(appBarViewController)
        
        // 2
        appBarViewController.navigationBar.backgroundColor = .clear
        appBarViewController.navigationBar.title = nil

         // 3
        let headerView = appBarViewController.headerView
        headerView.backgroundColor = .clear
        headerView.maximumHeight = HomeHeaderView.Constants.maxHeight
        headerView.minimumHeight = HomeHeaderView.Constants.minHeight

         // 4
        heroHeaderView.frame = headerView.bounds
        headerView.insertSubview(heroHeaderView, at: 0)

         // 5
        headerView.trackingScrollView = tableView

         // 6
        view.addSubview(appBarViewController.view)
        appBarViewController.didMove(toParent: self)
    }
}

class HomeHeaderView: UIView {
    struct Constants {
      static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
      static let minHeight: CGFloat = 44 + statusBarHeight
      static let maxHeight: CGFloat = 400.0
    }
    
    let imageView: UIImageView = {
      let imageView = UIImageView(image: #imageLiteral(resourceName: "target_test"))
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      return imageView
    }()

    let titleLabel: UILabel = {
      let label = UILabel()
      label.text = NSLocalizedString("News Ink", comment: "")
      label.textAlignment = .center
      label.textColor = .white
      label.shadowOffset = CGSize(width: 1, height: 1)
      label.shadowColor = .darkGray
      return label
    }()
    
    // 1
    init() {
      super.init(frame: .zero)
      autoresizingMask = [.flexibleWidth, .flexibleHeight]
      clipsToBounds = true
      configureView()
    }

    // 2
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    // 3
    func configureView() {
      backgroundColor = .darkGray
      addSubview(imageView)
      addSubview(titleLabel)
    }

    // 4
    override func layoutSubviews() {
      super.layoutSubviews()
//      imageView.frame = bounds
      titleLabel.frame = CGRect(
        x: 0,
        y: Constants.statusBarHeight,
        width: frame.width,
        height: frame.height - Constants.statusBarHeight)
        
        // 하단에서 올라는 형태 확인용
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
//            titleLabel.topAnchor.constraint(equalTo: topAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension MaterialTopBarVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "index \(indexPath)"
        return cell
    }
    
    
}
