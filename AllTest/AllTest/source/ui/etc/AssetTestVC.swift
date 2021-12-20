//
//  AssetTest.swift
//  AllTest
//  
//  Created by jsh on 2021/09/10
//  custom header comment

import Foundation
import UIKit

/**
 Color 및 Data Asset 테스트
 기본 생성된 Assets.xcassets 혹은 생성한 asset category에 파일을 import해서 사용
 */
class AssetTestVC: UIViewController {
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        initColorAsset()
        initDataAsset()
        initImageAsset()
    }
    
    func initImageAsset() {
        imageView.image = UIImage(named: "test_image")
    }
    
    func initColorAsset() {
        customLabel.textColor = UIColor(named: "ColorCustom")
    }
    
    func initDataAsset() {
        let decorder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "TestData") else { return }
        
        do {
            let data = try decorder.decode(TestData.self, from: dataAsset.data)
            dataLabel.text = "data check \(data)"
        } catch {
            NSLog("decode error : \(error)")
        }
    }
}
