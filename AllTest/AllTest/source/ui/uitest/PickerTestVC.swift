//
//  PickerTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/14
//  custom header comment

import Foundation
import UIKit

/**
 Picker 테스트
 UIDatePicker, UIPickerView
 */
class PickerTestVC: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerLabel: UILabel!
    
    override func viewDidLoad() {
        // DatePicker 선택 유형 설정. 날짜 및 시간, 날짜, 시간
//        datePicker.datePickerMode = .time
        
        // DatePicker 선택 분 단위
        datePicker.minuteInterval = 10
        
        // 표시 스타일 설정. os 13이상 부터 가능
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let date = sender.date
        let form = DateFormatter()
        form.dateFormat = "yyyy.MM.dd HH:mm"
        datePickerLabel.text = form.string(from: date)
    }
}

extension PickerTestVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerViewDataSource
    // 열 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // 행 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    // 표시 텍스트
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(row)
        case 1:
            return String(row * 2)
        default:
            return ""
        }
    }
    // 텍스트가 아닌 custom view로 표시할 때 사용
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//
//    }
    
    // 선택 위치 정보
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLabel.text = "select \(component) - \(row)"
    }
    
}
