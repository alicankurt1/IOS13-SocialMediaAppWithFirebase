//
//  UploadVC.swift
//  SocialMediaApp
//
//  Created by Alican Kurt on 21.08.2021.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var uploadView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadButton.isEnabled = false
        
        uploadView.isUserInteractionEnabled = true
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPostPhoto))
        uploadView.addGestureRecognizer(viewTapRecognizer)
    }
    
    
    @objc func selectPostPhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        uploadButton.isEnabled = true
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        
        // Firebase Storage Example
        let postStorage = Storage.storage()
        let postStorageReference = postStorage.reference()
        
        let mediaFolder = postStorageReference.child("Media")
        
        if let data = uploadView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metaData, error in
                if error != nil{
                    print(error?.localizedDescription ?? "Error")
                }else{
                    // DATABASE
                    imageReference.downloadURL { url , error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            var fireDatabaseReference : DocumentReference?
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            // add data to database
                            fireDatabaseReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil{
                                    print(error?.localizedDescription ?? "Error")
                                }else{
                                    // Going to Feed Page
                                    self.uploadView.image = UIImage(systemName: "square.and.arrow.up.on.square.fill")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                            
                            
                        }
                    }
                }
            }
            
        }
        
    }
    
   

}
