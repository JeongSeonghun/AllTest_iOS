//
//  KeyChangeDataManager.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation

class KeyChainDataManager {
    private let account = "tokenService"
    private let service = Bundle.main.bundleIdentifier
    
    static let instance = KeyChainDataManager()
    
    func createToken(token: String) -> Bool {
        guard let service = service else {
            return false
        }
        
        let query: [CFString: Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecAttrGeneric : token
        ]
        
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    func readToken() -> String? {
        guard let service = service else {
            return nil
        }
        
        let query: [CFString: Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecMatchLimit : kSecMatchLimitOne,
            kSecReturnAttributes : true,
            kSecReturnData : true
        ]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecAttrGeneric as String] as? String else {
            return nil
        }
        
        return data
    }
    
    func updateToken(token: String) -> Bool {
        guard let service = service else {
            return false
        }
        
        let query: [CFString: Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account
        ]
        
        let attributes: [CFString: Any] = [
            kSecAttrAccount : account,
            kSecAttrGeneric : token
        ]
        
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    func deleteToken() -> Bool {
        guard let service = service else {
            return false
        }
        
        let query: [CFString: Any] = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account
        ]
        
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}
