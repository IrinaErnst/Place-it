//
//  NavPlace-itViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 12/5/14.
//  Modified by Eric Glass on 12/6/2014.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class NavPlace_itViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, ABPeoplePickerNavigationControllerDelegate{
    
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
    @IBOutlet weak var AddContactButton: UIButton!
    
    
    var To: String = ""
    var From: String = ""
    var Where: String = ""
    var When: String = ""
    var What: String = ""
    var realTime: String = ""
    
    
    // Person Picker
    let personPicker: ABPeoplePickerNavigationController
    
    // This brings up address inromation from contacts without requiring permission
    required init(coder aDecoder: NSCoder) {
        personPicker = ABPeoplePickerNavigationController()
        super.init(coder: aDecoder)
        // Only bring up the phone numbers
        personPicker.displayedProperties = [
            Int(kABPersonPhoneProperty)
        ]
        personPicker.peoplePickerDelegate = self
    }

    
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
    
    
    func peoplePickerNavigationControllerDidCancel(
        peoplePicker: ABPeoplePickerNavigationController!){
            // This is required?
    }
    
    func peoplePickerNavigationController(
        peoplePicker: ABPeoplePickerNavigationController!,
        didSelectPerson person: ABRecordRef!,
        property: ABPropertyID,
        identifier: ABMultiValueIdentifier) {
            
            let phones: ABMultiValueRef = ABRecordCopyValue(person,
                property).takeRetainedValue()
            
            let index = Int(identifier) as CFIndex
            
            let phone: String = ABMultiValueCopyValueAtIndex(phones,
                index).takeRetainedValue() as String
            
            /* Put selected number in text box */
            PhoneNumberTextField.text = phone
    }
    
    
    // Events:
    
    // Contact Button
    @IBAction func performPickPersonProperty(sender : AnyObject) {
        self.presentViewController(personPicker, animated: true, completion: nil)
    }
    
    
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
