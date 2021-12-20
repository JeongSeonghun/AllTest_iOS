//
//  TargetTestView.swift
//  AllTest
//  
//  Created by jsh on 2021/10/29
//  custom header comment

import Foundation
import UIKit

/**
 Target Test
 클리스 동일하게 사용하고 xib만 따로 사용
 */
@IBDesignable
class TargetTestView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib(nib: "TargetTestView") else {
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
}
