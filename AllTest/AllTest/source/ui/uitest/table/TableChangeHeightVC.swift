//
//  TableChangeHeightVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 UITableView 동적 높이 테스트
 */
class TableChangeHeightVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        let xibCell = UINib(nibName: "TableTestRegisterCell", bundle: nil)
        tableView.register(xibCell, forCellReuseIdentifier: "TableTestRegisterCell")
    }
}

extension TableChangeHeightVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableTestRegisterCell", for: indexPath) as! TableTestRegisterCell

        var text = ""
        for _ in 0 ... indexPath.row {
            text.append("long text\nlong long long\nabc test\n")
        }
        cell.nameLabel.text = text
        
        return cell
    }

}

