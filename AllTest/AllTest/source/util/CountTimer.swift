//
//  CoutTimer.swift
//  AllTest
//  
//  Created by jsh on 2021/09/06
//  custom header comment

import Foundation

/**
 Count Timer
 */
class CountTimer {
    private var timer: Timer?
    private var isUpMode = false
    private var startTime: Date?
    private var maxSec: Int?
    private var cnt: Int = 0
    
    /**
     1초씩 증가 시작
     - parameters:
        - maxSec: 종료 시간(초). -1인 경우 stop() 호출 필요(무제한)
        - handler: 경과 시간(초) 전달
        - sec: 경과 시간(초)
     */
    func startUp(maxSec: Int = -1, handler: @escaping (_ sec: Int) -> Void) {
        isUpMode = true
        startTime = Date()
        cnt = 0
        if !(timer?.isValid ?? false) {
            timer = Timer(timeInterval: 0.25, repeats: true, block: { timer in
                guard let start = self.startTime else { return }
                let calendar = Calendar.current
                let current = Date()
                let comp = calendar.dateComponents([.second], from: start, to: current)
                let sec = comp.second ?? 0
                if sec > self.cnt {
                    self.cnt = sec
                    
                    if sec >= maxSec {
                        self.stop()
                        self.cnt = maxSec
                    }
                    NSLog("count up cnt: \(self.cnt)")
                    handler(self.cnt)
                }
            })
            NSLog("count up start")
            RunLoop.current.add(timer!, forMode: .common)
            handler(cnt)
        }
        
    }
    
    /// 1초씩 감소 시작
    /// - Parameters:
    ///   - startSec: 시작 시간(초)
    ///   - handler: 남은 시간(초) 전달
    ///   - sec: 시간(초)
    func startDown(startSec: Int, handler: @escaping (_ sec: Int) -> Void) {
        isUpMode = false
        startTime = Date()
        cnt = startSec
        if !(timer?.isValid ?? false) {
            timer = Timer(timeInterval: 0.25, repeats: true, block: { timer in
                guard let start = self.startTime else { return }
                let calendar = Calendar.current
                let comp = calendar.dateComponents([.second], from: start, to: Date())
                let sec = comp.second ?? 0
                var remain = startSec - sec
                if remain < self.cnt {
                    if remain <= 0 {
                        self.stop()
                        remain = 0
                    }
                    self.cnt = remain
                    handler(self.cnt)
                    NSLog("count down cnt: \(self.cnt)")
                }
                
            })
            NSLog("count down start")
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    /// 타이머 종료
    func stop() {
        guard let timer = timer else {
            return
        }
        NSLog("count stop")
        timer.invalidate()
    }
    
    /// 타이머 진행중 상태
    func isCounting() -> Bool {
        return timer?.isValid == false
    }
    
}
