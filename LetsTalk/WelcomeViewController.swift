//
//  WelcomeViewController.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-27.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import UIKit
import ProgressHUD


class WelcomeViewController: UIViewController {
    
    // there are 3 text inputs in login page
    // note you can hold ctrl drag and drop the object here in case you forget in the future
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: IB actions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("login pressed")
        dismissKeyboard()
        if userNameTextField.text != "" && passwordTextField.text != "" {
            loginUser()
        } else {
            ProgressHUD.showError("Password or Username were not filled!")
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        print("register button pressed")
        dismissKeyboard()
        if userNameTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" {
            if passwordTextField.text == confirmPasswordTextField.text {
                registerUser()
            } else {
                ProgressHUD.showError("Password and confirm password do not match!")
            }
            
        } else {
            ProgressHUD.showError("One or more of the three fields were not filled!")
        }
    }
    
    @IBAction func backgroundTap(_ sender: Any) {
        print("background tapped")
        dismissKeyboard()
    }
    
    func loginUser() {
        print("logging in right now")
        ProgressHUD.show("logging in")
        FUser.loginUserWith(email: userNameTextField.text!, password: passwordTextField.text!) { (error) in
            if error != nil {
                // localizedDescription returns human readible error
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.goToApp()
        }
    }
    
    func registerUser() {
        print("registering right now")
    }
    // 
    func dismissKeyboard() {
        //self.view.endEditing(false)
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func clearTextFields() {
        userNameTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
    
    func goToApp() {
        ProgressHUD.dismiss()
        clearTextFields()
        dismissKeyboard()
        
        print("show app")
        // show app here
    }
}
