//
//  PagingTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/26
//  custom header comment

import Foundation
import UIKit

/**
 페이징처리 테스트
 */
class PagingTestVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var testModel = TestModel()
    var pagingManager = PagingManager()
    
    var items = Array<TestData>()
    
    let PAGE_CNT = 10
    
    override func viewDidLoad() {
        testModel.setPagingTestInfo(totalCnt: 46)
        pagingManager.pagingDelegate = self
        getList(page: 1)
    }
    
    private func getList(page: Int) {
        testModel.getPagingData(page: page, cnt: PAGE_CNT) { res in
            self.pagingManager.currentPage = res.page
//            self.pagingManager.setPageInfo(currentPage: res.page.currentPage, totalCnt: res.page.totoalCnt)
            self.items.append(contentsOf: res.list)
            self.tableView.reloadData()
        }
    }
}

extension PagingTestVC: PagingDelegate {
    func needNextPage(nextPage: Int) {
        getList(page: nextPage)
    }
    
    func isLoading() -> Bool {
        return testModel.isLoading()
    }
    
    func pageCnt() -> Int {
        return PAGE_CNT
    }
}

extension PagingTestVC: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PagingTestCell.identifier, for: indexPath) as! PagingTestCell
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descLabel.text = item.desc
        
        return cell
    }
    
    // MARK:UITableViewDataSourcePrefetching
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        pagingManager.checkNeedNextPage(index: indexPaths[0].row)
    }
}
