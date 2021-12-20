//
//  CheckValidateTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import UIKit

/**
 정규식 테스트
 */
class CheckValidateTestVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func clickCheckEmail() {
        let email = emailField.text
        // "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        if ValidateUtil.isValidEmailAddress(email: email) {
            showAlert(text: "MSG_VALIDATE_EMAIL".localized())
        } else {
            showAlert(text: "MSG_INVALIDATE_EMAIL".localized())
        }
    }
    
    @IBAction func clickCheckPwd() {
        let pwd = pwdField.text
        // "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$"
        if ValidateUtil.isValidatePassword(pwd: pwd) {
            showAlert(text: "MSG_VALIDATE_PWD".localized())
        } else {
            showAlert(text: "MSG_INVALIDATE_PWD".localized())
        }
    }
    
    func showAlert(text: String) {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert);
        let confirmAction = UIAlertAction(title: "CONFIRM".localized(), style: .default) { _ in
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
