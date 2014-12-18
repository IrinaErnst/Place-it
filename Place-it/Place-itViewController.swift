//
//  Place-itViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/4/14.
//  Modified by Eric Glass on 12/6/2014. (Add Contact functionality, i.e. performPickPersonProperty. Fixed by IM)
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI
import Alamofire


class Place_itViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate,ABPeoplePickerNavigationControllerDelegate{
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var PlaceTextField: UITextField!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TimeTextField: UITextField!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    @IBOutlet weak var AddContactButton: UIButton!
    @IBOutlet weak var PlacePickerView: UIPickerView!
    @IBOutlet weak var TimePickerView: UIDatePicker!
    
    
    var From: String = ""
    var To: String = ""
    var Where: String = ""
    var When: String = "N/A"
    var What: String = ""
    var realTime: String = ""
    var id: String = "" // (From+": "+realTime)
    
    
    // Place and date&time picker:
    // var places = ["Forest Hills 71st Str", "Flying Pig Pub", "Home", "Anywhere"]
    // Translation: ["Blue iBeacon", "Green iBeacon", "Purple iBeacon", "Anywhere"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1 // # of spinning wheels
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return places.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        return places[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        PlaceTextField.text = places[row]
        PlacePickerView.hidden = true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField == PhoneNumberTextField){
            PlacePickerView.hidden = true
            TimePickerView.hidden = true
            return true
        }
        else if (textField == PlaceTextField){
            PlacePickerView.hidden = false
            TimePickerView.hidden = true
            PlaceTextField.text = "" // clears text field while picker is visible
        }
        else if (textField == TimeTextField){
            PlacePickerView.hidden = true
            TimePickerView.hidden = false
            TimeTextField.text = "" // clears text field while picker is visible
            TimePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        }
        return false
    }
    
    //Date picker
    /*//This brings up date picker as keyboard when time text field is pressed
    @IBAction func dp(sender: UITextField) {
        //var datePickerView  : UIDatePicker = UIDatePicker()
        sender.inputView = TimePickerView
        TimePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }*/
    // Puts selected date in text field
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy MMM dd hh:mm aaa"
        TimeTextField.text = dateFormatter.stringFromDate(sender.date)
        TimePickerView.hidden = true
    }
    
    
    // For seguue:
    //var toPass: message = message()
    
    
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
        
        // Setup for place picker:
        PlacePickerView.hidden = true
        PlaceTextField.delegate = self
        PlacePickerView.delegate = self
        
        // Setup for date and time picker:
        TimePickerView.hidden = true
        TimeTextField.delegate = self
        

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
            PhoneNumberTextField.text = fixPhoneNumber(phone)
    }
    
    
    // Events:
    
    // Contact Button
    @IBAction func performPickPersonProperty(sender : AnyObject) {
        self.presentViewController(personPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func SendButton_Clicked(sender: UIButton) {
        
        // If receiver not specified, display notification
        if (PhoneNumberTextField.text == "") {
            var alert: UIAlertView = UIAlertView()
            alert.title = "Place-it can not be sent!"
            alert.message = "Specify receiver of your message"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else if ((countElements(phoneNumberStr2Dig(PhoneNumberTextField.text)) != 11)) {
            var alert: UIAlertView = UIAlertView()
            alert.title = "The phone number you entered is invalid!"
            alert.message = "Please enter an 11-digit phone number"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        else {
            // Save date and time of sending the message:
            var timeOfCreating = getCurrentDateAndTime()
            
            PhoneNumberTextField.text = fixPhoneNumber(PhoneNumberTextField.text)
            
            sentMessageMgr.addMessage(myPhoneNumber, receiver_arg: PhoneNumberTextField.text, place_arg: PlaceTextField.text, time_arg: TimeTextField.text, content_arg: MessageTextView.text, timeOfCreating_arg: timeOfCreating, ID_arg: myPhoneNumber + timeOfCreating)
            // Only for testing Inbox. DELETE LATER:
            //inboxMessageMgr.addMessage(myPhoneNumber, receiver_arg: PhoneNumberTextField.text, place_arg: PlaceTextField.text, time_arg: TimeTextField.text, content_arg: MessageTextView.text, timeOfCreating_arg: timeOfCreating, ID_arg: myPhoneNumber + timeOfCreating)
        
            // *****************************************************************************************
            
            // Connect with the server here and in NavPlace-itViewController
            //    key = "m|#{params[:UUID]}|#{params[:major]}|#{params[:minor]}|#{params[:receiver]}|#{timestamp}"
            //value = {"sender"=>"#{params[:sender]}","message"=>"#{params[:message]}","created_at"=>"#{timestamp}"}

            
            Alamofire.request(.POST, "http://frozen-shelf-4349.herokuapp.com/beacons.json", parameters: ["UUID": beacon_uuid,"major": maj_val,"minor": min_val,"receiver": PhoneNumberTextField.text, "sender":myPhoneNumber, "message": MessageTextView.text])
                .responseJSON { (request, response, data, error) in
                    //                println(request)
                    //                println(response)
                    //                println(data)
                    //println(data!["content"])
                    //var message:String = data!["content"] as String
                    //                println(error)
            }
        
            
            // *****************************************************************************************
        
            // Get rid of the keyboard:
            self.view.endEditing(true)
        
            // Clear text fields
            PhoneNumberTextField.text = ""
            PlaceTextField.text = ""
            TimeTextField.text = "N/A"
            MessageTextView.text = ""
        
            // Once the message is sent, stay in the Place-it view
            
        }
    }
    

    
    @IBAction func CancelButton_Clicked(sender: UIButton) {
        
        if (PhoneNumberTextField.text != "" || PlaceTextField.text != "" || TimeTextField.text != "N/A" || MessageTextView.text != "") {
            
            // Save date and time of saving the message:
            var timeOfCreating = getCurrentDateAndTime()
            
            draftsMessageMgr.addMessage(myPhoneNumber, receiver_arg: PhoneNumberTextField.text, place_arg: PlaceTextField.text, time_arg: TimeTextField.text, content_arg: MessageTextView.text, timeOfCreating_arg: timeOfCreating, ID_arg: myPhoneNumber + timeOfCreating)
        }
        
        // Get rid of the keyboard:
        self.view.endEditing(true)
        
        // Clear text fields
        PhoneNumberTextField.text = ""
        PlaceTextField.text = ""
        TimeTextField.text = "N/A"
        MessageTextView.text = ""
        
        // Once the message is saved in Drafts, jump back to the Main view
    }

    
    // IOS Touch Functions
    // keyboard goes away when click outside of text field
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if (countElements(phoneNumberStr2Dig(PhoneNumberTextField.text)) == 11){
            PhoneNumberTextField.text = fixPhoneNumber(PhoneNumberTextField.text)
        }
        
        self.view.endEditing(true)
    }
    
    
    // UITextFieldDelegate optional function (if a person press Return key)
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        return true
        // called when 'return' key pressed. return NO to ignore.
    }
    
}



