//
//  AuthViewModelProtocol.swift
//  Dispatcher
//
//  Created by Hadar Basson on 31/08/2023.
//

import Foundation

protocol AuthViewModelProtocol {
    var fields: [String: String] { get set }
    var inputPlaceholders: [String] { get }
    var buttonText: [String] { get }
    var title: String { get }
    var isSecure: [String: Bool] { get set }
    func setValue(key:String,value:String)
    func authentication(doWhenFinish:(()->Void))
    func changeSecureByField(field: String)
}

extension AuthViewModelProtocol {
    
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegex = Strings.emailRegex
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String?) -> Bool {
        if let password = password {
            return password.count >= 7
        }
        return false
    }
    
    func isVaidRePassword(_ string1: String?, _ string2: String?) -> Bool {
        if let str1 = string1, let str2 = string2 {
            return str1 == str2
        }
        return false
    }
    
}
