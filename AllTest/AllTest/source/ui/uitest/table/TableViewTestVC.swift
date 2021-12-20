//
//  TableViewTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 UITableView 테스트
 */
class TableViewTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        // Identifier는 class 명과 같을 필요 없음
        let xibCell = UINib(nibName: "TableTestRegisterCell", bundle: nil)
        tableView.register(xibCell, forCellReuseIdentifier: "TableTestRegisterCell")
        
        // iOS15 header top padding이 추가. section header 사용 시 defualt 적용 주의
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

extension TableViewTestVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    // table에서 보여줄 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableTestCell", for: indexPath) as! TableTestCell
            cell.nameLabel.text = "story\(indexPath.row)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableTestRegisterCell", for: indexPath) as! TableTestRegisterCell
            cell.nameLabel.text = "reg\(indexPath.row)"
            return cell
        }
    }
    // section 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // section header text
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "story"
        } else {
            return "register"
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("did select \(indexPath)")
    }
    
}
