//
//  DataTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation
import UIKit

/**
 class, struct 비교 및 codable 사용
 string관련 테스트, math 내장함수, 정렬
 */
class DataTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var items = [String]()
    
    let testModel = TestDataModel()
    
    override func viewDidLoad() {
        items.append(testModel.checkFunc())
        items.append(testData())
        items.append(testString())
        items.append(testMath())
        items.append(testSort())
        items.append(testFilter())
        
        tableView.reloadData()
        
        testCodable()
    }
    
    // MARK: - class, stuct 비교
    func testData() -> String {
        var text = ""
        let testClassList = testModel.getTestClassList()
        var testStructList = testModel.getTestStructList()
        text.append("origin")
        text.append("\nclass[0].name : \(testClassList[0].name)")
        text.append("\nstruct[0].name : \(testStructList[0].name)")
        
        let classData = testClassList[0]
        var structData = testStructList[0]
        classData.name = "class change data"
        structData.name = "struct change data"
        text.append("\n\nchange (list get)")
        text.append("\nclass[0].name : \(testClassList[0].name)")
        text.append("\nstruct[0].name : \(testStructList[0].name)")
        
        testClassList[0].name = "class change list"
        testStructList[0].name = "struct change list"
        text.append("\n\nchange (list direct)")
        text.append("\nclass[0].name : \(testClassList[0].name)")
        text.append("\nstruct[0].name : \(testStructList[0].name)")
        
        return text
    }
    
    // MARK: - Codable 사용
    func testCodable() {
        let dataStr = "{\"a\":1,\"c\":2,\"d\":\"12\"}"
        // decode
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(CodableTestData.self, from: dataStr.data(using: .utf8)!)
            
            NSLog("decode check: \(data)")
        } catch {
            NSLog("decode fail: \(error)")
        }
        do {
            let data = try decoder.decode(CodableData.self, from: dataStr.data(using: .utf8)!)
            
            NSLog("decode check2: \(data)")
        } catch {
            NSLog("decode fail: \(error)")
        }
        
        // encode
        let encoder = JSONEncoder()
        // init(from decoder: Decoder) 디코딩 커스텀을 위해 선언을 해서 struct 기본 초기화 사용 불가, 직접 구현 필요
