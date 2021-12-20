//
//  AlertTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import UIKit

/**
 UIAlertController 테스트
 */
class AlertTestVC: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func showUIAlert() {
        let alertController = UIAlertController(title: "POPUP_COMMON".localized(), message: "MSG_COMMON".localized(), preferredStyle: .alert);
        let confirmAction = UIAlertAction(title: "CONFIRM".localized(), style: .default) { _ in
        }
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .cancel) { _ in
        }
        let delAction = UIAlertAction(title: "DELETE".localized(), style: .destructive) { _ in
        }
        // 버튼이 3개 이상 일경우 세로로 배치됨
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        alertController.addAction(delAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func showUIAlertSheet() {
        let alertController = UIAlertController(title: "POPUP_COMMON".localized(), message: "MSG_COMMON".localized(), preferredStyle: .actionSheet);
        let confirmAction = UIAlertAction(title: "CONFIRM".localized(), style: .default) { _ in
        }
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .cancel) { _ in
        }
        let delAction = UIAlertAction(title: "DELETE".localized(), style: .destructive) { _ in
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        alertController.addAction(delAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
