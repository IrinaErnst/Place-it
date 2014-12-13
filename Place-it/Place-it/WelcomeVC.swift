//
//  WelcomeVC.swift
//  Place-it
//
//  Created by Ilona Michalowska on 12/13/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

var myPhoneNumber:String = ""


// Function to change format of the phone number: +1 (917) 744-8550 -> 19177448550
func phoneNumberStr2Dig(phNumStr: String) -> String {
    
    // Eliminate nonnumerical characters
    let charactersToRemove = NSCharacterSet.alphanumericCharacterSet().invertedSet
    var phNumDig: String = "".join(phNumStr.componentsSeparatedByCharactersInSet(charactersToRemove))
    return phNumDig
}


// Function to change format of the phone number: 19177448550 -> +1 (917) 744-8550
func phoneNumberDigStr(phNumDig: String) -> String {
    
    var temp: String = phNumDig
    
    // Validation: add country code if necessary:
    if (countElements(temp) == 10){
        temp = "1" + temp
    }
    
    var country: String = temp.substringToIndex(advance(temp.startIndex,1))
    temp = temp.substringFromIndex(advance(temp.startIndex,1))
    
    var area: String = temp.substringToIndex(advance(temp.startIndex,3))
    temp = temp.substringFromIndex(advance(temp.startIndex,3))
    
    var three:String = temp.substringToIndex(advance(temp.startIndex,3))
    temp = temp.substringFromIndex(advance(temp.startIndex,3))
    
    var phNumStr: String = "+\(country) (\(area)) \(three)-\(temp)"
    
    return phNumStr
}

// Function to fix the format of a phone number
func fixPhoneNumber(initialStr: String) -> String {
    return phoneNumberDigStr(phoneNumberStr2Dig(initialStr))
}



class WelcomeVC: UIViewController {

    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var EnterButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Events:
    @IBAction func EnterButtonClicked(sender: UIButton) {
        
        // If user's phone number is not specified
        if (PhoneNumberTextField.text == "") {
            var alert: UIAlertView = UIAlertView()
            alert.title = "Your phone number is required!"
            //alert.message = ""
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else if (countElements(phoneNumberStr2Dig(PhoneNumberTextField.text)) != 11){
            var alert: UIAlertView = UIAlertView()
            alert.title = "The phone number you entered is invalid!"
            alert.message = "Please enter an 11-digit phone number"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
            
        else {
            myPhoneNumber = fixPhoneNumber(PhoneNumberTextField.text)
            self.performSegueWithIdentifier("go_to_main_view", sender: self)
        }
    }
    
    
    // IOS Touch Functions
    // keyboard goes away when click outside of text field
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if (countElements(phoneNumberStr2Dig(PhoneNumberTextField.text)) == 11){
            PhoneNumberTextField.text = fixPhoneNumber(PhoneNumberTextField.text)
        }
        
        self.view.endEditing(true)
    }
    

}







