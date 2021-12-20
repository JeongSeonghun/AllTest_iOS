//
//  TestContact.swift
//  AllTest
//  
//  Created by jsh on 2021/11/17
//  custom header comment

import Foundation

/**
 Test용 데이터
 QuickActionManager에 Quick Action을 위한 extenstion 정의됨
 */
struct TestContact: Hashable {
    var name: String
    var email: String
    var phone: String?
    var isFavorite: Bool
    var identifier: String = UUID().uuidString
}
