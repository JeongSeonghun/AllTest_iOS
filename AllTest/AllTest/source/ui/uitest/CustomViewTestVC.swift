//
//  CustomViewTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

/**
 CustomView 테스트
 */
class CustomViewTestVC: UIViewController {
    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var clickCntLabel: UILabel!
    
    override func viewDidLoad() {
        customView.textLabel.text = "custom"
        
//        let addCustomView = CustomView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        let addCustomView = CustomView()
        view.addSubview(addCustomView)
        
        addCustomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        addCustomView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 10),
            addCustomView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            addCustomView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 10),
            addCustomView.heightAnchor.constraint(equalToConstant: 45)
        ] )
        addCustomView.setClickAction { (cnt) in
            self.clickCntLabel.text = "add view click \(cnt)"
        }
        
        customView.clickAction = {cnt in
            self.clickCntLabel.text = "click \(cnt)"
        }
    }
}
