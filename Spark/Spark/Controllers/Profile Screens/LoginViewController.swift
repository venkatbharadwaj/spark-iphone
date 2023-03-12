//
//  LoginViewController.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 30/12/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTxtFld: UITextField!
    
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    @IBOutlet weak var loginBtnPrp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        designViews()
    }

    func designViews(){
        loginBtnPrp.layer.cornerRadius = 9.0
        loginBtnPrp.layer.masksToBounds = true
    }

    @IBAction func loginBtnAction(_ sender: Any) {
        if userNameTxtFld.text == "" || userNameTxtFld.text == nil{
//            UserDefaults.standard.setValue(userNameTxtFld.text, forKey: "userName")
            self.showToast(message: "User name should not be empty", font: .systemFont(ofSize: 12.0))
        } else if userNameTxtFld.text!.count > 0 {
            let userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
            if userNameTxtFld.text == userName {
                
            }
            self.showToast(message: "User exist", font: .systemFont(ofSize: 12.0))

        }
    }
}


