//
//  CustomView.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

/**
 CustomViewTestVC 테스트 View
 */
@IBDesignable // 런타임이 아닌 컴파일 타임에서 실시간 확인 가능하도록 추가
class CustomView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    public typealias ClickAction = (Int) -> ()
    
    var clickAction: ClickAction?
    
    var clickCnt: Int = 0
    
    // IBInspectable 스토리보드 inspector에서 설정 가능하도록 인터페이스 지정
    @IBInspectable var text: String? {
        get {
            return textLabel?.text
        }
        set {
            textLabel?.text = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    // 뷰가 초기화된 이후 호출. 모든 outlet 및 action이 이미 연결된 상태
    // autolayout 처리는 이후에 진행
//    override class func awakeFromNib() {
    override func awakeFromNib() {
        super.awakeFromNib() // 필수
    }
    
    // 코드로 넣을 때 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    // 스토리보드에서 생성할 때 호출
    // xib view에 class 연동하면 안됨
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nib: "CustomView") else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func clickButton() {
        clickCnt += 1
        clickAction?(clickCnt)
    }
    
    func setClickAction(clickAction: @escaping ClickAction) {
        self.clickAction = clickAction
    }
}
