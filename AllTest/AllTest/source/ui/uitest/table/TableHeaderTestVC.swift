//
//  TableHeaderTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 UITableView header 테스트
 */
class TableHeaderTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        // 테이블 해더 설정
        // 1 높이가 없어서 표시x
//        tableView.tableHeaderView = CustomHeader()
        // 2 높이 지정
//        let header = CustomHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
//        tableView.tableHeaderView = header
        // 3 동적 높이
        let headerView = CustomHeader()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        tableView.tableHeaderView = headerView
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
    }
}

extension TableHeaderTestVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "testContent"
        return cell
    }
    
    // 색션 해더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CustomHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        header.titleLabel.text = "section \(section)"
        header.subTitleLabel.text = "section \(section) sub text"
        return header
    }
    
    // 해더 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
