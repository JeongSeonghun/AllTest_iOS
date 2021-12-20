//
//  CodableData.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation

/**
 Codable 테스트용 데이터
 변환할 데이터 키명칭과 변수 명칭 불일치
 */
struct CodableTestData: Codable {
    var a: Int
    var b: Int
    var d: Int?
    
    /// 디코딩 시 데이터와 다른 명칭으로 변수에 저장할시 키 명칭을 정의해 사용
    enum CodingKeys: String, CodingKey {
        case a = "a"
        case b = "c"
        case d = "d"
    }
    
    // 디코딩 커스텀 처리(키명칭 및 데이터 타입)
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = (try? values.decode(Int.self, forKey: .a)) ?? 0
        // 키명칭 과 변수 명칭 상이한 경우
        b = (try? values.decode(Int.self, forKey: .b)) ?? 0
        // 타입이 상이한 경우
        d = try? values.decode(Int.self, forKey: .d)
        if d == nil {
            let str = try? values.decode(String.self, forKey: .d)
            d = Int(str ?? "")
        }
    }
}

/**
 Codable 테스트용 데이터
 주의!! 타입이 다를 경우 exception 발생
 */
struct CodableData: Codable {
    var a: Int
    var b: Int?
    var c: Int?
    var d: Int?
}
