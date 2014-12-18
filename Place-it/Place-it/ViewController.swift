//
//  ViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska & Irina Kalashnikova on 11/4/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

var g_beacon_uuid: String!
var g_maj_val: NSNumber!
var g_min_val: NSNumber!


// Places associated with beacons
var places = ["Forest Hills 71st Str", "Flying Pig Pub", "Home"/*, "Anywhere"*/]
// Translation: ["Green iBeacon", "Purple iBeacon", "Blue iBeacon", "Anywhere"]

// Function to translate beacon's UUID, Major & Minor to place name
func beaconParameters2placeName(uuid: String, major: NSNumber, minor: NSNumber) -> String {
    
    if (uuid == "B9407F30-F5F8-466E-AFF9-25556B57FE6D"){
        
        if (major == 43875 as NSNumber && minor == 58414 as NSNumber){
            return places[0]
        }
        if (major == 61334 as NSNumber && minor == 32857 as NSNumber){
            return places[1]
        }
        if (major == 21137 as NSNumber && minor == 30314 as NSNumber){
            return places[2]
        }
    }
    return "Invalid"
}



class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var PlaceItButton: UIButton!
    @IBOutlet weak var InboxButton: UIButton!
    @IBOutlet weak var DraftsButton: UIButton!
    @IBOutlet weak var SentButton: UIButton!
    @IBOutlet weak var TrashButton: UIButton!
    @IBOutlet weak var BackgroundImageView: UIImageView!
 
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for beacons detection:
        locationManager.delegate = self
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Authorized) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
        
/*
        // Notification:
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewMessage", name: "actionViewPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "doNothing", name: "actionCancelPressed", object: nil)
        
        var localNotification:UILocalNotification = UILocalNotification()
        
        localNotification.category = "NEW_MESSAGE_CATEGORY"
        localNotification.alertBody = "You've got a new Place-it message"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
*/        
        
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!)
    {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown}
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon

            // Translate beacons and produce parameter to inquiry the server for messages:
            
            var beacon_uuid: String = closestBeacon.proximityUUID.UUIDString
            var maj_val: NSNumber = closestBeacon.major
            var min_val: NSNumber = closestBeacon.minor
            var phoneBeaconID = myPhoneNumber + beaconParameters2placeName(beacon_uuid, maj_val, min_val)
            
            g_beacon_uuid = beacon_uuid
            g_maj_val = maj_val
            g_min_val = min_val
            
            /*
            var alert: UIAlertView = UIAlertView()
            alert.title = "I see a beacon!"
            alert.message = "This is " + beaconParameters2placeName(beacon_uuid, maj_val, min_val)
            alert.addButtonWithTitle("Ok")
            alert.show()
            */
            
            // *****************************************************************************************
            
            // Send inquiry to the server:
            /*
            Alamofire.request(.GET, "http://frozen-shelf-4349.herokuapp.com/beacons.json", parameters: ["phoneBeaconID": phoneBeaconID])
              .responseJSON { (request, response, data, error) in
//                println(request)
//                println(response)
//                println(data)
                println(data!["name"])
                var message:String = data!["name"] as String
//                println(error)
              }
            
            // Irina, please describe the parameters sent back to Xcode from the server

            
            
            */
            
            Alamofire.request(.GET, "http://frozen-shelf-4349.herokuapp.com/beacons.json", parameters:["UUID": beacon_uuid,"major": maj_val,"minor": min_val,"receiver": myPhoneNumber])
                .responseJSON { (request, response, data, error) in
                    //                println(request)
                    //                println(response)
                    println(data)
                    //println(data!["name"])
                    //var message:String = data!["name"] as String
                    //                println(error)
            

                    //var sender: String = data!["sender"] as String
                    //var receiver: String = data!["receiver"] as String
                    //var place: String = beaconParameters2placeName(beacon_uuid, maj_val, min_val)
                    //var message: String = data!["message"] as String
                    //var realTime: String = data!["created_at"] as String
            // if?
            // save message in Inbox
            //inboxMessageMgr.addMessage(""/*sender*/, receiver_arg: ""/*receiver*/, place_arg: ""/*place*/, time_arg: "N/A", content_arg: message, timeOfCreating_arg: ""/*realTime*/, ID_arg: ""/*sender + realTime*/)
                    
            // *****************************************************************************************
            /*
            // Notification (should be wrapped in if statement too!)
            var localNotification:UILocalNotification = UILocalNotification()
            
            localNotification.category = "NEW_MESSAGE_CATEGORY"
            localNotification.alertBody = "You received a new Place-it message"
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 20)
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            */
            }
        
        }
    }

}

