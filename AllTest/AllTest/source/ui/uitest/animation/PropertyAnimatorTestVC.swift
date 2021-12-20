//
//  PropertyAnimatorTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/15
//  custom header comment

import Foundation
import UIKit

class PropertyAnimatorTestVC: UIViewController {
    @IBOutlet weak var testView: UIView!
    
    var animator: UIViewPropertyAnimator?
    
    var originFrame: CGRect!
    
    override func viewDidAppear(_ animated: Bool) {
        if originFrame == nil {
            originFrame = testView.frame
        }
    }
    
    @IBAction func reset() {
        testView.layer.removeAllAnimations()
        testView.frame = originFrame
        testView.alpha = 1.0
    }
    
    @IBAction func clickStart() {
        if animator != nil {
            animator?.startAnimation()
        }
        
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2.0, delay: 0, options: [], animations: {
            self.animation()
        }, completion: { position in
            NSLog("complete \(position)")
        })
        
//        animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: {
//            self.animation()
//        })
//        animator?.addCompletion({ position in
//            NSLog("complete \(position)")
//        })
//        animator?.startAnimation()
//        animator?.startAnimation(afterDelay: 0)
        
        // stop 상태에서 호출하면 오류 발생
        // start or inactive 에서 호출
        animator?.addAnimations {
            self.testView.alpha = 0.5
        }
    }
    @IBAction func clickPause() {
        animator?.pauseAnimation()
    }
    @IBAction func clickStop() {
//        animator?.stopAnimation(true)
        
        animator?.stopAnimation(false)
        animator?.finishAnimation(at: .current)
    }
    
    @IBAction func changeValue(_ sender: UISlider) {
        animator?.fractionComplete = CGFloat(sender.value)
    }
    
    func animation() {
        testView.frame.size.width = 100
    }
    
}
