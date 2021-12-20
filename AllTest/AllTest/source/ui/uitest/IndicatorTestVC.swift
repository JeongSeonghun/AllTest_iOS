//
//  IndicatorTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/28
//  custom header comment

import Foundation
import UIKit

/**
 Indicator 테스트
 */
class IndicatorTestVC: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        indicator.color = .cyan
        indicator.hidesWhenStopped = true
    }
    
    @IBAction func start() {
        indicator.startAnimating()
    }
    
    @IBAction func stop() {
        indicator.stopAnimating()
    }
    
    @IBAction func show() {
        TestIndicator.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            TestIndicator.hide()
        }
    }
    
}
