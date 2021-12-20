//
//  TargetTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/10/29
//  custom header comment

import Foundation
import UIKit

/**
 Target Test(동일 명칭으로 클래스 및 storyboard 따로 사용)
 */
class TargetTestVC: UIViewController {
    @IBOutlet weak var target2Label: UILabel!
    
    override func viewDidLoad() {
        target2Label.text = Util.currentAppVersion()
    }
}
