//
//  ViewController.swift
//  Meme Me
//
//  Created by KHALID ALSUBAIE on 29/03/2019.
//  Copyright © 2019 Arabic Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButtonOutlet: UIButton!
    @IBOutlet weak var toolbarOutlet: UIToolbar!
    
    var chosenImage = UIImage() // remove ?
    var memedImage = UIImage()
    var meme: Meme!
    var keyboardShowHideTrigger = false
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -4
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textFieldNewAttribute(textField: topTextField, text: "TOP")
        textFieldNewAttribute(textField: bottomTextField, text: "BOTTOM")
        checkIfTextFieldIsEdited()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        subscribeToKeyboardNotificationsHide()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardNotificationsHide()
    }
    
    // TEXT FIELD
    
    func textFieldNewAttribute(textField: UITextField, text: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = text
        textField.textAlignment = .center
        textField.delegate = self
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        if textField == topTextField {
            keyboardShowHideTrigger = false
        }
        if textField == bottomTextField {
            keyboardShowHideTrigger = true
        }
        
        checkIfTextFieldIsEdited()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == topTextField && textField.text == "" {
            
            textField.text = "TOP"
            
        }
        else if textField == bottomTextField && bottomTextField.text == "" {
            
            textField.text = "BOTTOM"
            
        }
        
        checkIfTextFieldIsEdited()
        keyboardShowHideTrigger = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        return false
    }

    
    
    

    // IMAGE PICKER
    @IBAction func pickingImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Choose an Image", message: "Choose an image to edit", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                self.showSaveMessage(alertTitle: "Error", message: "Camera not found", actionTitle: "OK")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

        imageView.image = chosenImage
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // KEYBOARD MANIPULATION
    @objc func keyboardWillShow(_ notification:Notification) {
        if(keyboardShowHideTrigger) {
           view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardNotificationsHide() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotificationsHide() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    // MARK: Meme
    
    func save(memedImage: UIImage) {

        let meme = Meme(image: chosenImage, topText: topTextField.text!, bottomText: bottomTextField.text!, memeImage: memedImage)
        self.meme = meme
        
        // 2.0
        // Add memes to the array on Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
//        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolbarIsVisible(visible: false)
        
        // Render view to a meme image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: SHow toolbar and navbar
        toolbarIsVisible(visible: true)
        
        return memedImage
    }
    
    func share() {
        let memeForShare = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memeForShare], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activity, success, items, error) in
            
            if success {
                self.save(memedImage: memeForShare)
                self.showSaveMessage(alertTitle: "Meme Me", message: "Your Image has been saved successfuly!", actionTitle: "OK")
                
                // 2.0
//                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activity, animated: true, completion: nil)
    }
    
    
    // Share image
    @IBAction func shareButtonPressed(_ sender: Any) {
        share()
    }
    
    func checkIfTextFieldIsEdited() {
        
        if (topTextField.text == "" || topTextField.text == "TOP") || (bottomTextField.text == "" || bottomTextField.text == "BOTTOM") {
            shareButtonOutlet.isEnabled = false
        } else {
            shareButtonOutlet.isEnabled = true
        }
    }
    
    func toolbarIsVisible(visible: Bool) {
        
        if visible {
            shareButtonOutlet.isHidden = false
            toolbarOutlet.isHidden = false
        } else {
            shareButtonOutlet.isHidden = true
            toolbarOutlet.isHidden = true
        }
        
    }
    
    func showSaveMessage(alertTitle: String, message: String, actionTitle: String) {
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
//        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: Cancel Modelly
    
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

