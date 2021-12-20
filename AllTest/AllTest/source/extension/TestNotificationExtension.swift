//
//  TestNotificationExtension.swift
//  AllTest
//  
//  Created by jsh on 2021/11/05
//  custom header comment

import Foundation

extension Notification.Name {
    // Notification test
    static let testObjectSend = Notification.Name("NotificationTestAction2")
    
    // deep link test
    static let testDeepLinkCheck = Notification.Name("NotificationTestDeeplink")
    
    // quick action test
    static let testQuickActionCheck = Notification.Name("QucikActionTestCheck")
    
    // background task test
    static let testBacgkroundFetchCheck = Notification.Name("BackgroundFetchTestCheck")
    static let testBacgkroundProcessCheck = Notification.Name("BackgroundProcessTestCheck")
}
