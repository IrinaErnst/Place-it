//
//  ViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/4/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-25556B57FE6D"), identifier: "iBeacons")
    /*let colors = [
        //key = min_value
        30314: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
        32857: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1)
        // UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]*/

    @IBOutlet weak var PlaceItButton: UIButton!
    @IBOutlet weak var InboxButton: UIButton!
    @IBOutlet weak var DraftsButton: UIButton!
    @IBOutlet weak var SentButton: UIButton!
    @IBOutlet weak var TrashButton: UIButton!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typicaly from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
            println(beacons)
            /*let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown}
            if (knownBeacons.count > 0){
                let closestBeacon = knownBeacons[0] as CLBeacon
                self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
        }*/
        }
    }




