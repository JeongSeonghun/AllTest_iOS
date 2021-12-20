//
//  TableTestCell.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 TableViewTestVC 테스트 Cell
 */
// 스토리보드
class TableTestCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}

// 커스텀 뷰(xib)
class TableTestRegisterCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
}
