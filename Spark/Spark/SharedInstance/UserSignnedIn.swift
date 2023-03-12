//
//  UserSignnedIn.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 07/03/23.
//

import Foundation

class UserSignIn{
    
    static let shared = UserSignIn()
//    var isUserSignnedIn = {
//        let userSignnedIn = UserDefaults.standard.value(forKey: "isUserSignedIn")
//    }
    
    var isUserSignedIn = { () -> Bool in
        let mobNumb = UserDefaults.standard.value(forKey: "mobileNumber") as? String
        if ((mobNumb?.hashValue) != nil)  {
            return true
        } else {
            return false
        }
    }
    init(){}
    
    func requestForLocation(){
        //Code Process
        
    }
    
}

