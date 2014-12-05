//
//  Place-itViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/4/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit



class Place_itViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var PlaceTextField: UITextField!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    
    var toPass: message = message()
    //var toPass: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhoneNumberTextField.text = toPass.receiver
        PlaceTextField.text = toPass.place
        MessageTextView.text = toPass.content


        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Events
    @IBAction func SendButton_Clicked(sender: UIButton) {
        sentMessageMgr.addMessage(PhoneNumberTextField.text, place_arg: PlaceTextField.text,content_arg: MessageTextView.text)
        inboxMessageMgr.addMessage(PhoneNumberTextField.text, place_arg: PlaceTextField.text,content_arg: MessageTextView.text)
        
        // Get rid of the keyboard:
        self.view.endEditing(true)
        
        // Clear text fields
        PhoneNumberTextField.text = "Enter Phone Number"
        PlaceTextField.text = "Enter Place"
        MessageTextView.text = "Enter New Message"
        
        // Once the message is sent, jump back to the first view
        // IMPLEMENT!
        // self.tabBarController.selectedIndex = 0
        
        //println("Send Button was clicked.")
    }
    
    @IBAction func CancelButton_Clicked(sender: UIButton) {
        
        if PhoneNumberTextField.text != "Enter Phone Number" || PlaceTextField.text != "Enter Place" || MessageTextView.text != "Enter New Message"{
            draftsMessageMgr.addMessage(PhoneNumberTextField.text, place_arg: PlaceTextField.text, content_arg: MessageTextView.text)
        }
        
        // Get rid of the keyboard:
        self.view.endEditing(true)
        
        // Clear text fields
        PhoneNumberTextField.text = "Enter Phone Number"
        PlaceTextField.text = "Enter Place"
        MessageTextView.text = "Enter New Message"
        
        // Once the message is saved in Drafts, jump back to the first view
        // IMPLEMENT!
        // self.tabBarController.selectedIndex = 0
    }
    
    
    
    
    // IOS Touch Functions
    // keyboard goes away when click outside of text field
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    
    // UITextFieldDelegate optional function (if a person press Return key)
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        return true
    // called when 'return' key pressed. return NO to ignore.
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
