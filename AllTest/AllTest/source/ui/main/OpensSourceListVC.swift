//
//  OpensSourceListVC.swift
//  AllTest
//
//  Created by jsh on 2021/11/23
//  custom header comment

import Foundation
import UIKit

/**
 Open Source 목록
 라이선스 비교 https://www.olis.or.kr/license/compareGuide.do
 */
class OpensSourceListVC: UIViewController {
    
    var tableView = UITableView()
    
    var dataList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.bounces = false
        
        if let path = Bundle.main.path(forResource: "OpensourceLicenseList", ofType: "plist") {
            let dic = NSDictionary(contentsOfFile: path)
            
            if let list = dic?["license"] as? Array<NSDictionary> {
                for license in list {
                    let title = license["title"] as? String ?? ""
                    let content = license["content"] as? String ?? ""
                    let url = license["url"] as? String ?? ""
                    dataList.append("\(title)\n\(url)\n\(content)")
                }
            }
        }
        
    }
}

extension OpensSourceListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
