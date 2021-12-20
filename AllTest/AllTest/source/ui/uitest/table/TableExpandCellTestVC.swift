//
//  TableExpandCellTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 UITableView cell 확장 테스트
 Section, Header활용
 ex) 공지사항
 */
class TableExpandCellTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items = [ExpandItem]()
    override func viewDidLoad() {
        makeItems()
        tableView.reloadData()
    }
    func makeItems() {
        for i in 0 ..< 10 {
            var text = ""
            for cnt in 0 ..< i+1 {
                if !text.isEmpty { text.append("\n")}
                text.append("text\(cnt)")
            }
            items.append(ExpandItem(title: "title\(i)", text: text))
        }
    }
    func getItem(pos: Int) -> ExpandItem {
        return items[pos]
    }
}

extension TableExpandCellTestVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = getItem(pos: section)
        return item.isOpen ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = getItem(pos: indexPath.section)
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandTitleCell.identifier, for: indexPath) as! ExpandTitleCell
            cell.titleLabel.text = item.title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandContentCell.identifier, for: indexPath) as! ExpandContentCell
            cell.contentTxtLabel.text = item.text
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let item = getItem(pos: indexPath.section)
            if item.isOpen {
                items[indexPath.section].isOpen = false
            } else {
                items[indexPath.section].isOpen = true
            }
            let section = IndexSet(integer: indexPath.section)
            tableView.reloadSections(section, with: .fade)
            
        }
    }
    
}

struct ExpandItem {
    var title: String
    var text: String
    var isOpen: Bool = false
}

