//
//  TestStaticFrameView.swift
//  AllTest_StaticFramework
//  
//  Created by jsh on 2021/10/15
//  custom header comment

import Foundation
import UIKit

public class TestStaticFrameView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    func xibSetup() {
        guard let view = loadViewFromNib(nib: "TestStaticFrameView") else {
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
