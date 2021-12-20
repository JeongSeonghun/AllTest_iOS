//
//  PagingTestRes.swift
//  AllTest
//  
//  Created by jsh on 2021/08/26
//  custom header comment

import Foundation

struct PagingTestRes {
    var list: Array<TestData>
    var page: PagingData
}

struct PagingData: Page {
    var currentPage: Int
    var totoalCnt: Int
    
    func getTotal() -> Int {
        return totoalCnt
    }
    
    func getPage() -> Int {
        return currentPage
    }
    
    
}
