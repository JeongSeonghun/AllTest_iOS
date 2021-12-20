//
//  CustomDropdownCell.swift
//  AllTest
//  
//  Created by jsh on 2021/09/09
//  custom header comment

import Foundation
import UIKit
import DropDown

/**
 DropDown 라이브러리 cell custom
 DropDownCell가 가지고 있는 optionLabel 링크 필요. xib 확인
 */
class CustomDropdownCell: DropDownCell {
    static let xibName = "CustomDropdownCell"
    @IBOutlet weak var descLabel: UILabel!
    
}
