//
//  BackgroundTaskManager.swift
//  AllTest
//  
//  Created by jsh on 2021/12/17
//  custom header comment

import Foundation
import BackgroundTasks

// background fetch/process test
class BackgroundTaskManager {
    
    func readyBackgroundTask() {
        // Background fetch(Background mode에 backgound fetch 체크 필요)
        // 앱 사용자 패턴 파악(ex xx시에 자주 실행 등)하여 백그라운드 작업 실행
        if #available(iOS 13, *) {
            initBackgroundFramework()
        } else {
            // backgroudn fetch로 iOS13 미만에서만 동작. iOS13 이상은 BackgroundTasks Framework 사용(Background mode에 backgound fetch, backgound processing 체크 필요)
            // 실제 단말 테스트 시 xcode Debug - Simulate Background Fetch 통해 테스트 가능
            UIApplication.shared.setMinimumBackgroundFetchInterval(3)
        }
    }

    @available(iOS 13.0, *)
    func initBackgroundFramework() {
        
        // task 등록
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Const.TestBackgroundId, using: nil) { task in
            // Background Fetch - BGAppRefreshTask
            NSLog("BGAppRefreshTask test")
            if let task = task as? BGAppRefreshTask {
                self.handleAppRefresh(task: task)
            }
        }
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Const.TestBackgroundProcessId, using: nil) { task in
            // Background Processing - BGProcessingTask
            NSLog("BGProcessingTask test")
            if let task = task as? BGProcessingTask {
                self.handleBackgroundProcess(task: task)
            }
        }
    }
    
    // MARK: - Backgournd fetch
    func updateFetch(completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let queue = DispatchQueue.init(label: "TestFetch")
        queue.asyncAfter(deadline: .now() + 0.5) {
            TestManager.instance.fetchDate = Date()
            NSLog("fetch test")
            
            completionHandler(.newData)
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .testBacgkroundFetchCheck, object: nil)
            }
        }
//        completionHandler(.newData)
    }
    
    @available(iOS 13.0, *)
    func handleAppRefresh(task: BGAppRefreshTask) {
        NSLog("handleAppRefresh")
        scheduleAppRefresh() // 반복 수행을 위해
        
//        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 1
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        let taskComplete = true
        
        TestManager.instance.fetchDate = Date()
        task.setTaskCompleted(success: taskComplete)
        
    }
    
    @available(iOS 13.0, *)
    func scheduleAppRefresh() {
        // 테스트할 경우 submit 다음에 break point 걸고 아래 명령어 실행 필요(log가 보이는 터미널에 입력. 실기기에서 디버그 용도로만 사용)
        // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"Info.plist에 등록한 태스크 Identifier"]
        // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.jsh.kr.AllTest.Background.refresh"]
        
        let request = BGAppRefreshTaskRequest(identifier: Const.TestBackgroundId)
        
        // 언제 실행될지 설정(system이 판단하기 때문에 정확히 언제 동작할지는 모름)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
        
        do {
            // task submit. synchronous한 함수이기 때문에 OperationQueue, GCD등을 사용해 다른 thread에서 사용 권장
            try BGTaskScheduler.shared.submit(request)
            NSLog("scheduleAppRefresh submit")
        } catch {
            print(error)
        }
    }
    
    // MARK: - Background process
    @available(iOS 13.0, *)
    func handleBackgroundProcess(task: BGProcessingTask) {
        NSLog("handleBackgroundProcess")
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        let taskComplete = true
        
        TestManager.instance.processDate = Date()
        task.setTaskCompleted(success: taskComplete)
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .testBacgkroundProcessCheck, object: nil)
        }
    }
    
    @available(iOS 13.0, *)
    func schduleBackProcess() {
        let request = BGProcessingTaskRequest(identifier: Const.TestBackgroundProcessId)
        
        request.requiresNetworkConnectivity = true // 네트워크 사용 여부
        request.requiresExternalPower = true // 에너지 소모량
        do {
            try BGTaskScheduler.shared.submit(request)
            
            // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.jsh.kr.AllTest.Background.process"]
            NSLog("schduleBackProcess submit")
        } catch {
            print(error)
        }
    }
}
