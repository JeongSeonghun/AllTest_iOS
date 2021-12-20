//
//  ExpandCell.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 TableExpandCellTestVC 테스트 Cell
 */
class ExpandTitleCell: UITableViewCell {
    static let identifier = "ExpandTitleCell"
    
    @IBOutlet weak var titleLabel: UILabel!
}

class ExpandContentCell: UITableViewCell {
    static let identifier = "ExpandContentCell"
    
    @IBOutlet weak var contentTxtLabel: UILabel!
}
