//
//  SignUpVC.swift
//  SocialMediaApp
//
//  Created by Alican Kurt on 21.08.2021.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  signUpButton.isEnabled = false
        
        profilePhotoView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectProfilePhoto))
        profilePhotoView.addGestureRecognizer(imageTapRecognizer)*/
        // Do any additional setup after loading the view.
    }
    
  /*  // Image Tap and Select in Galery
    @objc func selectProfilePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    
    // Did Finish Pick a Photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePhotoView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        signUpButton.isEnabled = true
    }
    */

    // Sign Up Click and Save Data on Firebase
    @IBAction func signupClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
    
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { AuthData, error in
                if error != nil{
                    self.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                }else{
                    // Save User Info and Segue to Feed VC
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
                
                
            }
        }else{
            showAlert(title: "Auth Problem", message: "E-mail or Password Empty!")
        }
        
    }
    
    
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
