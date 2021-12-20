//
//  PagingManager.swift
//  AllTest
//  
//  Created by jsh on 2021/08/26
//  custom header comment

import Foundation
import UIKit

/// 페이징 처리를 위한 delegate
protocol PagingDelegate {
    /// 다음 페이지 요청
    func needNextPage(nextPage: Int)
    /// 통신 중 상태 체크
    func isLoading() -> Bool
    /// 페이지 목록 수
    func pageCnt() -> Int
}

/// 페이지 정보를 직접 설정할때 데이터에 구현할 protocol
protocol Page {
    /// 전체 개수
    func getTotal() -> Int
    /// 현제 페이지
    func getPage() -> Int
}

/** 패이징 처리용 매니저
 1. UITableViewDataSourcePrefetching 혹은 UICollectionViewDataSourcePrefetching
 상속 후 checkNeedNextPage 호출 연결 필요
 2. 목록을 갱신하기 전 currentPage 설정하거나 setPageInfo 호출 필요
 */
class PagingManager {
    /// 페이징 처리 delegate
    var pagingDelegate: PagingDelegate?
    /// 목록을 갱신하기 전 currentPage 설정하거나 setPageInfo 호출 필요(선택)
    var currentPage: Page? {
        set {
            page = newValue?.getPage() ?? 1
            totalCnt = newValue?.getTotal() ?? 0
        }
        get {
            return self.currentPage
        }
    }
    /// 페이지 당 목록 갯수
    private var pageCnt: Int {
        get {
            return pagingDelegate?.pageCnt() ?? 10
        }
    }
    /// 마지막 조회 페이지
    private var page = 1
    /// 전체 아이템 갯수
    private var totalCnt = 0
    
    
    /**
     다음 페이지 요청 결정
     func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) 에서 호출
     func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath])
     - parameters:
        - index: TablewView, CollectionView에서 다음에 보여 줄 아이템 위치
     */
    func checkNeedNextPage(index: Int) {
        let total = totalCnt
        let curPage = page
        var totalPage = total / pageCnt
        if total % pageCnt != 0 { totalPage =  totalPage + 1}

        if let delegate = pagingDelegate, total > 0 {
            if (delegate.isLoading()) {return}
            
            if index >= (curPage - 1) * pageCnt && curPage < totalPage {
                delegate.needNextPage(nextPage: curPage + 1)
            }
        }
    }
    
    /**
     현제 표시 페이지 및 전체 갯수 설정
     다음 페이지 요청 여부를 결정하기 위해 목록을 갱신하기 전 호출하거나
     currentPage 설정 필요(선택)
     */
    func setPageInfo(currentPage: Int, totalCnt: Int) {
        self.page = currentPage
        self.totalCnt = totalCnt
    }

}
