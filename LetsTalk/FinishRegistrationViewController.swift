//
//  FinishRegistrationViewController.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-28.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
   
    @IBOutlet weak var avatarImageField: UIImageView!
    
    
    var email: String!
    var password: String!
    // var avatarImage: UIView? // might not need this
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make sure this works
        print("got here")
        print(email, password)

        // Do any additional setup after loading the view.
    }
    
    // IBactions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        print("Back button pressed")
        dismissKeyboard();
        clearTextFields();
        // to go back to the welcome/login page we call this
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        print("done butto pressed")
        dismissKeyboard();
        if nameTextField.text != "" && surnameTextField.text != "" && countryTextField.text != "" && cityTextField.text != "" && phoneNumberTextField.text != "" {
            ProgressHUD.show("Registering")
            // this fucntion calls firebase auth to register the user with email and password,the other values are saved in firebase database with this new account
            FUser.registerUserWith(email: email!, password: password!, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                //if error returns form registerUserWith
                if error != nil {
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error?.localizedDescription);
                    return
                }
                // if no error
                self.registerUser()
            }
        } else {
            ProgressHUD.show("One of the fields were not filled")
        }
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func clearTextFields() {
        nameTextField.text = ""
        surnameTextField.text = ""
        countryTextField.text = ""
        cityTextField.text = ""
        phoneNumberTextField.text = ""
    }
    
    func registerUser() {
        
        let fullName = nameTextField.text! + " " + surnameTextField.text!
        var tempDictionary: Dictionary = [kFIRSTNAME: nameTextField.text!, kLASTNAME: surnameTextField.text!, kFULLNAME: fullName, kCOUNTRY: countryTextField.text!, kCITY:cityTextField.text!, kPHONE: phoneNumberTextField.text!] as [String: Any]
        
        if avatarImage == nil {
            imageFromInitials(firstName: nameTextField.text, lastName: surnameTextField.text) {
                (avatarInitials) in
                let avatarIMG = avatarInitials.jpegData(compressionQuality: 0.7)
                let avatar = avatarIMG?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                
                tempDictionary[kAVATAR] = avatar
                
                // finish registration
                self.finishRegistration(withValues: tempDictionary)
            }
        } else {
            let avatarData = avatarImage?.jpegData(compressionQuality: 0.7)
            let avatar = avatarData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            tempDictionary[kAVATAR] = avatar;
            
            // finish registation
            self.finishRegistration(withValues: tempDictionary)
            
        }
        
    }
    
    func finishRegistration(withValues: [String: Any]) {
        updateCurrentUserInFirestore(withValues: withValues) {
            (error) in
            if error != nil {
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                return
            }
            ProgressHUD.dismiss()
            //go to application main screen
            self.goToApp()
        }
    }
    
    func goToApp() {

        clearTextFields()
        dismissKeyboard()
        
        // name is Main because "Main.sotryBoard" by default. then you have to instaitate the view controller with the identifier (tabbarcontroller in this case)
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication") as! UITabBarController
        
        self.present(mainView, animated: true, completion: nil)
    }
}
