//
//  TestNavigationController.swift
//  AllTest
//  
//  Created by jsh on 2022/01/14
//  custom header comment

import Foundation
import UIKit

class TestNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController?{ return topViewController}
    
    override var childForStatusBarHidden: UIViewController?{ return topViewController}
}
