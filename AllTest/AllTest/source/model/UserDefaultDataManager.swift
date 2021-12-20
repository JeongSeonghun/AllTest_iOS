//
//  UserDefaultDataModel.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation

class UserDefaultDataManager {
    private let KEY_NAME = "alltest.key.name"
    static let instance: UserDefaultDataManager = UserDefaultDataManager()
    
    func saveName(name: String) {
        UserDefaults.standard.set(name, forKey: KEY_NAME)
    }
    
    func getName() -> String? {
        return UserDefaults.standard.string(forKey: KEY_NAME)
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: KEY_NAME)
    }
}
