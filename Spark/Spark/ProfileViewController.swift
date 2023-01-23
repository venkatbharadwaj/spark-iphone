//
//  ProfileViewController.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 21/12/22.
//


import SwiftUI
import FirebaseAuth

class ProfileViewController: UIViewController,someProtocol {
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var closeBtnPrp: UIButton!
    
    @IBOutlet weak var didntReciveOtpLbl: UILabel!
    @IBOutlet weak var MobileNoErrorLbl: UILabel!
    @IBOutlet weak var otpVarificationTitleLbl: UILabel!
    
    @IBOutlet weak var otpVarificationDescriptionLbl: UILabel!
    
    @IBOutlet weak var submitBtnPrp: UIButton!
    
    @IBOutlet weak var resendOtpBtnPrp: UIButton!
    
    @IBOutlet weak var mobileNumberTxt: UITextField!
    
    @IBOutlet weak var profileBgView: UIView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var profileNameLbl: UILabel!
    
    @IBOutlet weak var profileEmailLbl: UILabel!
    
    @IBOutlet weak var profilePhoneNumberLbl: UILabel!
    @IBOutlet weak var signOutBtnPrp: UIButton!
    
    @IBOutlet weak var profileVieww: UIView!
    
    @IBOutlet weak var mobileNumberBgView: UIView!
    
    @IBOutlet weak var transparentVieww: UIView!
    @IBOutlet weak var loginSignupBgView: UIView!
    var mobileNumberStr:String = ""
    var activityView: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       ProfileViewStyles()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        transparentVieww.addSubview(blurEffectView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        // Apply Gradient Color
//          let gradientLayer:CAGradientLayer = CAGradientLayer()
//          gradientLayer.frame.size = submitBtnPrp.frame.size
//          gradientLayer.colors =
//        [UIColor.systemGray4.cgColor,UIColor.blue.withAlphaComponent(0.5).cgColor]
//          //Use diffrent colors
//          submitBtnPrp.layer.addSublayer(gradientLayer)
        activityView = UIActivityIndicatorView(style: .large)
           activityView?.center = self.view.center
           self.view.addSubview(activityView!)
          // activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }

   
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.data(forKey: "profileImage") != nil {
            loadImage()
        }
        updateUserDetails()
        self.checkUserSignIn()
    }
    func buttonStyles(){
        submitBtnPrp.layer.cornerRadius = 8.0
        submitBtnPrp.layer.masksToBounds = true
        signOutBtnPrp.layer.cornerRadius = 8.0
        signOutBtnPrp.layer.masksToBounds = true
        addToolBar()
    }
    
    func addToolBar(){
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        mobileNumberTxt.inputAccessoryView = numberToolbar
    }

    @objc func doneWithNumberPad() {
        self.view.endEditing(true)
    }
    
    func ProfileViewStyles(){
        buttonStyles()
        mobileNumberTxt.delegate = self
        profileImg.layer.cornerRadius = profileImg.layer.frame.size.width/2
        profileImg.layer.masksToBounds = true
        loginSignupBgView.layer.cornerRadius = 15.0
        loginSignupBgView.layer.masksToBounds = true
        resendOtpBtnPrp.isHidden = true
        didntReciveOtpLbl.isHidden = true
    }
    
    func updateUserDetails(){
        let userFirstName = UserDefaults.standard.value(forKey: "firstName") as? String ?? ""
        let userLastName = UserDefaults.standard.value(forKey: "lastName") as? String ?? ""
        self.profileNameLbl.text = "\(userFirstName) \(userLastName)"
        
        let emailId = UserDefaults.standard.value(forKey: "emmailId") as? String
        self.profileEmailLbl.text = emailId
        
        let mobiileNumb = UserDefaults.standard.value(forKey: "mobileNumber") as? String
        self.profilePhoneNumberLbl.text = mobiileNumb
    }
    
    func checkUserSignIn(){
//       let userName = UserDefaults.standard.value(forKey: "userName") as? String
//        if userName == nil {
//            loginSignupBgView.isHidden = false
//            profileVieww.isHidden = true
//            return
//        }
//
//        if userName!.count > 0 {
//            loginSignupBgView.isHidden = true
//            profileVieww.isHidden = false
//        } else {
//            loginSignupBgView.isHidden = false
//            profileVieww.isHidden = true
//        }
        
        if Auth.auth().currentUser == nil {
            loginSignupBgView.isHidden = false
            profileVieww.isHidden = true
            return
        } else {
            loginSignupBgView.isHidden = true
            profileVieww.isHidden = false
        }
        
    }
    
