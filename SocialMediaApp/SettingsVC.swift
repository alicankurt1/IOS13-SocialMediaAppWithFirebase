//
//  SettingsVC.swift
//  SocialMediaApp
//
//  Created by Alican Kurt on 21.08.2021.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch  {
            print("Logout Error")
        }      
        
        
    }
   

}
