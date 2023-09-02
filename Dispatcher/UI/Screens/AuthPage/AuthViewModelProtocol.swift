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
    func setValue(key:String,value:String)
    func buttonTapped(action:(()->Void))
}

extension AuthViewModelProtocol {
    
    func isValidEmail(_ email: String?) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
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