    func updateDetails() {
        updateUserDetails()
        self.checkUserSignIn()
    }

    
    func presentSignupVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        vc.modalPresentationStyle = .overFullScreen //or .overFullScreen for transparency
        vc.delegate = self
        vc.mobileNumberStr = mobileNumberStr
        self.present(vc, animated: true, completion: nil)
    }
    
    
   
    
    func clearTextAndUpdateUIToOTP(){
        self.hideActivityIndicator()
        mobileNumberTxt.text = ""
        mobileNumberTxt.placeholder = "Enter Otp"
        submitBtnPrp.setTitle("Verify OTP", for: UIControl.State.normal)
        otpVarificationDescriptionLbl.text = "Enter OTP sent to \(mobileNumberStr)"
        //closeBtnPrp.isHidden = false
        resendOtpBtnPrp.isHidden = false
        didntReciveOtpLbl.isHidden = false
    }
    
    
    func sendSMSCode(){
        activityView?.startAnimating()
        AuthManager.shared.startAuth(phoneNumber: mobileNumberTxt.text ?? "") { [weak self] success in
            guard success else {
                return
            }
            DispatchQueue.main.async {
                
                self?.clearTextAndUpdateUIToOTP()
            }
        }
    }
    
    func otpIsNotValid(msgStr:String){
        loginSignupBgView.shake(count: 5, for: 1, withTranslation: 10)
        mobileNumberTxt.layer.borderWidth = 0.5
        mobileNumberTxt.layer.borderColor = UIColor.red.cgColor
        self.showToast(message: msgStr, font: .systemFont(ofSize: 12.0))
    }
}



extension ProfileViewController {
    // Button Actions
    
    @IBAction func signOutBtnAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "profileImage")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "emmailId")
        UserDefaults.standard.removeObject(forKey: "mobileNumber")
        self.showToast(message: "Signed out successfully", font: .systemFont(ofSize: 12.0))
        
        do {
               try Auth.auth().signOut()
           } catch let error {
               // handle error here
               print("Error trying to sign out of Firebase: \(error.localizedDescription)")
           }
        viewWillAppear(true)
    }
    
    func mobileNumberError(){
        MobileNoErrorLbl.isHidden = false
        mobileNumberTxt.layer.borderWidth = 0.5
        mobileNumberTxt.layer.borderColor = UIColor.red.cgColor
        MobileNoErrorLbl.text = "Mobile number should not be empty"
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        if mobileNumberTxt.placeholder == "Enter Mobile Number" {
            if mobileNumberTxt.text?.count ?? 0 > 0 {
                sendSMSCode()
            } else {
                mobileNumberError()
            }
        } else {
            if let text = mobileNumberTxt.text, !text.isEmpty {
                let code = text
                AuthManager.shared.verifyCode(smsCode: code) { success in
                    guard success else
                    {
                        print("failed to verify OTP")
                        self.otpIsNotValid(msgStr: "OTP is not valid")
                        return
                    }
                    DispatchQueue.main.async {
                        self.presentSignupVC()
                    }
                }
            } else {
                self.otpIsNotValid(msgStr: "Enter OTP sent")
            }
        }
    }
    
    @IBAction func resendOtpBtnAction(_ sender: Any) {
        AuthManager.shared.startAuth(phoneNumber: mobileNumberStr) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                self?.clearTextAndUpdateUIToOTP()
            }
        }
    }
    
    
    
    @IBAction func closeOtpScreen(_ sender: Any) {
      //  closeBtnPrp.isHidden = true
        didntReciveOtpLbl.isHidden = true
        resendOtpBtnPrp.isHidden = true
        mobileNumberTxt.placeholder = "Enter Mobile Number"
        submitBtnPrp.setTitle("Get OTP", for: UIControl.State.normal)
    }
    
    @IBAction func uploadImgBtnAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                   imagePicker.delegate = self
                   imagePicker.sourceType = .photoLibrary
                   imagePicker.allowsEditing = false
                   present(imagePicker, animated: true, completion: nil)
               }
    }
    
}

extension ProfileViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true, completion: nil)
           if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               profileImg.image = image
               saveImage(img: image)
           }
     }
}

extension ProfileViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        MobileNoErrorLbl.isHidden = true
        
        mobileNumberTxt.layer.borderWidth = 0.0
        mobileNumberTxt.layer.borderColor = UIColor.clear.cgColor
        updateMobileNumbString()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateMobileNumbString()
    }
    
    func updateMobileNumbString(){
        if submitBtnPrp.titleLabel?.text != "Verify OTP" {
            mobileNumberStr = mobileNumberTxt.text ?? ""
        }
    }
}

extension ProfileViewController {
        func saveImage(img:UIImage) {
            guard let data = img.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: "profileImage")
        }

        func loadImage() {
            guard let data = UserDefaults.standard.data(forKey: "profileImage") else { return }
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            profileImg.image = UIImage(data: decoded)
        }
}
