//
//  ViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska & Irina Kalashnikova on 11/4/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var PlaceItButton: UIButton!
    @IBOutlet weak var InboxButton: UIButton!
    @IBOutlet weak var DraftsButton: UIButton!
    @IBOutlet weak var SentButton: UIButton!
    @IBOutlet weak var TrashButton: UIButton!
    @IBOutlet weak var BackgroundImageView: UIImageView!
    
    let locationManager  = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() !=  CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            //Notification about authorization to use bluetooth will be only once - IK
            locationManager.requestWhenInUseAuthorization()
        }
        //locationManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

