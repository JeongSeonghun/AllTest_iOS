//
//  AppInfoVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/13
//  custom header comment

import Foundation
import UIKit

/**
 app, build, plist, config 정보 확인
 */
class AppInfoVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataList = [String]()
    
    override func viewDidLoad() {
        makeItems()
    }
    
    func makeItems() {
        // app info
        var appText = "app info"
        appText.append("\nVersion: \(Util.currentAppVersion() ?? "")")
        appText.append("\nBuild Version: \(Util.currentAppBuildVersion() ?? "")")
        appText.append("\nOS Version: \(Util.getOSVersion())")
        
        // plist, config
        var plistText = "plist data"
        plistText.append("\nTestPilistValue: \(Bundle.main.infoDictionary?["TestPilistValue"] as? String ?? "")")
        // project - info - configurations에서 생성한 config(xcconfig) 파일 명을 선택해야 적용됨.
        // Configuration 파일 내용은 plist, target에서 사용 가능
        plistText.append("\nTestConfigValue: \(Bundle.main.infoDictionary?["TestConfigValue"] as? String ?? "")")
        plistText.append("\nDEBUG_TEST_CONFIG: \(Bundle.main.infoDictionary?["TestDebugConfigValue"] as? String ?? "")") // release에서는 안나오도록 debug config 파일에만 추가
        plistText.append("\nRELEASE_TEST_CONFIG: \(Bundle.main.infoDictionary?["TestReleaseConfigValue"] as? String ?? "")") // debug에서는 안나오도록 release config 파일에만 추가
        
        dataList.append(appText)
        dataList.append(plistText)
    }
}

extension AppInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
    
}
