//
//  NotificationTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/14
//  custom header comment

import Foundation
import UIKit

// notification name
let NOTIFICATION_TEST_ACTION = "NotificationTestAction"

/**
 Notification 테스트
 */
class NotificationTestVC: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var objectTestLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction(_:)), name: NSNotification.Name(NOTIFICATION_TEST_ACTION), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction2(_:)), name: .testObjectSend, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NOTIFICATION_TEST_ACTION), object: nil)
        NotificationCenter.default.removeObserver(self, name: .testObjectSend, object: nil)
    }
    
    @IBAction func notificationAction(_ notification: NSNotification) {
        NSLog("receive notification")
        let form = DateFormatter()
        form.dateFormat = "HH:mm:ss"
        textLabel.text = form.string(from: Date())
    }
    @IBAction func notificationAction2(_ notification: NSNotification) {
        guard let date = notification.object as? Date else {
            NSLog("receive notification empty object")
            return
        }
        NSLog("receive notification object \(date)")
        let form = DateFormatter()
        form.dateFormat = "HH:mm:ss:SSS"
        objectTestLabel.text = "recieve time :\(form.string(from: Date()))\nobject time : \(form.string(from: date))"
    }
}

class TestNotiView: UIView {
    var button: UIButton!
    var button2: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        backgroundColor = .blue
        
        button = UIButton()
        button2 = UIButton()

        addSubview(button)
        addSubview(button2)
        button.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            button2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            button2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            button2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        button.setTitle("send", for: .normal)
        button.addTarget(self, action: #selector(clickSend), for: .touchUpInside)
        button2.setTitle("send object", for: .normal)
        button2.addTarget(self, action: #selector(clickSendObject), for: .touchUpInside)
    }
    
    // 기본 액션 전달
    @IBAction func clickSend() {
        NSLog("post notification")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_TEST_ACTION), object: nil)
    }
    
    // object 전달 테스트
    @IBAction func clickSendObject() {
        let date = Date()
        NSLog("post notification object : \(date)")
        NotificationCenter.default.post(name: .testObjectSend, object: date)
    }
}
