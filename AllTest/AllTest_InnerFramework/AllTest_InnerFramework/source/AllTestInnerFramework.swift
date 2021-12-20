//
//  AllTestInnerFramework.swift
//  AllTest_InnerFramework
//  
//  Created by jsh on 2021/10/01
//  custom header comment

import Foundation

// public 미선언 시 외부에서 사용 불가
/**
 Framework 테스트. SubProject
    - AllTest_InnerFramework.framework를 target에 추가 필요
    - TestUniversal_fat : Fat Frameworks 생성. target - build phases - script 참고
    - TestUniversal_xc : XCFrameworks 생성. target - build phases - script 참고
    * Fat Frameworks: 여러 아키텍처를 단일 바이너리로 병합
    * XCFrameworks: xcode12 및 iOS14 출시에 따른 추가. 각 아키텍처에 서로 다른 framwwork 존제
 */
public class AllTestInnerFramework {
    
    // public 미선언 시 외부에서 사용 불가
    public init() {
        
    }

    // public 미선언 시 외부에서 사용 불가
    func hiddenFunc() {
        NSLog("AllTestInnerFramework hidden func")
    }
    
    public func openFunc() {
        NSLog("AllTestInnerFramework open func")
    }
}
