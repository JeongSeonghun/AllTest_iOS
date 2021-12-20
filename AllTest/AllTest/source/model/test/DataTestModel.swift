//
//  TestModel.swift
//  AllTest
//  
//  Created by jsh on 2021/08/25
//  custom header comment

import Foundation

class TestDataModel {
    let superClass = TestSuperClass()
    let subClass = TestSubClass()
    
    func checkFunc() -> String {
        var text = ""
        
        text.append("super class")
        text.append("\n\(TestSuperClass.superStaticLet)")
        text.append("\n\(TestSuperClass.superClassVar)")
        text.append("\n\(TestSuperClass.superClassFunc())")
        text.append("\n\(TestSuperClass.superStaticFunc())")
        
        superClass.superVar = 1
        text.append("\n\(String(superClass.superVar ?? -1))")
        text.append("\n\(superClass.superFunc())")
        text.append("\n\(superClass.superFinalFunc())")
        // private 접근 불가
//        text.append("\n\(superClass.superPrivateVar)")
        // static member는 instance에서 사용불가
//        text.append("\n\(superClass.superStaticLet)")
//        text.append("\n\(superClass.superClassFunc())")
//        text.append("\n\(superClass.superStaticFunc())")
        
        text.append("\n\nsub class")
        text.append("\nsub \(TestSubClass.superStaticLet)")
        text.append("\nsub \(TestSubClass.superClassVar)")
        text.append("\nsub \(TestSubClass.superClassFunc())")
        text.append("\nsub \(TestSubClass.superStaticFunc())")
        
        subClass.superVar = 2
        text.append("\nsub \(String(subClass.superVar ?? -1))")
        text.append("\nsub \(subClass.superFunc())")
        text.append("\nsub \(subClass.superFinalFunc())")

        return text
    }
    
    func getTestClassList(cnt: Int = 10) -> Array<TestClass> {
        var list = Array<TestClass>()
        for i in 0 ..< cnt {
            let memo = i % 2 == 0 ? "memo \(i + 1)" : nil
            let data = TestClass(id: String(i))
            data.name = "class\(i + 1)"
            data.memo = memo
            list.append(data)
        }
        
        return list
    }
    
    func getTestStructList(cnt: Int = 10) -> Array<TestStruct> {
        var list = Array<TestStruct>()
        for i in 0 ..< cnt {
            let memo = i % 2 == 0 ? "memo \(i + 1)" : nil
            list.append(TestStruct(id: String(i), name: "struct\(i + 1)", memo: memo))
        }
        
        return list
    }
}

class TestSuperClass {
    // 타입 프로퍼티. static. 상속 불가
    static let superStaticLet = "superStaticLet"
    static var superStaticVar = "superStaticLet"
    // 타입 프로퍼티. class. let 사용 불가. 상속 가능. 연산타입 프로퍼티로 표현이 필수(저장타입 프로퍼티 불가).
//    class let superClassVar = "superClassVar" // 저장타입 및 let 사용으로 컴파일 에러
    class var superClassVar: String {
        get {
            return "superClassVar"
        }
    }
    class var superClassVar2: String {
        return "superClassVar2"
    }
    
    var superVar: Int?
    private var superPrivateVar: Int?
    
    // Instance 함수
    func superFunc() -> String {
        return "superFunc()"
    }
    
    // 타입 메소드. class 함수. instance에서 사용 불가
    class func superClassFunc() -> String {
        return "superClassFunc()"
    }
    
    // 타입 메소드. static 함수. instance에서 사용 불가. 상속 불가
    static func superStaticFunc() -> String {
        return "superStaticFunc()"
    }
    
    // final 상속 불가
    final func superFinalFunc() -> String {
        return "superFinalFunc()"
    }
    
    // class 함수 final. static 함수와 동일
    class final func superClassFinalFunc() -> String {
        return "superClassFunc()"
    }
    
}

class TestSubClass: TestSuperClass {
    
    override class var superClassVar: String {
        get {
            return "override superClassVar"
        }
    }
    
    override func superFunc() -> String {
        return "override superFunc()"
    }
    
    override class func superClassFunc() -> String {
        return "override superClassFunc()"
    }
    
    // static 함수 상속 불가
//    override static superStaticFunc() -> String {
//        return ""
//    }
    
    // final 함수 상속 불가
//    override class func superClassFinalFunc() -> String {
//        return ""
//    }
//    override func superFinalFunc() -> String {
//        return ""
//    }
}

// class -> 참조타입
class TestClass {
//    var name: String // class에서 초기화 필요
    var name: String = ""
    var memo: String?
    let id: String
    
    init(id: String) {
        self.id = id
    }
}

// struct -> 값타입 -> 복사
struct TestStruct {
    let id: String
    var name: String
    var memo: String?
}

enum TestEnum {
    case TestOne
    case TestTwo
    case TestThree
    
    func test() {
        switch self {
        case .TestOne:
            break
        default:
            break
        }
    }
    func testUnknown() {
        // Handling Future Enum Cases
        // swift 5.0 변경 사항. 모든 case 미사용 시 경고표기
        switch self {
        case .TestOne:
            break
        @unknown default:
            break
        }
    }
}

enum TestTypeEnum: Int {
    case TestOne = 1
    case TestTwo = 2
}
