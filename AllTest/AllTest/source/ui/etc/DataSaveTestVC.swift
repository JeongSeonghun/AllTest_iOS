//
//  DataSaveTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import UIKit

/**
 Data 저장 테스트
 UserDefaultData, KeyChain, SQLite3
 */
class DataSaveTestVC: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var dbTitleField: UITextField!
    @IBOutlet weak var dbDescField: UITextField!
    @IBOutlet weak var dbIdLabel: UILabel!
    @IBOutlet weak var dbTable: UITableView!
    
    var dbItems = Array<TestData>()
    
    let dbManager = SQLiteDataManager()
    
    override func viewDidLoad() {
        randomLabel.text = nil
        dbIdLabel.text = nil
        initData()
        initDBData()
    }
    
    // MARK: - UserDefault, Keychain test
    func initData() {
        // UserDefault
        nameField.text = UserDefaultDataManager.instance.getName()
        
        // keychain
        randomLabel.text = KeyChainDataManager.instance.readToken()
    }
    
    @IBAction func clickSave() {
        // UserDefault
        if let name = nameField.text {
            UserDefaultDataManager.instance.saveName(name: name)
        }
        
        // keychain
        if let random = randomLabel.text {
            if KeyChainDataManager.instance.readToken() == nil {
                _ = KeyChainDataManager.instance.createToken(token: random)
            } else {
                _ = KeyChainDataManager.instance.updateToken(token: random)
            }
        }
        
        view.endEditing(true)
    }
    
    @IBAction func clickRandomInit() {
        randomLabel.text = RandomUtil.getRandomString(size: 10)
    }
    
    @IBAction func clickInitData() {
        UserDefaultDataManager.instance.reset()
        _ = KeyChainDataManager.instance.deleteToken()
    }
    
    // MARK: - SQLite db test
    func initDBData() {
        dbItems = dbManager.selectList()
        dbTable.reloadData()
    }
    
    @IBAction func clickInsert() {
        let title = dbTitleField.text
        let desc = dbDescField.text
        let data = TestData(title: title ?? "", desc: desc)
        dbManager.insert(data: data)
        
        initDBData()
    }
    
    @IBAction func clickUpdate() {
        guard let id = dbIdLabel.text, !id.isEmpty else {
            return
        }
        
        let title = dbTitleField.text
        let desc = dbDescField.text
        let data = TestData(title: title ?? "", desc: desc, id: Int(id))
        dbManager.update(data: data)
        
        initDBData()
    }
    
    @IBAction func clickSelect() {
        dbItems = dbManager.select(title: dbTitleField.text ?? "")
        dbTable.reloadData()
    }
    
    @IBAction func clickSelectAll() {
        initDBData()
    }
    
    func deleteItem(pos: Int) {
        let item = dbItems[pos]
        
        if let id = item.id {
            dbManager.delete(id: id)
            
            initDBData()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DataSaveTestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DBTestCell.identifier, for: indexPath) as! DBTestCell
        
        let item = dbItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descLabel.text = item.desc
        
        cell.deleteClickHandler = {
            self.deleteItem(pos: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dbItems[indexPath.row]
        dbIdLabel.text = String(item.id ?? -1)
        dbTitleField.text = item.title
        dbDescField.text = item.desc
    }
    
}
