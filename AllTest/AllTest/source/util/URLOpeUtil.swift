//
//  URLOpeUtil.swift
//  AllTest
//  
//  Created by jsh on 2021/11/04
//  custom header comment

import Foundation

class URLOpeUtil {
    static func urlQueryAction(query: String?) {
        guard let query = query, !query.isEmpty else { return }
        let querySp = query.split(separator: "?")
        var queryDic = [String:String]()
        for queryPart in querySp {
            let queryPartSp = queryPart.split(separator: "=")
            if queryPartSp.count == 2 {
                let key = String(queryPartSp[0])
                let value = String(queryPartSp[1])
                queryDic[key] = value
            }
        }
        NSLog("check query : \(queryDic)")
        
        NotificationCenter.default.post(name: NSNotification.Name.testDeepLinkCheck, object: nil)
    }
}
