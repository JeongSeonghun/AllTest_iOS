//
//  QuickActionManager.swift
//  AllTest
//  
//  Created by jsh on 2021/12/17
//  custom header comment

import Foundation

/**
 quick action test
 */
class QuickActionManager {
    static func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        switch TestQuickAction(rawValue: shortcutItem.type) {
        case .TestDynamic:
            TestManager.instance.quickAction = shortcutItem.type
            NotificationCenter.default.post(name: .testQuickActionCheck, object: nil)
            break
        case .TestStatic:
            TestManager.instance.quickAction = shortcutItem.type
            NotificationCenter.default.post(name: .testQuickActionCheck, object: nil)
            break
        default:
            break
        }
        return true
    }
}

extension TestContact {
    var quickActionUserInfo: [String: NSSecureCoding] {
        return [ Const.QuickActionKeyId: self.identifier as NSSecureCoding ]
    }
}

extension TestContactModel {
    func getFavoriteQuickItems() -> [UIApplicationShortcutItem] {
        return TestContactModel.shared.favoriteContacts.map { contact -> UIApplicationShortcutItem in
            return UIApplicationShortcutItem(type: TestQuickAction.TestDynamic.rawValue,
                                             localizedTitle: contact.name,
                                             localizedSubtitle: contact.email,
                                             icon: UIApplicationShortcutIcon(systemImageName: "star.fill"),
                                             userInfo: contact.quickActionUserInfo)
        }
    }
}
