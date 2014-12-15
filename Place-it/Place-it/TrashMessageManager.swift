//
//  TrashMessageManager.swift
//  Place-it
//
//  Created by Ilona Michalowska on 12/11/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

class TrashMessageManager: NSObject {
    
    // Create messages array:
    var messages = [message]()
    var persistenceHelper: PersistenceHelper = PersistenceHelper()
    
    override init(){
        var tempMessages: NSArray = persistenceHelper.list("TrashMessage") // Reference data model
        
        for res:AnyObject in tempMessages{
            if (res.valueForKey("sender") as String == myPhoneNumber || res.valueForKey("receiver") as String == myPhoneNumber) {
                messages.append(message(sender:res.valueForKey("sender") as String, receiver:res.valueForKey("receiver") as String, place:res.valueForKey("place") as String, time:res.valueForKey("time") as String, content:res.valueForKey("content") as String, timeOfCreating:res.valueForKey("time_of_creating") as String, ID:res.valueForKey("id") as String))
            }
        }
    }
    
    
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
        
        if(persistenceHelper.save("TrashMessage", parameters: dicMessage)){
            messages.append(message(sender: sender_arg, receiver: receiver_arg, place: place_arg, time: time_arg, content: content_arg, timeOfCreating: timeOfCreating_arg, ID: ID_arg))
        }
    }
    
    
    // Remove messages at given index
    func removeMessage(index:Int) -> message{
        
        // Store removed message that can be possibly needed for appending to another message array
        var removedMessage: message = messages[index]
        
        var value:String = messages[index].ID
        
        if(persistenceHelper.remove("TrashMessage", key: "id", value: value)){
            messages.removeAtIndex(index)
        }
        
        // Return removed message
        return removedMessage
    }
}
