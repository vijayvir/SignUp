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


struct LeoSignUpModel {

	var userId : String?
	var userName : String?
	var emailId : String?
	var firstName : String?
	var lastName : String?
	var phoneNumber : String?
	var password : String?
}

class LeoSignUpUIModel: NSObject, UITextFieldDelegate
{

	// MARK: Outlets

	/* weak reference  Defination :- A weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance.

	*/
	@IBInspectable var maxPassword : Int = 15

	@IBInspectable var minPassword : Int = 8

	@IBInspectable var maxUsername : Int = 20

	@IBInspectable var maxPhoneNumber : Int = 10

	@IBInspectable var isSimple : Bool = true

	@IBOutlet weak var txtUserId: UITextField?

	@IBOutlet weak var txtUserName: UITextField?

	@IBOutlet weak var txtEmailId: UITextField?

	@IBOutlet weak var txtFirstName: UITextField?

	@IBOutlet weak var txtLastName: UITextField?

	@IBOutlet weak var txtPhoneNumber: UITextField?

	@IBOutlet weak var txtPassword: UITextField?

	@IBOutlet weak var txtconfirmPassword: UITextField?

	var closureDidTapOnSubmit:  ((LeoSignUpModel ) -> ())?


	// MARK: Variables

	// MARK: CLC

	// MARK: Actions


	func configure()
	{
		if (txtFirstName != nil)
		{
		}

		if (txtLastName != nil)
		{
		}

		if (txtPhoneNumber != nil)
		{
			txtPhoneNumber?.keyboardType = .decimalPad
		}
		if (txtEmailId != nil)
		{
			txtEmailId?.keyboardType = .emailAddress
		}
		if (txtPassword != nil)
		{
			txtPassword?.isSecureTextEntry = true
		}
		if (txtconfirmPassword != nil)
		{
			txtconfirmPassword?.isSecureTextEntry = true
		}
	}

	@IBAction func actionSubmit(_ sender: Any)
	{



		if (txtFirstName != nil)
		{
			if (txtFirstName?.text!.isEmpty)!
			{
				showAlert( "Please add first name." ,completionHandler:
					{
						_ = self.txtFirstName?.becomeFirstResponder()
				})
				return
			}
		}

		if (txtLastName != nil)
		{
			if (txtLastName?.text!.isEmpty)!
			{
				showAlert( "Please add last name." ,completionHandler:
					{
						_ = self.txtLastName?.becomeFirstResponder()
				})
				return
			}
		}

		if (txtUserName != nil)
		{
			if (txtUserName?.text!.isEmpty)!
			{
				showAlert( "Please add user name." ,completionHandler:
					{
						_ = self.txtUserName?.becomeFirstResponder()
				})
				return
			}
		}

		if (txtEmailId != nil)
		{
			if (txtEmailId?.text!.isEmpty)!
			{
				showAlert( "Please add EmailId." ,completionHandler: {
					_ =  self.txtEmailId?.becomeFirstResponder()
				})
				return
			}

			if !isValidEmail((txtEmailId?.text!)!)
			{
				showAlert( "Please add valid EmailId." ,completionHandler:
					{
						_ =  self.txtEmailId?.becomeFirstResponder()
				})
				return
			}

		}


		if (txtPhoneNumber != nil)
		{
			if (txtPhoneNumber?.text!.isEmpty)!
			{
				showAlert( "Please add Phone number ." ,completionHandler:
					{
						_ =  self.txtPhoneNumber?.becomeFirstResponder()
				})
				return
			}

			if (txtPhoneNumber?.text!.characters.count)! < maxPhoneNumber
			{
				showAlert( "Password should have minium length of \(maxPhoneNumber) character.",completionHandler:
					{
						_ =  self.txtPhoneNumber?.becomeFirstResponder()
				}
				)
				return
			}

		}




		if (txtPassword != nil)
		{
			if (txtPassword?.text!.isEmpty)!
			{
				showAlert( "Please add password.", completionHandler:
					{
						_ = self.txtPassword?.becomeFirstResponder()

				}
				)
				return
			}


			if (txtPassword?.text!.count)! < minPassword
			{
				showAlert( "Password should have minium length of \(minPassword) character.",completionHandler:
					{
						_ =   self.txtPassword?.becomeFirstResponder()
				}
				)
				return
			}

			if !(txtPassword?.text!.isPasswordValid())! {
				showAlert( "Password should have minium length of \(minPassword) character ,  One Alphabate , One Special Character.",completionHandler:
					{
						_ =   self.txtPassword?.becomeFirstResponder()
				}
				)
				return
			}


		}

		if (txtconfirmPassword != nil)
		{
			if (txtconfirmPassword?.text!.isEmpty)!
			{
				showAlert( "Please add confirm password.",completionHandler:
					{
						_ =  self.txtconfirmPassword?.becomeFirstResponder()
				}
				)
				return
			}

			if (txtconfirmPassword?.text?.count)! < minPassword {
				showAlert( "confirm password should have minium length of \(minPassword) character.",completionHandler:
					{
						_ =   self.txtconfirmPassword?.becomeFirstResponder()
				}

				)
				return
			}

			if txtconfirmPassword?.text! != txtPassword?.text!
			{
				showAlert( "Confirm password didn't match with password." ,completionHandler:nil)

				return
			}
		}



		let user = LeoSignUpModel(userId: txtUserId?.text.leoSafe(),
		                          userName: txtUserName?.text.leoSafe(),
		                          emailId: txtEmailId?.text.leoSafe(),
		                          firstName: txtFirstName?.text.leoSafe(),
		                          lastName: txtLastName?.text.leoSafe(),
		                          phoneNumber: txtPhoneNumber?.text.leoSafe(),
		                          password: txtPassword?.text.leoSafe())



		closureDidTapOnSubmit?(user)


	}


	// MARK: Functions


	func showAlert(  _ message :String , completionHandler : (() -> Swift.Void)? = nil )
	{

		let keywindow = UIApplication.shared.keyWindow
		let mainController = keywindow?.rootViewController

		let appName  = Bundle.main.infoDictionary!["CFBundleName"] as! String

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
			return newLength <= maxUsername
		}


		if (txtPhoneNumber != nil && txtPhoneNumber == textField)
		{

			let currentCharacterCount = textField.text?.characters.count ?? 0
			if (range.length + range.location > currentCharacterCount)
			{
				return false
			}
			let newLength = currentCharacterCount + string.characters.count - range.length
			return newLength <= maxPhoneNumber
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
			return newLength <= maxPassword
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
			return newLength <= maxPassword
		}

		return true

	}

}

extension String {
	func isValidEmailAddress() -> Bool {

		var returnValue = true

		let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3 }"

		do { let regex = try NSRegularExpression(pattern: emailRegEx)

			let nsString = self as NSString

			let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))

			if results.count == 0
			{
				returnValue = false
			}

		} catch let error as NSError {
			print("invalid regex: \(error.localizedDescription)")
			returnValue = false
		}

		return  returnValue
	}

	// password Length = 8 , One Alphabate , One Special Character

	func isPasswordValid() -> Bool{
		let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
		return passwordTest.evaluate(with: self)
	}

	// password Length = 8 , 2 UpperCase letters in Password , One Special Character in Password , Two Number in Password , Three letters of lowercase in password.

	func isPasswordValidComplex() -> Bool{
		let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$")
		return passwordTest.evaluate(with: self)
	}


}

