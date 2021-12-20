//
//  DBTestCell.swift
//  AllTest
//  
//  Created by jsh on 2021/08/26
//  custom header comment

import Foundation
import UIKit

/**
 DataSaveTestVC sqlite 테스트 cell
 */
class DBTestCell: UITableViewCell {
    static let identifier = "DBTestCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var deleteClickHandler: (() -> Void)?
    
    @IBAction func clickDelete() {
        deleteClickHandler?()
    }
}
