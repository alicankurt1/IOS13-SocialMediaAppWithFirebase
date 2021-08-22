//
//  Alert.swift
//  SocialMediaApp
//
//  Created by Alican Kurt on 21.08.2021.
//

import Foundation
import UIKit

class AlertClass{     
    
    
    func showAlert(title: String, message: String, vc: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
}
