//
//  TestAlert.swift
//  AllTest
//  
//  Created by jsh on 2022/01/11
//  custom header comment

import Foundation

class TestAlert {
    private static var alert: UIAlertController?
    
    static func show(_ vc: UIViewController, msg: String, fstTitle: String = "CONFIRM".localized(), sndTitle: String? = nil, fstAction: (() -> Void)? = nil, sndAction: (() -> Void)? = nil) {
        
        hide()
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: fstTitle, style: .default, handler: { _ in
            self.alert = nil
            if let action = fstAction {
                action()
            }
        }))
        if let snd = sndTitle {
            alert.addAction(UIAlertAction(title: snd, style: .cancel, handler: { _ in
                self.alert = nil
                if let action = sndAction {
                    action()
                }
            }))
        }
        self.alert = alert
        vc.present(alert, animated: false, completion: nil)
    }
    
    static func hide() {
        guard let alert = alert else { return }
        alert.dismiss(animated: false)
        self.alert = nil
    }
}
