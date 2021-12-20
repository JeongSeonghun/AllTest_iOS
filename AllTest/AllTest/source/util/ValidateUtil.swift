//
//  ValidateUtil.swift
//  AllTest
//  
//  Created by jsh on 2021/08/31
//  custom header comment

import Foundation

class ValidateUtil {
    /// 이메일 유효성 체크
    static func isValidEmailAddress(email: String?) -> Bool {
        if (email == nil) { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
    
    /// 비밀번호 유효성 체크
    static func isValidatePassword(pwd: String?) -> Bool {
        if (pwd == nil) { return false }

        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: pwd)
    }
}
