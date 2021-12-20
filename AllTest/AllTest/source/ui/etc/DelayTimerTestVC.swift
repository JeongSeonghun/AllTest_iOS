//
//  DelayTimerTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/02
//  custom header comment

import Foundation
import UIKit

/**
 delay 및 timer 테스트
 */
class DelayTimerTestVC: UIViewController {
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var delayField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerField: UITextField!
    @IBOutlet weak var timerRepeatSwitch: UISwitch!
    
    var timer: Timer?
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countLimitField: UITextField!
    @IBOutlet weak var countModeSwitch: UISwitch!
    
    var countTimer = CountTimer()
    
    // MARK: - Delay Test
    @IBAction func clickDelayStart() {
        let form = DateFormatter()
        form.dateFormat = "HH:mm:ss.SSS"
        var text = form.string(from: Date())
        delayLabel.text = text
        
        guard let numTxt = delayField.text, !numTxt.isEmpty, let num = Int(numTxt) else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                text.append(",check: \(form.string(from: Date()))")
                self.delayLabel.text = text
            }
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(num)) {
            text.append(",check: \(form.string(from: Date()))")
            self.delayLabel.text = text
        }
    }
    
    // MARK: - Timer Test
    var startTime: Date?
    @IBAction func clickTimerStart() {
        if timer == nil || !(timer?.isValid ?? false) {
            
            let timerBlock: ((Timer) -> Void) = { timer in
                guard let start = self.startTime else { return }
                let form = DateFormatter()
                form.dateFormat = "HH:mm:ss.SSS"
                
                self.timerLabel.text = "start : \(form.string(from: start)) check : \(form.string(from: Date()))"
            }
            
            let isRepaet = timerRepeatSwitch.isOn
            startTime = Date()
            
            timerLabel.text = ""
            if let secStr = timerField.text, let sec = Double(secStr) {
                timer = Timer.scheduledTimer(withTimeInterval: sec, repeats: isRepaet, block: timerBlock)
            } else {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: isRepaet, block: timerBlock)
            }
        }
    }
    @IBAction func clickTimerStop() {
        guard let timer = self.timer else {
            return
        }
        timer.invalidate()
        timerLabel.text = ""
    }
    
    // MARK: - count timer
    @IBAction func clickCountStart() {
        guard let count = Int(countLimitField.text ?? "") else {
            return
        }
        
        if countModeSwitch.isOn {
            countTimer.startUp(maxSec: count) { sec in
                self.countLabel.text = String(sec)
            }
        } else {
            countTimer.startDown(startSec: count) { sec in
                self.countLabel.text = String(sec)
            }
        }
        
    }
    
    @IBAction func clcikCountStop() {
        countTimer.stop()
    }

}
