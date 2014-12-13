//
//  MessageManager.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/19/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import CoreData

/*
@IBOutlet var reciver: UITextField!
@IBOutlet var place: UITextField!
@IBOutlet var content: UITextField!

@IBAction func btnCancel(){
    
}

@IBAction func btnSend(){
    
}*/

var inboxMessageMgr: InboxMessageManager = InboxMessageManager()
var sentMessageMgr: SentMessageManager = SentMessageManager()
var draftsMessageMgr: DraftsMessageManager = DraftsMessageManager()
var trashMessageMgr: TrashMessageManager = TrashMessageManager()



// Function to get current date and time:
func getCurrentDateAndTime() -> String {
    let date = NSDate() //Get current date
    //Formatter for time
    let formatterTime = NSDateFormatter()
    formatterTime.timeStyle = .MediumStyle //Set style of time “3:30:32 PM”
    var timeString = formatterTime.stringFromDate(date) //Convert to String
    //Formatter for date
    let formatterDate = NSDateFormatter()
    formatterDate.dateFormat = "yyyy MMM dd" //Set style of date “2014 Dec 15”
    var dateString = formatterDate.stringFromDate(date) //Convert to String
    return dateString + " " + timeString
}

struct message{
    
    // ex.: key-value -> name-desc ??????
    
    var sender: String = ""
    var receiver: String = ""
    var place: String = ""
    var time: String = ""
    var content: String = ""
    var timeOfCreating: String = ""
    var ID: String = "" // (sender+": "+timeOfCreating)
    
}

/*class MessageManager: NSObject {
   
    // Create messages array:
    var messages = [message]()
    var persistenceHelper: PersistenceHelper = PersistenceHelper()
    
    override init(){
        var tempMessages: NSArray = persistenceHelper.list("Message") // Reference data model
        
        for res:AnyObject in tempMessages{
            messages.append(message(sender:res.valueForKey("sender") as String, receiver:res.valueForKey("receiver") as String, place:res.valueForKey("place") as String, time:res.valueForKey("time") as String, content:res.valueForKey("content") as String, timeOfCreating:res.valueForKey("time_of_creating") as String, ID:res.valueForKey("id") as String))
        }
    }
    
    
    /*// Subscript:
    subscript(index: Int) -> message{
        get {
            return self[index]
        }
        set(newValue) {
            self[index] = newValue
        }
    }*/
    
    
    // Add elements to the messages array
    func addMessage(sender_arg: String, receiver_arg: String, place_arg: String, time_arg: String, content_arg: String, timeOfCreating_arg: String, ID_arg: String){
        
        var dicMessage: Dictionary<String, String> = Dictionary<String,String>()
        dicMessage["sender"] = sender_arg
        dicMessage["receiver"] = receiver_arg
        dicMessage["place"] = place_arg
        dicMessage["time"] = time_arg
        dicMessage["content"] = content_arg
        dicMessage["time_of_creating"] = timeOfCreating_arg
        dicMessage["id"] = ID_arg
        
        if(persistenceHelper.save("Message", parameters: dicMessage)){
            messages.append(message(sender: sender_arg, receiver: receiver_arg, place: place_arg, time: time_arg, content: content_arg, timeOfCreating: timeOfCreating_arg, ID: ID_arg))
        }
    }
    
    // Remove messages at given index
    func removeMessage(index:Int) -> message{
        
        // Store removed message that can be possibly needed for appending to another message array
        var removedMessage: message = messages[index]
        
        var value:String = messages[index].ID
        
        if(persistenceHelper.remove("Message", key: "id", value: value)){
            messages.removeAtIndex(index)
        }
        
        // Return removed message
        return removedMessage
    }
}
*/
