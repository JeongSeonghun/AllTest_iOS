//
//  ReandomUtil.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation

class RandomUtil {
    /// 랜덤 문자
    static func getRandomString(size: Int) -> String {
        let rndChars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
        let rndStr = String((0..<size).map{ _ in rndChars[Int(arc4random_uniform(UInt32(rndChars.count)))]})
        return rndStr
    }
    
    /// 랜럼 숫자
    static func getRandomNum(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}
