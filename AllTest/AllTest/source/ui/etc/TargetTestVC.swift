//
//  TargetTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/10/29
//  custom header comment

import Foundation
import UIKit

/**
 Target Test(동일 명칭으로 클래스 및 storyboard 따로 사용)
 파일 생성 및 우측 file inspector에서 target을 설정하여
 파일 및 리소스를 동일하게 1개로 사용하겨나 별도로 여러개 사용가능(파일 및 클래스명 동일하게 Target별로 분리해서 사용가능)
 cocoapods 사용시 podfile 설정 수정 후 install 재실행 필요
 * 타겟이 2이상일 경우 파일 생성 시 기본적으로 하나만 선택되어있으므로 상황에 맞춰 체크할 필요있음
 * 타겟 생성 시 bridging-header 및 라이브러리, bundle이 설정되어있지 않으므로 사용할 경우 주의
 */
class TargetTestVC: UIViewController {
    @IBOutlet weak var target1Label: UILabel!
    
    override func viewDidLoad() {
        target1Label.text = Util.getOSVersion()
    }
}
