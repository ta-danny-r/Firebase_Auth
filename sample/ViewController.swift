//
//  ViewController.swift
//  sample
//
//  Created by Danny on 10/19/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        createNewUser()
    }
    
    @IBAction func onLoginPressed(_ sender: UIButton) {
        loginUser()
    }
    
    func createNewUser() {
        if emailTextField.text != nil || emailTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult: AuthDataResult?, error: Error?) in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                    print(error.localizedDescription)
                } else {
                    print("user succesfully created account: \(self.emailTextField.text!)")
                    self.openHomeVC()
                }
            }
        } else {
            showAlert(message: "Please enter a valid email")
        }
    }
    
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func loginUser() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if let error = error {
                print("Error status: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
            } else {
                self.openHomeVC()
            }
        }
    }
    
    func openHomeVC() {
        if let homeVC = self.storyboard?.instantiateViewController(identifier: "homeVC") as? HomeVC {
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

