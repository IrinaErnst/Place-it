//
//  MessageManager.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/19/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

var inboxMessageMgr: MessageManager = MessageManager()
var sentMessageMgr: MessageManager = MessageManager()
var draftsMessageMgr: MessageManager = MessageManager()
var trashMessageMgr: MessageManager = MessageManager()


struct message{
    var receiver: String = "Enter Phone Number"
    var place: String = "Enter Place"
    var content: String = "Enter New Message"
    // optionally add date (time of message delivery)
}

class MessageManager: NSObject {
   
    // Create messages array:
    var messages = [message]()
    
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
    func addMessage(receiver_arg: String, place_arg: String, content_arg: String){
        messages.append(message(receiver:receiver_arg, place: place_arg, content:content_arg))
    }
    
}
