//
//  ChangeHeightTableView.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

// 동적 높이 테이블 구현을 위한 class
class ChangeHeightTableView: UITableView {
    override var contentSize:CGSize {
         didSet {
             self.invalidateIntrinsicContentSize()
         }
     }

     override var intrinsicContentSize: CGSize {
         self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
     }
}
