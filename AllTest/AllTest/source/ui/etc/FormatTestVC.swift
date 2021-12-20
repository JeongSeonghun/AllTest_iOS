//
//  FormatTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import UIKit

/**
 포맷 테스트
 NumberFormatter, DateFormatter, string 포맷
 */
class FormatTestVC: UIViewController {
    @IBOutlet weak var numFormLabel: UILabel!
    @IBOutlet weak var txtFormLabel: UILabel!
    @IBOutlet weak var dateFormLabel: UILabel!
    
    override func viewDidLoad() {
        initNumForm()
        initStringFormat()
        initDateFormat()
    }
    
    func initNumForm() {
        var text = ""
        let doubleValue: Double = 31245.75689
        
        // decimal 확인
        let form = NumberFormatter()
        form.numberStyle = .decimal
        let value = Int(round(doubleValue * 100)) / 100
        let result = form.string(from: NSNumber(value: value)) ?? ""
        text.append(String(format: "%@%@", result, "temp"))
        
        // 반올림 확인
        text.append("\n\n")
        let value2:Double = round(doubleValue * 100) / 100
        let form2 = NumberFormatter()
        form2.numberStyle = .decimal
        let result2 = form2.string(for: value2) ?? ""
        text.append(String(format: "\n%@%@", result2, "abc"))
        
        let form3 = NumberFormatter()
        form3.numberStyle = .decimal
        form3.roundingMode = .up
        let result3 = form3.string(from: NSNumber(value: doubleValue)) ?? ""
        text.append("\n\(result3)")
        let result4 = form3.string(for: doubleValue) ?? ""
        text.append("\n\(result4)")
        
        // maximumSignificantDigits 확인
        text.append("\n\n")
        let form4 = NumberFormatter()
        form4.numberStyle = .decimal
        form4.maximumSignificantDigits = 3
        let result5 = form4.string(for: value2) ?? ""
        text.append("\n\(result5)")
        let result6 = form4.string(for: 3.125) ?? ""
        text.append("\n\(result6)")
        
        numFormLabel.text = text
    }
    
    func initStringFormat() {
        var text = ""
        let doubleValue: Double = 31245.75689
        
        // 문구 "Text : %@"
        text.append(String(format: "FORM_TEXT".localized(), "Test"))
        // 정수
        text.append("\n") // "Num : %d"
        text.append(String(format: "FORM_NUM".localized(), 10))
        // 소수
        text.append("\n") // "Double : %f"
        text.append(String(format: "FORM_DOUBLE".localized(), doubleValue))
        text.append("\n") // "Double : %.1f"
        text.append(String(format: "FORM_DOUBLE_CNT".localized(), doubleValue))
        
        txtFormLabel.text = text
    }
    
    func initDateFormat() {
        var text = ""
        
        let today = Date()
        let form1 = DateFormatter() // yyyy.MM.dd HH:mm:ss:SSS
        form1.dateFormat = "FORM_DATE24".localized()
        text.append(form1.string(from: today))
        
        // iPhone 설정 - 날짜 및 시간에서 24시간제로 설정할 경우 a 동작하지 않음
        let form2 = DateFormatter() // yyyy.MM.dd a hh:mm:ss:SSS
        form2.dateFormat = "FORM_DATE".localized()
        text.append("\n")
        text.append(form2.string(from: today))
        
        let form3 = DateFormatter() // yyyy.MM.dd a hh:mm:ss:SSS
        form3.dateFormat = "FORM_DATE".localized()
        form3.locale = Locale(identifier: "ko") // 표시 언어
        form3.timeZone = TimeZone(abbreviation: "KST") // 시간대
        text.append("\n")
        text.append(form3.string(from: today))
        
        let form4 = DateFormatter() // yyyy.MM.dd a hh:mm:ss:SSS
        form4.dateFormat = "FORM_DATE".localized()
        form4.locale = Locale(identifier: "en")
        form4.timeZone = TimeZone(abbreviation: "UTC")
        text.append("\n")
        text.append(form4.string(from: today))
        
        let form5 = DateFormatter() // yyyy.MM.dd a hh:mm:ss:SSS
        form5.dateFormat = "FORM_DATE".localized()
        form5.locale = Locale(identifier: "ja")
        form4.timeZone = TimeZone.current // local
        text.append("\n")
        text.append(form5.string(from: today))
        
        let form6 = DateFormatter() // yyyy.MM.dd a hh:mm:ss:SSS
        form6.dateFormat = "FORM_DATE".localized()
        form6.locale = Locale(identifier: "zh-CN")
        text.append("\n")
        text.append(form6.string(from: today))
        
        dateFormLabel.text = text
    }
}
