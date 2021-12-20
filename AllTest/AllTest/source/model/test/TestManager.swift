//
//  TestManager.swift
//  AllTest
//  
//  Created by jsh on 2021/11/17
//  custom header comment

import Foundation

class TestManager {
    static let instance = TestManager()
    
    var quickAction: String?
    
    var fetchDate: Date?
    var processDate: Date?
    
    private init() {
        
    }
}
