//
//  SignUpModel.swift
//  AppLog
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

//   Generic Class :  Maintain by Vijayvir Singh

import UIKit

class SignUpModel: NSObject,UITextFieldDelegate
{

    // MARK: Outlets
  
    /* weak reference  Defination :- A weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance.
     
     */

    
    @IBOutlet weak var txtUserId: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtUserName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtEmailId: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtconfirmPassword: SkyFloatingLabelTextField!
    
    var closureDidTapOnSubmit:  (([String:String]   ) -> ())?
    
    
    // MARK: Variables

    // MARK: CLC
    
    // MARK: Actions
    
    @IBAction func actionSubmit(_ sender: Any)
    {
      
        if (txtUserId != nil)
        {
            if (txtUserId.text!.isEmpty)
            {
                showAlert( message: "Please add user ID." ,completionHandler:
                {
                     self.txtUserId.becomeFirstResponder()
                })
                return
            }
        }
        
        if (txtUserName != nil)
        {
            if (txtUserName.text!.isEmpty)
            {
                showAlert( message: "Please add user name." ,completionHandler:
                {
                    self.txtUserName.becomeFirstResponder()
                })
                  return
            }
        }
        
        if (txtEmailId != nil)
        {
            if (txtEmailId.text!.isEmpty)
            {
                showAlert( message: "Please add EmailId." ,completionHandler: {
                    self.txtEmailId.becomeFirstResponder()
                })
                return
            }
    
            if !isValidEmail(testStr: txtEmailId.text!)
            {
                showAlert( message: "Please add valid EmailId." ,completionHandler: {
                    self.txtEmailId.becomeFirstResponder()
                })
                return
            }
            
        }
        
        if (txtPassword != nil)
        {
            if (txtPassword.text!.isEmpty)
            {
                showAlert( message: "Please add password.", completionHandler:
                {
                    self.txtPassword.becomeFirstResponder()
                
                }
                )
                return
            }
            
            
            if txtPassword.text!.characters.count < 8 {
                showAlert( message: "Password should have minium length of 8 character.",completionHandler:
                    {
                         self.txtPassword.becomeFirstResponder()
                }
                )
                return
            }
        }
        
        if (txtconfirmPassword != nil)
        {
            if (txtconfirmPassword.text!.isEmpty)
            {
                showAlert( message: "Please add confirm password.",completionHandler:
                    {
                         self.txtconfirmPassword.becomeFirstResponder()
                }
                )
                return
            }
            
            if txtconfirmPassword.text!.characters.count < 8 {
                showAlert( message: "confirm password should have minium length of 8 character.",completionHandler:
                {
                     self.txtconfirmPassword.becomeFirstResponder()
                }
                    
                )
                return
            }
            
            if txtconfirmPassword.text! != txtPassword.text!
            {
                showAlert( message: "Confirm password didn't match with password." ,completionHandler:nil)
    
                return
            }
        }
        
        let userData:[String:String] = ["userId" : txtUserId.text!, "email" :txtEmailId.text!, "password" :txtPassword.text!, "userName" :txtUserName.text!]
      
           closureDidTapOnSubmit?(userData)
        
    
    }
    
    
    // MARK: Functions
    
    
    func showAlert(  message :String , completionHandler : (() -> Swift.Void)? = nil )
    {
    
        let keywindow = UIApplication.shared.keyWindow
        let mainController = keywindow?.rootViewController
        let alert = UIAlertController(title: "AppLog", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
        }))
        
        mainController?.present(alert,animated:     true ,completion:
        {
            completionHandler?()
        })
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /*
     "A delegate is an object that acts on behalf of, or in coordination with, another object when that object encounters an event in a program." (From Apple's Concepts in Objective Programming document.)
     */
    
    // MARK:- Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        if (txtUserName != nil && txtUserName == textField)
        {
            // maximum charater length
            
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount)
            {
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 25
        }
        
        if (txtPassword != nil && txtPassword == textField)
        {
            // maximum charater length
            
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount)
            {
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 15
        }
        
        if (txtconfirmPassword != nil && txtconfirmPassword == textField)
        {
            // maximum charater length
            
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount)
            {
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= 15
        }
        
    return true
    
    }
    
    
    
/*
     make object of model class 
     
     
 Use : add closure in Provided class
 
     signUp.closureDidTapOnSubmit =
     { [unowned self](dictReason  : [String:String]   ) -> () in
     
     
     }
     
     
 */
 

}



