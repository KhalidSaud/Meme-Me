//
//  TextFieldEditDelegate.swift
//  Meme Me
//
//  Created by KHALID ALSUBAIE on 29/03/2019.
//  Copyright © 2019 Arabic Technologies. All rights reserved.
//

import Foundation
import UIKit

class TextFieldEditDelegate: NSObject, UITextFieldDelegate {
    
//    let viewController = ViewController()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        viewController.unsubscribeFromKeyboardNotifications()
        return true
    }
    

    
}
