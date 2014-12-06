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

var inboxMessageMgr: MessageManager = MessageManager()
var sentMessageMgr: MessageManager = MessageManager()
var draftsMessageMgr: MessageManager = MessageManager()
var trashMessageMgr: MessageManager = MessageManager()



struct message{
    var receiver: String = ""
    var place: String = ""
    var time: String = ""
    var content: String = ""
    // time of creating a message:
    var timeOfCreating = ""
    
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
    func addMessage(receiver_arg: String, place_arg: String, time_arg: String, content_arg: String, timeOfCreating_arg: String){
        messages.append(message(receiver: receiver_arg, place: place_arg, time: time_arg, content: content_arg, timeOfCreating: timeOfCreating_arg))
    }
    
}
