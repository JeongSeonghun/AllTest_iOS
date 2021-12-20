//
//  FrameworkTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/10/01
//  custom header comment

import Foundation
import UIKit
import AllTest_InnerFramework
import AllTest_StaticFramework

/**
 Framework 테스트
 AllTest_InnerFramework
    - dynamic framework
    - AllTest_InnerFramework.framework를 target에 추가 필요
    - AllTest 앱 빌드 시 자동으로 같이 빌드.(SubProject)
    - static에 비해 런타임 속도 빠름
    - static에 비해 메모리 덜 차지함
    - TestUniversal_fat : Fat Frameworks 생성. target - build phases - script 참고
    - TestUniversal_xc : XCFrameworks 생성. target - build phases - script 참고
    * Fat Frameworks: 여러 아키텍처를 단일 바이너리로 병합
    * XCFrameworks: xcode12 및 iOS14 출시에 따른 추가. 각 아키텍처에 서로 다른 framwwork 존제
 
 AllTest_StaticLibObc
    - AllTest_StaticLibObc.a를 target에 추가 필요
    - objective c(Obj-C)로 구현된 라이브러리이기 때문에 bridging-header 추가 필요
    - static library이기 때문에 소스코드외 리소스를 사용하기 위해서는 번들 추가 필요
    - Obj-C static library 이슈. interface builder 에서 custom view 사용 시 Unknown class error가 발생
        -> Other Linker Flags 에 -all_load 혹은 -ObjC 추가 필요(Obj-C 포함된 라이브러리 사용 시 해당 설정이 없을 경우 일부 클래스가 누락될 경우가 있음)
 
 AllTest_StaticFramework
    - static framework
    - AllTest_StaticFramework.framework를 target에 추가 필요(embaded 설정 변경 필요 -> "do not embaded"로 변경. static framework iOS15 빌드 및 스토어 업로드 시 오류 발생)
    - build setting mach-O type을 바꿔서 frmework 타입을 staic framework로 변경
    - dynamic에 비해 런타임 속도 빠름
    - dynamic에 비해 메모리 더 차지함
    - static library이기 때문에 소스코드외 리소스를 사용하기 위해서는 번들 추가 필요
 */
class FrameworkTestVC: UIViewController {
    let innerFramework = AllTestInnerFramework()
    let staticFramework = AllTestStaticFramework()
    
    override func viewDidLoad() {
        checkInnerFramework()
        checkStaticLibrary()
        checkStaticFramework()
    }
    
    func checkInnerFramework() {
        innerFramework.openFunc()
//        innerFramework.hiddenFunc() // public 미선언으로 사용 불가
    }
    
    func checkStaticLibrary() {
        TestStaticLibObc.checkFunc()
//        let testView = TestStaticLibView()
//        testView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(testView)
//        NSLayoutConstraint.activate([
//            testView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            testView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            testView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            testView.heightAnchor.constraint(equalToConstant: 120)
//        ])
    }
    
    func checkStaticFramework() {
        staticFramework.testMethod()
        
        // static framework라서 bundle xib파일 찾지 못함
//        let view = TestStaticFrameView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
    }
}
