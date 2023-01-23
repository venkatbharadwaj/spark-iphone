//
//  SignUpViewController.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 30/12/22.
//

import UIKit

protocol someProtocol {
   func updateDetails()
}

class SignUpViewController: UIViewController ,UITextFieldDelegate {

    var delegate: someProtocol?
    
    @IBOutlet weak var parkingImgBgView: UIImageView!
    @IBOutlet weak var firstNameErrorLbl: UILabel!
    @IBOutlet weak var lastNameErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var firstNameTxtFld: UITextField!
    
    @IBOutlet weak var lastNameTxtFld: UITextField!
    
    @IBOutlet weak var emailTxtFld: UITextField!

    @IBOutlet weak var mobileNumberTxtFld: UITextField!
    var mobileNumberStr:String = ""
    
    @IBOutlet weak var signupBtnPrp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.designViews()
        emailTxtFld.delegate = self
        firstNameTxtFld.delegate = self
        lastNameTxtFld.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
           parkingImgBgView.isUserInteractionEnabled = true
           parkingImgBgView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.view.endEditing(true)
        print("Img view tapped")
        // Your action
    }
    func designViews(){
        signupBtnPrp.layer.cornerRadius = 8.0
        signupBtnPrp.layer.masksToBounds = true
        mobileNumberTxtFld.text = mobileNumberStr
    }
    
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        
        if firstNameTxtFld.text != "" {
           
            UserDefaults.standard.setValue(firstNameTxtFld.text, forKey: "firstName")
        } else {
            //showToast(message: "Please enter First name", font: .systemFont(ofSize: 12.0))
            firstNameError()
            return
        }
        
        if lastNameTxtFld.text != "" {
            UserDefaults.standard.setValue(lastNameTxtFld.text, forKey: "lastName")
        } else {
//            showToast(message: "Please enter Last name", font: .systemFont(ofSize: 12.0))
            lastNameError()
            return
        }
        if emailTxtFld.text != "" {
            if ((emailTxtFld.text?.isValidEmail) != nil) {
                emailSuccess()
                UserDefaults.standard.setValue(emailTxtFld.text, forKey: "emmailId")
                
            } else {
                emailError(validationStr: "Email is not valid")
                return
            }
        } else {
           // showToast(message: "Please enter Email", font: .systemFont(ofSize: 12.0))
            emailError(validationStr: "Email should not be empty")
            return
        }
        if mobileNumberTxtFld.text != "" {
            UserDefaults.standard.setValue(mobileNumberTxtFld.text, forKey: "mobileNumber")
        }
        delegate?.updateDetails()
        self.dismiss(animated: true)
    }
    
    func firstNameError(){
        firstNameErrorLbl.isHidden = false
        firstNameTxtFld.layer.borderWidth = 0.5
        firstNameTxtFld.layer.borderColor = UIColor.red.cgColor
        firstNameErrorLbl.text = "First name should not be empty"
    }
    
    func lastNameError(){
        lastNameErrorLbl.isHidden = false
        lastNameTxtFld.layer.borderWidth = 0.5
        lastNameTxtFld.layer.borderColor = UIColor.red.cgColor
        lastNameErrorLbl.text = "Last name should not be empty"
    }
    
    func emailError(validationStr:String){
        emailErrorLbl.isHidden = false
        emailTxtFld.layer.borderWidth = 0.5
        emailTxtFld.layer.borderColor = UIColor.red.cgColor
        emailErrorLbl.text = validationStr
    }
    
    func emailSuccess(){
        emailErrorLbl.isHidden = true
        emailTxtFld.layer.borderWidth = 0
        emailTxtFld.layer.borderColor = UIColor.clear.cgColor
        emailErrorLbl.text = "email is not valid"
    }
    
    func updateUIElements(){
        firstNameErrorLbl.isHidden = true
        lastNameErrorLbl.isHidden = true
        firstNameTxtFld.layer.borderWidth = 0
        lastNameTxtFld.layer.borderWidth = 0
        firstNameTxtFld.layer.borderColor = UIColor.clear.cgColor
        lastNameTxtFld.layer.borderColor = UIColor.clear.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTxtFld {
            if emailTxtFld.text?.isValidEmail() == true {
                emailSuccess()
            } else {
                emailError(validationStr: "Email is not valid")
            }
        }
      updateUIElements()
        return true
    }
    
}



