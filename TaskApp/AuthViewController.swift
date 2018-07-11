//
//  AuthViewController.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/07/09.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldLoginPassword.delegate = self
        textFieldLoginEmail.delegate = self
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            print("user",user?.email)
            if user != nil {
                self.performSegue(withIdentifier: "home", sender: nil)
                self.textFieldLoginEmail.text = nil
                self.textFieldLoginPassword.text = nil
            }
        }
    }
    
    @IBAction func loginEmailPass(_ sender: Any) {
        guard let email = textFieldLoginEmail.text,
            let password = textFieldLoginPassword.text,
            email.count > 0,
            password.count > 0 else {return}
        
        
        print("email", textFieldLoginEmail.text)
        print("password", password)
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


    
    @IBAction func emailSignUp(_ sender: Any) {
        let alert = UIAlertController(title: "ユーザー登録",
                                      message: "登録",
                                      preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                                       password: self.textFieldLoginPassword.text!)
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)

        alert.addTextField { textEmail in
            textEmail.placeholder = "メールアドレスを入力してください。"
        }

        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "パスワードを入力してください。"
        }

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }

    
}




