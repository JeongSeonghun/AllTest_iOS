//
//  RefreshTestVC.swift
//  AllTest
//  
//  Created by jsh on 2022/03/25
//  custom header comment

import Foundation
import UIKit

class RefreshTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var showCnt = 5
    
    override func viewDidLoad() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        initRefresh()
    }
    
    func initRefresh() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        NSLog("refresh start")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NSLog("refresh stop")
            self.tableView.refreshControl?.endRefreshing()
            self.showCnt += 1
            self.tableView.reloadData()
        }
    }
    
    @IBAction func startRefresh() {
        NSLog("refresh user start")
        // begin 호출만으로는 refresh가 바로 보이지 않음. 별도 메서드 구현.
        tableView.refreshControl?.programaticallyBeginRefreshing(in: tableView)
    }
    
    @IBAction func stopRefresh() {
        NSLog("refresh user stop")
        tableView.refreshControl?.endRefreshing()
    }
    
}

extension RefreshTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "content \(indexPath.row)"
        return cell
    }
    
}
