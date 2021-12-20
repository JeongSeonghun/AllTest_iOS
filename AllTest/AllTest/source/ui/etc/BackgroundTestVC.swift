//
//  BackgroundTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/12/02
//  custom header comment

import Foundation
import UIKit

/**
 setMinimumFetchInterval 테스트 시 아래 항목 추가 필요(iOS 13 미만에서 동작)
 - project target background mode에서 Background Fetch 체크
 
 Background Task 테스트 시 아래 항목 추가 필요
 - info.plist에 BGTaskSchedulerPermittedIdentifiers 추가
 - project target background mode에서 Background Fetch(BGAppRefreshTask), Background Processing(BGProcessingTask) 체크
 */
class BackgroundTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataList = [String]()
    
    let backTestManager = BackgroundTaskManager()
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(notiAction(_:)), name: .testBacgkroundFetchCheck, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notiAction(_:)), name: .testBacgkroundProcessCheck, object: nil)
        
        initData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .testBacgkroundFetchCheck, object: nil)
        NotificationCenter.default.removeObserver(self, name: .testBacgkroundProcessCheck, object: nil)
    }
    
    @IBAction func notiAction(_ notification: NSNotification) {
        initData()
    }
    
    func initData() {
        var fetchData = "fetch: unknown"
        var processData = "process: unknown"
        let dateForm = DateFormatter()
        dateForm.dateFormat = "HH:mm:ss.SSS"
        
        if let date = TestManager.instance.fetchDate {
            fetchData = "fetch: \(dateForm.string(from: date))"
        }
        if let date = TestManager.instance.processDate {
            processData = "process: \(dateForm.string(from: date))"
        }
        
        if dataList.isEmpty {
            dataList.append(fetchData)
            dataList.append(processData)
        } else {
            dataList[0] = fetchData
            dataList[1] = processData
        }
        
        NSLog("check fetch \(fetchData) \n process \(processData)")
        tableView.reloadData()
    }
    
    @IBAction func clickTestBackProcess() {
        if #available(iOS 13.0, *) {
            backTestManager.schduleBackProcess()
        }
    }
}

extension BackgroundTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataStr = dataList[indexPath.row]
        cell.textLabel?.text = dataStr
        
        return cell
    }
}
