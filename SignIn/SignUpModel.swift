//
//  SignUpModel.swift
//  AppLog
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

//   Generic Class :  Maintain by Vijayvir Singh

import UIKit
import Foundation
import FontAwesome_swift




class SignUpModel: NSObject,UITextFieldDelegate
{

    // MARK: Outlets
  
    /* weak reference  Defination :- A weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance.
     
     */

    
    @IBOutlet weak var txtUserId: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtUserName: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtEmailId: SkyFloatingLabelTextFieldWithIcon!
    
    
    
     @IBOutlet weak var txtFirstName: SkyFloatingLabelTextFieldWithIcon!
    
     @IBOutlet weak var txtLastName: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtPhoneNumber: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtconfirmPassword: SkyFloatingLabelTextFieldWithIcon!
    
    

    var closureDidTapOnSubmit:  ((UserSignUp ) -> ())?
    
    
    // MARK: Variables

    // MARK: CLC
    
    // MARK: Actions
    
    
    func configure()
    {

        
        if (txtFirstName != nil)
        {
            txtFirstName.iconLabel.font = UIFont.fontAwesome(ofSize:  (txtFirstName.font?.pointSize)!)
            txtFirstName.iconLabel.text = String.fontAwesomeIcon(name: .user)
            
        }
      
    
        if (txtLastName != nil)
        {
            txtLastName.iconLabel.font = UIFont.fontAwesome(ofSize:  (txtLastName.font?.pointSize)!)
            txtLastName.iconLabel.text = String.fontAwesomeIcon(name: .user)
            
        }

        
        
        if (txtPhoneNumber != nil)
        {
            txtPhoneNumber.iconLabel.font = UIFont.fontAwesome(ofSize:  (txtPhoneNumber.font?.pointSize)!)
            txtPhoneNumber.iconLabel.text = String.fontAwesomeIcon(code: "fa-mobile-phone")
        }
       
        
        if (txtPassword != nil)
        {
            txtPassword.iconLabel.font = UIFont.fontAwesome(ofSize:  (txtPassword.font?.pointSize)!)
            txtPassword.iconLabel.text = String.fontAwesomeIcon(code: "fa-key")
        }
        
        
        if (txtconfirmPassword != nil)
        {
            txtconfirmPassword.iconLabel.font = UIFont.fontAwesome(ofSize:  (txtconfirmPassword.font?.pointSize)!)
            txtconfirmPassword.iconLabel.text = String.fontAwesomeIcon(code: "fa-key")
            
        }
        
 
        
    }
    
    @IBAction func actionSubmit(_ sender: Any)
    {
      
    
        
        if (txtFirstName != nil)
        {
            if (txtFirstName.text!.isEmpty)
            {
                showAlert( "Please add first name." ,completionHandler:
                {
                      _ = self.txtFirstName.becomeFirstResponder()
                })
                return
            }
        }
        
        if (txtLastName != nil)
        {
            if (txtLastName.text!.isEmpty)
            {
                showAlert( "Please add last name." ,completionHandler:
                {
                    _ = self.txtLastName.becomeFirstResponder()
                })
                  return
            }
        }
        
        if (txtEmailId != nil)
        {
            if (txtEmailId.text!.isEmpty)
            {
                showAlert( "Please add EmailId." ,completionHandler: {
                   _ =  self.txtEmailId.becomeFirstResponder()
                })
                return
            }
    
            if !isValidEmail(txtEmailId.text!)
            {
                showAlert( "Please add valid EmailId." ,completionHandler:
                    {
                   _ =  self.txtEmailId.becomeFirstResponder()
                })
                return
            }
            
        }
        
        
        if (txtPhoneNumber != nil)
        {
            if (txtPhoneNumber.text!.isEmpty)
            {
                showAlert( "Please add Phone number ." ,completionHandler:
                    {
                       _ =  self.txtPhoneNumber.becomeFirstResponder()
                })
                return
            }
            
            if txtPhoneNumber.text!.characters.count < Validations.maxPhoneNumber.rawValue
            {
                showAlert( "Password should have minium length of \(Validations.maxPhoneNumber.rawValue) character.",completionHandler:
                    {
                       _ =  self.txtPhoneNumber.becomeFirstResponder()
                }
                )
                return
            }
            
        }
        
        
        
        
        if (txtPassword != nil)
        {
            if (txtPassword.text!.isEmpty)
            {
                showAlert( "Please add password.", completionHandler:
                {
                   _ = self.txtPassword.becomeFirstResponder()
                
                }
                )
                return
            }
            
            
            if txtPassword.text!.characters.count < Validations.minPassword.rawValue
            {
                showAlert( "Password should have minium length of \(Validations.minPassword.rawValue) character.",completionHandler:
                    {
                       _ =   self.txtPassword.becomeFirstResponder()
                }
                )
                return
            }
        }
        
        if (txtconfirmPassword != nil)
        {
            if (txtconfirmPassword.text!.isEmpty)
            {
                showAlert( "Please add confirm password.",completionHandler:
                    {
                        _ =  self.txtconfirmPassword.becomeFirstResponder()
                }
                )
                return
            }
            
            if txtconfirmPassword.text!.characters.count < Validations.minPassword.rawValue {
                showAlert( "confirm password should have minium length of \(Validations.minPassword.rawValue) character.",completionHandler:
                {
                   _ =   self.txtconfirmPassword.becomeFirstResponder()
                }
                    
                )
                return
            }
            
            if txtconfirmPassword.text! != txtPassword.text!
            {
                showAlert( "Confirm password didn't match with password." ,completionHandler:nil)
    
                return
            }
        }
        
        let user = UserSignUp(firstName: txtFirstName.text!, lastName: txtLastName.text!, phoneNumber: txtPhoneNumber.text!, password: txtPassword.text! , type : Social.general.rawValue , method :  ServiceMethod.signUp.rawValue)
        
        
           closureDidTapOnSubmit?(user)
        
    
    }
    
    
    // MARK: Functions
    
    
    func showAlert(  _ message :String , completionHandler : (() -> Swift.Void)? = nil )
    {
    
        let keywindow = UIApplication.shared.keyWindow
        let mainController = keywindow?.rootViewController
        let alert = UIAlertController(title: "\(appName)", message: message, preferredStyle: UIAlertControllerStyle.alert)
     
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            
            print("Heloo ")
            
            completionHandler?()
            
        }))
        
        mainController?.present(alert,animated:     true ,completion:
        {
           
        })
        
    }
    
    func isValidEmail(_ testStr:String) -> Bool
    {
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
            return newLength <= Validations.maxUsername.rawValue
        }
        
        
        if (txtPhoneNumber != nil && txtPhoneNumber == textField)
        {
           
            let currentCharacterCount = textField.text?.characters.count ?? 0
            if (range.length + range.location > currentCharacterCount)
            {
                return false
            }
            let newLength = currentCharacterCount + string.characters.count - range.length
            return newLength <= Validations.maxPhoneNumber.rawValue
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
            return newLength <= Validations.maxPassword.rawValue
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
            return newLength <= Validations.maxPassword.rawValue
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



