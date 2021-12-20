//
//  ProgressTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/28
//  custom header comment

import Foundation
import UIKit

/**
 Progress Bar 테스트
 */
class ProgressTestVC: UIViewController {
    @IBOutlet weak var progress: UIProgressView!
    
    override func viewDidLoad() {
        initProgress()
    }
    
    func initProgress() {
        progress.progressTintColor = .black
        progress.trackTintColor = .cyan
//        progress.progressImage = UIImage(named: "")
//        progress.trackImage = UIImage(named: "")
        
//        progress.progressViewStyle = .default
        progress.progressViewStyle = .bar
        
//        progress.transform = progress.transform.scaledBy(x: 1, y: 8)
        
        progress.progress = 0.3
        progress.setProgress(0.8, animated: true) // 애니메이션 적용
    }
}