//        let encodeData = CodableTestData(a: "abc", b: "ddd")
        let encodeData = CodableData(a: 1, b: 2)
        do {
            let data = try encoder.encode(encodeData)
            NSLog("encode check: \(data)")
            NSLog("encode check: \(String(data: data, encoding: .utf8) ?? "nil")")
            
        } catch {
            NSLog("encode fail: \(error)")
        }
    }
    
    // MARK: - String관련 테스트
    // split, substring
    func testString() -> String {
        var text = ""
        
        // split
        let splitText = "top/middle|center/bottom"
        text.append("splite origine: \(splitText) \n splite[1]: \(splitText.split(separator: "/")[1])")
        
        // substring
        let subStringText = "blue/red/green/yellow"
        let startIndex = subStringText.index(subStringText.startIndex, offsetBy: 5)
        let endIndex = subStringText.index(subStringText.startIndex, offsetBy: 7 + 1)
        let sub = String(subStringText[startIndex ..< endIndex])
        text.append("substring origin: \(subStringText) \n sub 5~7: \(sub)")
        
        // Enhancing String Literals Delimiters to Support Raw Text
        // swift 5.0 변경 사항. escape character / 관련 사용관련 추가 기능
        let checkValue = 2
        text.append("\"test\" check1 \(checkValue)") // 기존
        text.append("\n")
        text.append(#""test" check2 \#(checkValue)"#) // swift 5.0 추가
        
        return text
    }
    
    // MARK: - math 내장 함수 사용
    func testMath() -> String {
        var text = ""
        
        let valueList = [12, 15, 8, 13, 20]
        text.append("value list : \(valueList)")
        var minValue = valueList[0]
        var maxValue = valueList[0]
        for value in valueList {
            minValue = min(minValue, value)
            maxValue = max(maxValue, value)
        }
        text.append("\n min : \(minValue), max : \(maxValue)")
        text.append("\n pow(2,4) : \(pow(2,4))")
        text.append("\n round(5.245) : \(round(5.245))")
        text.append("\n log(2) : \(log(2.0))")
        text.append("\n log2(2) : \(log2(2.0))")
        
        return text
    }
    
    // MARK: - 데이터 정렬 test
    func testSort() -> String {
        var text = ""

        var sortList = [3,2,4,5,1]
        let sortedNum = sortList.sorted() // 데이터에 영향 없음. 반환값만 정렬
        text.append("sorted origin : \(sortList)\nsorted : \(sortedNum)")
        let sortNum = sortList.sort() // 데이터를 정렬. 반환값 필요 없읍
        text.append("\nsort origin : \(sortList)\nsort : \(sortNum)")
        
        let numList = [3,2,4,5,1]
        let sortNumDown = numList.sorted(by: >)
        let sortNumUp = numList.sorted(by: <)
        text.append("\norigin : \(numList)\nsort up: \(sortNumUp)\nsort down: \(sortNumDown)")
        
        let dataList = [TestData(title: "title1", desc: "desc1", id: 3),
                        TestData(title: "title3", desc: "desc4", id: 1),
                        TestData(title: "title2", desc: "desc2", id: 4),
                        TestData(title: "title4", desc: "desc3", id: 2)]
//        let sort = dataList.sorted(by: {($0.id ?? 0) < ($1.id ?? 0)})
//        let sort = dataList.sorted(by: compare(data1:data2:))
        let sort = dataList.sorted { data1, data2 in
            return (data1.id ?? 0) < (data2.id ?? 0)
        }
        
        text.append("\ndata\norigine :\n\(dataList)\nsort :\n\(sort)")
        
        return text
    }
    func compare(data1: TestData, data2: TestData) -> Bool {
        return (data1.id ?? 0) < (data2.id ?? 0)
    }
    
    // MARK: - filter
    func testFilter() -> String {
        var text = ""
        
        let dic = ["fst":"1", "snd":nil, "thd":"3", "etc":"a"]
        
        text.append("check not null filter\norigin : \(dic)")
        let notNullDic = dic.filter { $0.value != nil }
        text.append("\nnot null filter : \(notNullDic)")
        let notNullDic2 = notNullDic.mapValues { $0! }
        text.append("\nnot null mapValues : \(notNullDic2)")
        let notNullDic3 = dic.reduce(into: [String:String]()) { result, item in
            result[item.key] = item.value
        }
        text.append("\nnot null reduce : \(notNullDic3)")
        
        // Introduce compactMapValues to Dictionary
        // swift5.0 변경사항
        let notNullDic4 = dic.compactMapValues { $0 }
        text.append("\nnot null compactMapValues : \(notNullDic4)")
        
        let dic2 = ["one":"1","two":"b","three":"3"]
        text.append("\ncheck num filter\norigin : \(dic2)")
        let numDic = dic2.mapValues(Int.init)
        text.append("num mapValues : \(numDic)")
        let numDic2 = dic2.reduce(into: [String:Int]()) { result, item in
            result[item.key] = Int(item.value)
        }
        text.append("\nnum reduce : \(numDic2)")
        
        // swift5.0 변경사항
        let numDic3 = dic2.compactMapValues { value in
            Int(value)
        }
        text.append("\nnum compactMapValues : \(numDic3)")
        
        let countCheck = [1,4,-1,3]
        text.append("count origin \(countCheck), \(countCheck.count)")
        let count1 = countCheck.filter { $0 > 0 }.count
        text.append("count filter : \(count1)")
        
        return text
    }
    
}

extension DataTestVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    
}
