//
//  TestContactModel.swift
//  AllTest
//  
//  Created by jsh on 2021/11/17
//  custom header comment

import Foundation

struct TestContactModel {
    static var shared = TestContactModel()
    
    var contacts = [
        TestContact(name: "tester1", email: "tester@test.com", isFavorite: true),
        TestContact(name: "tester2", email: "tester2@test.com", phone: "1234567", isFavorite: false),
        TestContact(name: "tester3", email: "tester3@test.com", isFavorite: false)
    ]
    
    var favoriteContacts: [TestContact] {
        return contacts.filter({ $0.isFavorite == true })
    }
    
    func contact(_ identifier: String) -> TestContact? {
        let foundContact = contacts.filter({ $0.identifier == identifier })
        return foundContact[0]
    }
    
    mutating func updateContact(_ contact: TestContact) {
        let foundContact = contacts.filter({ $0.identifier == contact.identifier })
        if let index = contacts.firstIndex(of: foundContact[0]) {
            contacts[index] = contact
        }
    }
}
