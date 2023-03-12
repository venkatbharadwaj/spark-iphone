//
//  Validations.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 05/01/23.
//

import Foundation
//extension String {
//
//    //To check text field or String is blank or not
//    var isBlank: Bool {
//        get {
//            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
//            return trimmed.isEmpty
//        }
//    }
//
//    //Validate Email
//
//    var isEmail: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
//            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
//        } catch {
//            return false
//        }
//    }
//
//    var isAlphanumeric: Bool {
//        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
//    }
//
//    //validate Password
//    var isValidPassword: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
//            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
//
//                if(self.characters.count>=6 && self.count<=20){
//                    return true
//                }else{
//                    return false
//                }
//            }else{
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
//}

class Validations {
func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
}
