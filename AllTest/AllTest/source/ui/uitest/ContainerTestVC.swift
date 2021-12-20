//
//  ContainerTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/28
//  custom header comment

import Foundation
import UIKit

/**
 ContainerView 테스트
 prepare가 먼저 호출됨
 */
class ContainerTestVC: UIViewController {
    
    override func viewDidLoad() {
        NSLog("3. ContainerTestVC viewDidLoad")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("1. prepare segue")
    }
}
