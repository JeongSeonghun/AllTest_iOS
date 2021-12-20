//
//  LifeCycleTestVC.swift
//  AllTest
//
//  Created by jsh on 2021/08/20.
//

import Foundation
import UIKit

/**
 LifeCycle 확인
 */
class LifeCycleTestVC: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        NSLog("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NSLog("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NSLog("viewDidDisappear")
    }
    
    override func viewWillLayoutSubviews() {
        NSLog("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        NSLog("viewDidLayoutSubviews")
    }
    
    @IBAction func clickAddTxt() {
        label.text?.append("Text")
    }
}
