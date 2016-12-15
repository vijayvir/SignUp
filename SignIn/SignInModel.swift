//
//  SignInModel.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit

enum RememberMeImages : String
{
    case  no = "login_checkboxFalse"
    
    case  yes = "login_checkboxTrue"
    
    
 }

struct RememberMe  :StructJSONSerializable
{
    var username :String
    
    var password : String
    
    var isRememberMe :Bool
    
}

class SignInModel: NSObject , UITextFieldDelegate
{

    @IBOutlet weak var imgvRemberME: UIImageView!
    
    @IBOutlet weak var txtPhoneNumber: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextFieldWithIcon!
    
    var closureDidTapOnSubmit:  ((UserLogIn ) -> ())?
    
    var closureDidTapOnForget:  (( _ phoneNumber : String ) -> ())?
    

    
    
    var  rememberMe : RememberMe?
        {
        get
        {
            if (UserDefaults.standard.object(forKey:"RememberMe") != nil)
            {
                
                let user = UserDefaults.standard.object(forKey: "RememberMe")  as AnyObject
                
                return  RememberMe(username: user["username"] as! String, password: user["password"] as! String , isRememberMe : user["isRememberMe"] as! Bool)
                
            }
                
            else
            {
                return nil
            }
        }
        
        set
        {
         //   print(type(of: newValue) , newValue)
            
            UserDefaults.standard.set( newValue?.toJsonObect() ,forKey: "RememberMe")
        }
        
    }

    
    
     // MARK: CLC
    func configure()
    {
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
        
    }
    func configureRememberMe()
    {
        
        if rememberMe == nil
        {
            if (txtPassword != nil && txtPhoneNumber != nil )
            {
                rememberMe = RememberMe(username: txtPassword.text!, password: txtPassword.text!, isRememberMe: false)
            }
        }
        else
        {
             txtPassword.text = rememberMe?.password
             txtPhoneNumber.text = rememberMe?.username
            
      
            if (rememberMe?.isRememberMe)!
            {
                if imgvRemberME != nil
                {
                    imgvRemberME.image = UIImage(named: RememberMeImages.yes.rawValue)
                }
                    
            }
            else
            {
            if imgvRemberME != nil
            {
                imgvRemberME.image = UIImage(named: RememberMeImages.no.rawValue)
            }
                    
            }
            
            
        }
        
        
        
        
        
    }
    
    
        // MARK: Actions
    
    @IBAction func actionRememberMe(_ sender: Any)
    {
    
        
        if rememberMe != nil
        {
            
            if (rememberMe?.isRememberMe)!
            {
                rememberMe = RememberMe(username: "", password: "", isRememberMe: false)
              
                if imgvRemberME != nil
                {
                      imgvRemberME.image = UIImage(named: RememberMeImages.no.rawValue)
                }
              
                
            }
            else
            {
                rememberMe = RememberMe(username: txtPassword.text!, password: txtPassword.text!, isRememberMe: true)
                
                if imgvRemberME != nil
                {
                        imgvRemberME.image = UIImage(named: RememberMeImages.yes.rawValue)
                }
            
            }
            
            
        }
    
    
    }
      @IBAction func actionFogetPassWord(_ sender: Any)
       {
        
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
        
        
         if (txtPhoneNumber != nil)
         {
             closureDidTapOnForget?(txtPhoneNumber.text!)
        }
       
        
        
       }
    
    
    @IBAction func actionSubmit(_ sender: Any)
    {
        
        

        
        
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
                         _ = self.txtPassword.becomeFirstResponder()
                }
                )
                return
            }
        }
    
        let user = UserLogIn(userId: txtPhoneNumber.text!, token: self.txtPassword.text!, type: Social.general.rawValue , method : ServiceMethod.login.rawValue)
        
        closureDidTapOnSubmit?(user)
        
        
    }
    
    
    // MARK: Functions
    
    
  @discardableResult  func showAlert(  _ message :String , completionHandler : (() -> Swift.Void)? = nil )
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
    
    
    
    
    // MARK:- textField Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
    
    return true
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
    
   
    
    
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
    
   /*
        
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
    
  */
        
        
    return true
    
    }
    
}
