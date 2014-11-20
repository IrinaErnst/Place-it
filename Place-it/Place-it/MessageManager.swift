//
//  MessageManager.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/19/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

var sentMessageMgr: MessageManager = MessageManager()
var draftsMessageMgr: MessageManager = MessageManager()
var trashMessageMgr: MessageManager = MessageManager()

struct message{
    var receiver: String = "Not specified"
    var place: String = "Not specified"
    var content: String = "Not specified"
    // optionally add date (time of message delivery)
}

class MessageManager: NSObject {
   
    // Create messages array:
    var messages = [message]()
    
    // Add elements to the messages array
    func addMessage(receiver_arg: String, place_arg: String, content_arg: String){
        messages.append(message(receiver:receiver_arg, place: place_arg, content:content_arg))
    }
    
}
