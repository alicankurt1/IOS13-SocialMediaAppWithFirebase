//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Alican Kurt on 17.08.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            // Sign in with Email
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData , error in
                if error != nil{
                    print(error?.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }
        else{
            print("Empty Error!")
        }
        
    }
    
}

