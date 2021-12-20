//
//  CustomSideVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/09
//  custom header comment

import Foundation
import UIKit

class CustomSideVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
    }
}

extension CustomSideVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "menu\(indexPath.row)"
        
        return cell
    }
    
}
