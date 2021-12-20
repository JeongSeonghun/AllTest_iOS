//
//  NumTest.swift
//  AllTest
//  
//  Created by jsh on 2021/09/15
//  custom header comment

import Foundation
import XCTest
// clean build 시 해당 앱 build 전까지는 오류 발생
@testable import AllTest

/**
 값 및 시간 체크
 class 및 함수명 좌측 아이콘 클릭으로 테스트 가능
 class로 테스트 진행 시 class내 모든 테스트 캐이스 실행
 함수 테스트 진행 시 해당 테스트 케이스만 실행
 */
class NumTest: XCTestCase {

    // 초기화 코드를 작성. 테스트 코드가 실행되기 전 호출
    override func setUpWithError() throws {
        
    }
    
    // 해제 코드를 작성. 테스트 코드가 실행된 후 호출
    override func tearDownWithError() throws {
        
    }
    
    // MARK: - 테스트 케이스
    // 테스트 케이스 작성. 메서드 명은 자유
    func testExample() throws {
        // XCTAssertEqual, XCTAssertTrue, XCTAssertFalse, XCTAssertThrowsError 등 원하는 확인 방식 함수 실행
        // 값 확인
        XCTAssertEqual(average(numList: [1,2,3,4,5]), 3)
    }
    // 실패 확인
//    func testFailExample() throws {
//        XCTAssertEqual(average(numList: [1,2,3,4,5]), 2)
//    }
    // 성능 확인
    func testPerformanceExample() throws {
        // measure 성능 테스트 시 사용(시간을 측정)
        measure {
            var numList = [Int]()
            for num in 1 ... 200 {
                numList.append(num)
            }
            _ = average(numList: numList)
        }
    }
    
    func average(numList: [Int]) -> Int {
        guard numList.count > 0 else {
            return 0
        }
        var total = 0
        for num in numList {
            total += num
        }
        return total / numList.count
    }
}
