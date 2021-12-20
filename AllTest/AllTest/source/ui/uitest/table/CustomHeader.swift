//
//  CustomHeader.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit

/**
 TableHeaderTestVC custom header
 */
class CustomHeader: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomHeader", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView  else {
            return
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
