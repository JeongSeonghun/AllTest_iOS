//
//  EncryptionTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/11/23
//  custom header comment

import Foundation
import UIKit

/**
 암호화 test
 암호화 사용시 TestFlight 및 스토어 배포시 iOS 수출 규정 확인 필요
 인증, 디지털 서명, 데이터 파일의 암호화 등은 면제사항으로 넘어갈 수 있음(ex. rest api https사용)
 면제사항인 경우 info.plist에 ITSAppUsesNonExemptEncryption NO를 추가하여 절차 생략가능
 */
class EncryptionTestVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = [String]()
    
    var encryptManager = EncryptionTestManager()
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let originDataStr = "encryptiontest"
        let originData = originDataStr.data(using: .utf8)!
        dataList.append("test library")
        dataList.append("origin: \(originDataStr)")
        
        // encrypt, decrypt
        let sha256Str = encryptManager.sha256(str: originDataStr)
        dataList.append("sha256: \(sha256Str)")
        
        let aes256Enc = encryptManager.encryptAES(str: originDataStr)
        let aes256Dec = encryptManager.decryptAES(str: aes256Enc)
        dataList.append("AES256 encrypt: \(aes256Enc)")
        dataList.append("AES256 decrypt: \(aes256Dec)")
        
        // base64 encode decode
        let encode = encryptManager.encodeBase64(str: originDataStr)
        let decode = encryptManager.decodeBase64(str: encode)
        let encodeData = encryptManager.encodeBase64(data: originData)!
        let decodeData = encryptManager.decodeBase64(data: encodeData)!
        dataList.append("encode base64: \(encode)")
        dataList.append("decode base64: \(decode)")
        dataList.append("encode data base64: \(String(data: encodeData, encoding: .utf8) ?? "")")
        dataList.append("decode data base64: \(String(data: decodeData, encoding: .utf8) ?? "")")
        
    }
}

extension EncryptionTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let text = dataList[indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
