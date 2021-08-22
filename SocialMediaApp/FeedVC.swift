//
//  FeedVC.swift
//  SocialMediaApp
//
//  Created by Alican Kurt on 21.08.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var feedTableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userImageUrlArray = [String]()
    var userImageLikeCountArray = [Int]()
    var documentIdArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self

        // Do any additional setup after loading the view.
        
        getDataFromFirebase()
    }
    
    
    func getDataFromFirebase(){
        
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot , error in
            if error != nil{
                print(error?.localizedDescription ?? "Error")
            }else{
                // get data from database
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    // Delete Arrays
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userImageUrlArray.removeAll(keepingCapacity: false)
                    self.userImageLikeCountArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                            if let comment = document.get("postComment") as? String{
                                self.userCommentArray.append(comment)
                                if let imageUrl = document.get("imageUrl") as? String{
                                    self.userImageUrlArray.append(imageUrl)
                                    if let likeCount = document.get("likes") as? Int{
                                        self.userImageLikeCountArray.append(likeCount)
                                    }
                                }
                            }
                        }
                        
                    }
                    // end for
                    self.feedTableView.reloadData()
                    
                }
                
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeCountLabel.text = String(userImageLikeCountArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: self.userImageUrlArray[indexPath.row]))
        
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        
        
        return cell
    }
    
    
    

   
}
