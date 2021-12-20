//
//  TestModel.swift
//  AllTest
//  
//  Created by jsh on 2021/08/26
//  custom header comment

import Foundation

// MARK: - TestModel
/**
 테스트용 공통 모듈
 퀵핼프용 주석 내용을 표함
 [퀵헬프주석참고](https://charmintern.tistory.com/41)
 */
class TestModel {
    /// 로딩 중 상태. 네트워크 통신 대신에 사용
    private var loading: Bool = false
    
    /// 로딩 중 상태
    /// - returns: true일 경우 로딩 중
    func isLoading() -> Bool {
        return loading
    }
    
    /**
     테스트 목록 데이터
     - parameters:
        - cnt: 목록갯수
     - returns: 데이터 목록
     */
    func getTestList(cnt: Int = 10) -> Array<TestData> {
        var list = Array<TestData>()
        for n in 1 ... cnt {
            var desc = "testDesc"
            for num in 1 ... n {
                desc.append("testDesc\(num)")
            }
            let data = TestData(title: "TestTitle\(n)", desc: desc, id: n - 1)
            list.append(data)
        }
        
        return list
    }
    
    /// getTestListDelay handler인 closure를 별도 타입 명칭으로 정의
    typealias TestListDelayHandler = (Array<TestData>) -> Void
    /// 비동기적으로 데이터를 받기위한 함수
    func getTestListDelay(cnt: Int = 10, delayMilli: Int, handler: @escaping TestListDelayHandler) {
        loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delayMilli)) {
            self.loading = false
            handler(self.getTestList(cnt: cnt))
        }
    }
    
    // MARK: - 페이징 테스트
    /// 페이징 테스트 전체 아이템 갯수
    private var totalCnt: Int = 50
    /// 페이징 테스트 로딩 용 응답 지연 시간
    private var delayMili: Int = 500
    
    /**
     페이징 처리 테스트시 초기값 수정할 경우 사용
     1. 기본 tottalCnt = 50
     3. 기본 응답 지연 시간(delayMiliSec) 0.5초
     - parameters:
        - totalCnt: 전체 갯수
        - delayMiliSec: 로딩 중 테스트 시간. 밀리초 단위
     */
    func setPagingTestInfo(totalCnt: Int, delayMiliSec: Int = 500) {
        self.totalCnt = totalCnt
        self.delayMili = delayMiliSec
    }
    
    /**
     페이징 처리 테스트시 해당 페이지 목록 데이터
     
     사용법 예시
     ````
     testModel.getPagingData(page: 1, cnt: 10) { res in
        // 응답 처리
     }
     ````
     - parameters:
        - page: 얻어올 페이지
        - cnt: 페이지당 갯수
        - handler: 페이지 데이터 응답 수신
        - res: 목록 요청 결과
     */
    func getPagingData(page: Int, cnt: Int, handler: @escaping (_ res: PagingTestRes) -> Void) {
        self.loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + (0.01 * Double(delayMili))) {
            self.loading = false
            
            let pageData = PagingData(currentPage: page, totoalCnt: self.totalCnt)
            let quotient = self.totalCnt / cnt
            let remainder = self.totalCnt % cnt
            let maxPage = remainder > 0 ? quotient + 1 : quotient
            var list = Array<TestData>()
            if page > 0 && page <= maxPage {
                let start = (page - 1) * cnt
                for i in start ..< start + cnt {
                    if i >= self.totalCnt { break }
                    list.append(TestData(title: "title\(i)", desc: "desc\(i)"))
                }
            }
            let res = PagingTestRes(list: list, page: pageData)
            
            handler(res)
        }
    }
}
