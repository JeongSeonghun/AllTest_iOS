//
//  TransparentVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/03
//  custom header comment

import Foundation
import UIKit

class TransparentVC: UIViewController {
    @IBAction func clickPop() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func clickDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
