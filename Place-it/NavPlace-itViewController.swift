//
//  NavPlace-itViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 12/5/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

class NavPlace_itViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var PlaceTextField: UITextField!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TimeTextField: UITextField!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    @IBOutlet weak var CancelBarButton: UIBarButtonItem!
    @IBOutlet weak var SendBarButton: UIBarButtonItem!
    
    
    var To: String = ""
    var From: String = ""
    var Where: String = ""
    var When: String = ""
    var What: String = ""
    var realTime: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Display message (& details)
        PhoneNumberTextField.text = To
        PlaceTextField.text = Where
        TimeTextField.text = When
        MessageTextView.text = What
        // From - implement! This is my number!
        // Real time - implement!
    
    
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Events
    @IBAction func SendBarButton_Clicked(sender: UIBarButtonItem) {
        
        // If receiver not specified, display notification
        if (PhoneNumberTextField.text == "") {
            var alert: UIAlertView = UIAlertView()
            alert.title = "Place-it can not be sent!"
            alert.message = "Specify receiver of your message"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        
        else {
            sentMessageMgr.addMessage(PhoneNumberTextField.text, place_arg: PlaceTextField.text, time_arg: TimeTextField.text, content_arg: MessageTextView.text, timeOfCreating_arg: "")
            // Only for testing Inbox. DELETE LATER:
            inboxMessageMgr.addMessage(PhoneNumberTextField.text, place_arg: PlaceTextField.text, time_arg: TimeTextField.text, content_arg: MessageTextView.text, timeOfCreating_arg: "")
    
            // Get rid of the keyboard:
            self.view.endEditing(true)
    
            // Clear text fields - do we need to do this??
            PhoneNumberTextField.text = ""
            PlaceTextField.text = ""
            TimeTextField.text = ""
            MessageTextView.text = ""
    
            // Once the message is sent, jump back to the Main view
            navigationController?.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
        }
    }
    
    // Clicking Cancel saves changes!
    @IBAction func CancelBarButton_Clicked(sender: UIBarButtonItem) {
        if (PhoneNumberTextField.text != "" || PlaceTextField.text != "" || MessageTextView.text != "") {
            draftsMessageMgr.addMessage(PhoneNumberTextField.text, place_arg: PlaceTextField.text, time_arg: TimeTextField.text, content_arg: MessageTextView.text, timeOfCreating_arg: "")
        }
    
        // Get rid of the keyboard:
        self.view.endEditing(true)
    
        // Clear text fields - do we need to do this??
        PhoneNumberTextField.text = ""
        PlaceTextField.text = ""
        TimeTextField.text = ""
        MessageTextView.text = ""
    
        // Once the message is saved in Drafts, jump back to the Main view
        navigationController?.presentingViewController?.dismissViewControllerAnimated(true, completion: {})
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


}
