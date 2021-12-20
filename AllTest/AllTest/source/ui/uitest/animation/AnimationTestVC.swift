//
//  AnimationTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/15
//  custom header comment

import Foundation
import UIKit

class AnimationTestVC: UIViewController {
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    
    var originFrame: CGRect!
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if originFrame == nil {
            originFrame = testView.frame
        }
    }
    
    @IBAction func reset() {
        testView.layer.removeAllAnimations()
        testView.frame = originFrame
        testView.alpha = 1.0
        heightConst.constant = 140
    }
    
    // MARK: - UIView.animate
    @IBAction func clickAnimationWidth() {
        // withDuration: 애니메이션 동작 시간
        UIView.animate(withDuration: 1.0) {
            self.testView.frame.size.width = 100
        }
    }
    
    @IBAction func clickAnimationHeight() {
//        let origin = testView.frame
        
        heightConst.constant = 100
        testView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 1.0) {
//            self.testView.frame.size.height = 100
            self.testView.layoutIfNeeded()
        } completion: { isComplete in
            // 애니메이션 종료
            NSLog("animation stop")
//            self.heightConst.constant = 140
//            self.testView.frame = origin
        }

    }
    
    @IBAction func clickAnimationStop() {
        // 애니메이션 제거
        testView.layer.removeAllAnimations()
    }
    
    @IBAction func clickAnimationSpring() {
        let origin = testView.frame
        // usingSpringWithDamping: 애니메이션 정지 비율. 0 ~ 1.0
        // initialSpringVelocity: 스프링 속도. 0 ~ 1.0
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseIn) {
            self.testView.frame.size = CGSize(width: 100, height: 100)
        } completion: { isComplete in
            NSLog("spring animation stop")
            self.testView.frame = origin
        }
    }
    
    @IBAction func clickAnimaionOption() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse]) {
            self.testView.frame.size = CGSize(width: 100, height: 100)
            self.testView.alpha = 0.5
        } completion: { isComplete in
            NSLog("option animation stop")
        }

    }
    
    @IBAction func clickAnimationKeyFrame() {
        UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.animation1()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.animation2()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.animation3()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.animation4()
            }
        } completion: { isComplete in
            NSLog("KeyFrame animation stop")
        }

    }
    
    func animation1() { self.testView.frame.size.width = 100 }
    func animation2() { self.testView.frame.size.height = 100 }
    func animation3() { self.testView.frame.origin.x += 50 }
    func animation4() { self.testView.alpha = 0.5 }
}
