//
//  QuickActionTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/11/17
//  custom header comment

import Foundation
import UIKit

/**
 Quick Action Test
 */
class QuickActionTestVC: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        NSLog("check viewDidLoad")
        check()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("check viewWillAppear")
        registerNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("check viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NSLog("check viewWillDisappear")
        unregisterNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NSLog("check viewDidDisappear")
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkQuickAction(_:)), name: .testQuickActionCheck, object: nil)
    }
    
    func unregisterNotification() {
        NotificationCenter.default.removeObserver(self, name: .testQuickActionCheck, object: nil)
    }
    
    @IBAction func checkQuickAction(_ notification: NSNotification) {
        check()
    }
    
    func check() {
        textLabel.text = "quick action check: \(TestManager.instance.quickAction ?? "")"
        TestManager.instance.quickAction = nil
    }
}

extension QuickActionTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestContactModel.shared.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickActionCell", for: indexPath) as! QuickActionCell
        let item = TestContactModel.shared.contacts[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.emailLabel.text = item.email
        cell.phoneLabel.text = item.phone
        cell.favoriteSwitch.isOn = item.isFavorite
        
        cell.favoriteHandler = {isOn in
            var change = item
            change.isFavorite = isOn
            TestContactModel.shared.updateContact(change)
            self.tableView.reloadData()
        }
        
        return cell
    }
    
}

class QuickActionCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    var favoriteHandler: ((Bool) -> Void)?
    
    @IBAction func clickFavorite(_ sender: UISwitch) {
        favoriteHandler?(sender.isOn)
    }
}
