//
//  SQLiteDataManager.swift
//  AllTest
//  
//  Created by jsh on 2021/08/26
//  custom header comment

import Foundation
import SQLite3

class SQLiteDataManager {
//    static let instance = SQLiteDataManager()
    private let DBNAME = "SQLiteTest.db"
    private let TABLE_NAME = "test_table"
    
    private var db : OpaquePointer? //db를 가리키는 포인터
    
    init() {
        let fm = FileManager.default
        let dirPaths = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dbPath = dirPaths.appendingPathComponent(DBNAME).path
        
        if fm.fileExists(atPath: dbPath) {
            // 생성된 db 사용
            NSLog("db exist")
            openDB(path: dbPath)
        } else {
            // 신규 db 생성
            NSLog("db not exist")
            createDB(path: dbPath)
        }
    }
    
    private func createDB(path: String) {
        if sqlite3_open(path, &db) == SQLITE_OK {
            createTable()
        }
    }
    
    private func openDB(path: String) {
        if sqlite3_open(path, &db) == SQLITE_OK {
            createTable()
        }
    }
    
    private func createTable() {
        // dp open 됐을 때 호출
        let createQuery = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME) (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, desc TEXT)"
        
        if sqlite3_exec(db, createQuery, nil, nil, nil) == SQLITE_OK {
            NSLog("Create Table Success")
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("Create Table fail: \(errMsg)")
        }
    }
    
    func insert(data: TestData) {
        var stmt : OpaquePointer?
        let insertQuery = "INSERT INTO \(TABLE_NAME) (title, desc) values (?,?)"
        
        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("insert prepare fail : \(errMsg)")
            return
        }
        
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        if sqlite3_bind_text(stmt, 1, data.title, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("insert bind name fail : \(errMsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, data.desc, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("insert bind desc fail : \(errMsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("insert fail : \(errMsg)")
        }
    }
    
    func selectList() -> Array<TestData> {
        var list = Array<TestData>()
        var stmt : OpaquePointer?
        let selectQuery = "SELECT * FROM \(TABLE_NAME)"
        
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("select prepare fail : \(errMsg)")
            return list
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id: Int = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let desc = String(cString: sqlite3_column_text(stmt, 2))
            
            let data = TestData(title: title, desc: desc, id: id)
            list.append(data)
        }
        
        return list
    }
    
    func select(title: String) -> Array<TestData> {
        var list = Array<TestData>()
        var stmt: OpaquePointer?
        let selectQuery = "SELECT * FROM \(TABLE_NAME) WHERE title = '\(title)'"
        
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("select prepare fail : \(errMsg)")
            return list
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id: Int = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let desc = String(cString: sqlite3_column_text(stmt, 2))
            
            let data = TestData(title: title, desc: desc, id: id)
            list.append(data)
        }
        
        return list
    }
    
    func update(data: TestData) {
        var stmt : OpaquePointer?
        let title = data.title
        let desc = data.desc
        
        let updateQuery = "UPDATE \(TABLE_NAME) SET title = '\(title)', desc = \(desc != nil ? "'\(desc ?? "")'" : "NULL")"
        
        if sqlite3_prepare(db, updateQuery, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("update prepare fail : \(errMsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("update fail : \(errMsg)")
            return
        }
        
        sqlite3_finalize(stmt)
    }
    
    func delete(id: Int) {
        var stmt : OpaquePointer?
        let deleteQuery = "DELETE FROM \(TABLE_NAME) WHERE id = \(id)"
        
        if sqlite3_prepare(db, deleteQuery, -1, &stmt, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("delete prepare fail : \(errMsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errMsg = String(cString: sqlite3_errmsg(db))
            NSLog("delete fail : \(errMsg)")
            return
        }
        sqlite3_finalize(stmt)
    }
    
    deinit {
        sqlite3_close(db)
    }
    
}
