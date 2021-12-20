//
//  LottieTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/10
//  custom header comment

import Foundation
import UIKit
import Lottie

/**
 Lottie 애니메이션 library 테스트
 Lottie cocoapods 추가 필요
 pod 'lottie-ios'
 주의!! 애니메이션 json 파일 내용이 많을 경우, xcode에서 열면 일정시간 버벅이거나 멈출 수 있음.
 */
class LottieTestVC: UIViewController {
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var modeTable: UITableView!
    
    override func viewDidLoad() {
        initLottie()
    }
    
    func initLottie() {
        animationView.animation = Animation.named("ani_paint_globe")
    }
    
    @IBAction func clickStart() {
        switch modeTable.indexPathForSelectedRow?.row {
        case 0:
            animationView.loopMode = .playOnce
        case 1:
            animationView.loopMode = .loop
        case 2:
            animationView.loopMode = .autoReverse
        default:
            break
        }
        
        animationView.play { isComplete in
            NSLog("animation complete : \(isComplete)")
        }
    }
    
    @IBAction func clickStop() {
        animationView.stop()
    }
    
    @IBAction func clickPause() {
        animationView.pause()
    }
}

extension LottieTestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "playOnce"
            break
        case 1:
            cell.textLabel?.text = "loop"
            break
        case 2:
            cell.textLabel?.text = "autoReverse"
            break
        default:
            break
        }
        
        return cell
    }
    
}
