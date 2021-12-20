//
//  DropDownTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/09
//  custom header comment

import Foundation
import UIKit
import DropDown

/**
 DropDown library Test
 cocoapods 추가 필요
 pod 'DropDown'
 높이가 고정되나 커스텀 가능
 */
class DropDownTestVC: UIViewController {
    @IBOutlet weak var dropdownButton: UIButton!
    var dropdown: DropDown!
    
    @IBOutlet weak var customDropdownBtn: UIButton!
    var customDropdown: DropDown!
    
    override func viewDidLoad() {
        initDefaultDropdown()
        initCustomDropdown()
    }
    
    func initDefaultDropdown() {
        dropdown = DropDown()
        // 드롭다운 목록 설정
        dropdown.dataSource = ["menu1", "menu2", "menu3"]
        // 드롭다운 표시 위치
        dropdown.anchorView = dropdownButton
        // 드롭다운 표시 위치를 버튼 아래로 조정
        dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
        // 드롭다운 클릭 처리
        dropdown.selectionAction = {[unowned self] (index: Int, item: String) in
            NSLog("Dropdown select \(item)")
            self.dropdownButton.setTitle(item, for: .normal)
        }
        dropdown.cancelAction = {
            NSLog("Dropdown dismissed")
        }
        dropdown.willShowAction = {
            NSLog("Dropdown will show")
        }
    }
    
    @IBAction func clcikDropDownButton() {
        dropdown.show()
    }
    
    // MARK: - Custom Dropdown
    var list = [TestData]()
    func initCustomDropdown() {
        customDropdown = DropDown()
        var tempList = [String]()
        for n in 1 ... 5 {
            let data = TestData(title: "menu\(n)", desc: "desc\(n)")
            list.append(data)
            tempList.append(data.title)
        }
        customDropdown.dataSource = tempList
        customDropdown.anchorView = customDropdownBtn
        customDropdown.bottomOffset = CGPoint(x: 0, y:(customDropdown.anchorView?.plainView.bounds.height)!)
        customDropdown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.customDropdownBtn.setTitle(item, for: .normal)
        }
        
        // custom cell 설정
        customDropdown.cellNib = UINib(nibName: CustomDropdownCell.xibName, bundle: nil)
        // custom cell 높이 설정
        customDropdown.cellHeight = 60
        // dropdown 배경 설정
        customDropdown.backgroundColor = .yellow
        // custom cell view 설정
        customDropdown.customCellConfiguration = {(index: Index, item: String, cell: DropDownCell) -> Void in
            guard let customCell = cell as? CustomDropdownCell else {
                return
            }
            let item = self.list[index]
//            customCell.optionLabel.text = item.title
            customCell.descLabel.text = item.desc
        }
    }
    
    @IBAction func clickCustomDropdownBtn() {
        customDropdown.show()
    }
}
