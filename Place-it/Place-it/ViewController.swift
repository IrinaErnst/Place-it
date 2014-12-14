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
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() !=  CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!)
    {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown}
        if (knownBeacons.count > 0)
        {
            let closestBeacon = knownBeacons[0] as CLBeacon
//            println(closestBeacon.minor.integerValue)

            // Translate beacons and produce parameter to inquiry the server for messages:
            
            var beacon_uuid: String = closestBeacon.proximityUUID.UUIDString
            var maj_val: NSNumber = closestBeacon.major
            var min_val: NSNumber = closestBeacon.minor
            var phoneBeaconID = myPhoneNumber + beaconParameters2placeName(beacon_uuid, maj_val, min_val)
            
            
            
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
            */
            // save message in Inbox
            // inboxMessageMgr.addMessage(myPhoneNumber, receiver_arg: myPhoneNumber, place_arg: "", time_arg: getCurrentDateAndTime(), content_arg: message, timeOfCreating_arg: "", ID_arg: "")

            // display notification
            
        
        }
    }

}

