//
//  TextTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 UILabel 텍스트 표기 테스트
 강조, 밑줄 추가
 */
class TextTestVC: UIViewController {
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    
    override func viewDidLoad() {
        let text = "중간강조표시"
        let aa1 = NSMutableAttributedString(string:  text)
        let range1 = (text as NSString).range(of: "강조")
        aa1.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 19), range: range1)
        aa1.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 39/255, green: 136/255, blue: 243/255, alpha: 1), range: range1)
        textLabel1.attributedText = aa1
        
        let text2 =  "중간밑줄표시"
        let aa2 = NSMutableAttributedString(string:  text2)
        //언더 라인
        let underLine = NSUnderlineStyle.thick.rawValue
        let range2 = (text2 as NSString).range(of: "밑줄")
        //색과 언더 라인을 추가
        aa2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 39/255, green: 136/255, blue: 243/255, alpha: 1), range: range2)
        aa2.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: underLine, range: range2)
        textLabel2.attributedText = aa2
        
        
    }
}
