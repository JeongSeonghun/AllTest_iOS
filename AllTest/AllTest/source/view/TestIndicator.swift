//
//  TestIndicator.swift
//  AllTest
//  
//  Created by jsh on 2021/09/28
//  custom header comment

import Foundation
import UIKit

class TestIndicator {
    static func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            let indicator: UIActivityIndicatorView
            if let view = window.subviews.first(where: {$0 is UIActivityIndicatorView}) as? UIActivityIndicatorView {
                indicator = view
            } else {
                if #available(iOS 13.0, *) {
                    indicator = UIActivityIndicatorView(style: .large)
                } else {
                    indicator = UIActivityIndicatorView(style: .whiteLarge)
                }
                indicator.frame = window.frame
                indicator.color = .green
                window.addSubview(indicator)
            }
            
            indicator.startAnimating()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter { $0 is UIActivityIndicatorView }.forEach { $0.removeFromSuperview() }
        }
    }
}
