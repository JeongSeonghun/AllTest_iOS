//
//  UtilExtension.swift
//  AllTest
//
//  Created by jsh on 2021/08/20.
//

import Foundation

extension String {
    /// Localizale.strings 정의 문자 반환
    func localized(bundle: Bundle = .main, tableName:String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
    
    /// 여백 제거
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// 일부 문자 반환
    func subString(start: Int, end: Int) -> String {
        guard start >= 0, end >= 0, end <= self.count else {
            return ""
        }
        let startIndex = index(self.startIndex, offsetBy: start)
        let endIndex = index(self.startIndex, offsetBy: end + 1)
        return String(self[startIndex ..< endIndex])
    }
}

extension UILabel {
    @IBInspectable var localizeText: String {
        set { text = newValue.localized() }
        get { return self.localizeText }
    }
}

extension UIButton {
    @IBInspectable var localizeText: String {
        set { setTitle(newValue.localized(), for: .normal) }
        get { return self.localizeText }
    }
}

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
}
