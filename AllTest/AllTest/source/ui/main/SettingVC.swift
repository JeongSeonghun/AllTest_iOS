//
//  SettingVC.swift
//  AllTest
//
//  Created by jsh on 2021/08/20.
//

import Foundation
import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = Array<SettingItem>()
    
    override func viewDidLoad() {
        initData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 하단 탭 메뉴 클릭 시 타이틀 변환
        self.navigationController?.navigationBar.topItem?.title = "TAB_SETTING".localized()
    }
    
    func initData() {
        let version = "V\(Util.currentAppVersion() ?? "") (\(Util.currentAppBuildVersion() ?? "")) \(Util.isDebug() ? "STATE_DEBUG".localized() : "STATE_RELEASE".localized())"
        
        items.append(SettingItem(title: "SETTING_APP_VERSION".localized(), text: version))
        items.append(SettingItem(title: "SETTING".localized(), act: .MOVE_SETTING))
        items.append(SettingItem(title: "SETTING_LICENSE".localized(), act: .MOVE_LICENSE))
        tableView.reloadData()
    }
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.infoLabel.text = item.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        switch item.act {
        case .MOVE_SETTING:
            Util.openSetting()
        case .MOVE_LICENSE:
            let vc = OpensSourceListVC()
            vc.title = "TITLE_LICENSE".localized()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

enum SettingAct {
    case MOVE_SETTING
    case MOVE_LICENSE
}

struct SettingItem {
    var title: String
    var text: String?
    var act: SettingAct?
}
