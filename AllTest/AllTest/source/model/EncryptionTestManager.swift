//
//  EncryptionTestManager.swift
//  AllTest
//  
//  Created by jsh on 2021/11/23
//  custom header comment

import Foundation
import CryptoSwift

/**
 암호화, 인코딩, 디코딩 Test
 cocoapods 추가 필요
 pod 'CryptoSwift'
 */
class EncryptionTestManager {
    /// AES 키값 (AES256: 32 bytes, AES192: 24 bytes, AES128: 16 bytes)
    private let SECRET_KEY_AES = "01234567890123456789012345678912"
    /// AES IV (Initialize Vector)
    private let IV_AES = "0123456789012345"
    
    // MARK: - CryptoSwift
    /**
     SHA256
     Hash 함수(정해진 길이의 데이터 반환)
     SHA(Secure Hash Algorithm) 알고리즘
     단방향 암호화(복호화 거의 불가능)
     */
    func sha256(str: String) -> String {
        return str.sha256()
    }
    
    /**
     AES256 암호화
     AES(Advanced Encryption Standard)
     대칭키 알고리즘(암호화 복호화에 동일 키 사용)
     Secret key
     IV (Initialize Vector)
     Cipher Mode (CBC/ECB/...)
     Padding Mode (PKCS5/PCKS7/...)
     */
    func encryptAES(str: String) -> String {
        guard let aes256 = getAES(), let data = str.data(using: .utf8) else { return "" }
        
        do {
            let encryptData = try aes256.encrypt(data.bytes)
            return encryptData.toBase64() ?? ""
        } catch {
            NSLog(error.localizedDescription)
        }
        return ""
    }
    
    /**
     AES256 복호화
     */
    func decryptAES(str: String) -> String {
        guard let aes256 = getAES(), let data = Data(base64Encoded: str) else { return "" }
        do {
            let decryptData = try aes256.decrypt(data.bytes)
            return String(bytes: decryptData, encoding: .utf8) ?? ""
        } catch {
            NSLog(error.localizedDescription)
        }
        return ""
    }
    
    private func getAES() -> AES? {
        return try? AES(key: SECRET_KEY_AES, iv: IV_AES)
    }
    
    // MARK: - Foundation
    /**
     Base64 인코딩
     */
    func encodeBase64(str: String) -> String {
        let data = str.data(using: .utf8)
        return data?.base64EncodedString() ?? ""
    }
    /**
     Base64 인코딩
     */
    func encodeBase64(data: Data) -> Data? {
        return data.base64EncodedData(options: .lineLength64Characters)
    }
    /**
     Base64 디코딩
     */
    func decodeBase64(str: String) -> String {
        guard let decodeData = Data(base64Encoded: str) else { return "" }
        return String(data: decodeData, encoding: .utf8) ?? ""
    }
    /**
     Base64 디코딩
     */
    func decodeBase64(data: Data) -> Data? {
        return Data(base64Encoded: data, options: [])
    }
}
