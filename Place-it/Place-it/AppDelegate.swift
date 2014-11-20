//
//  AppDelegate.swift
//  Place-it
//
//  Created by Ilona Michalowska & Irina Kalashnikovaon 11/4/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
        
        locationManager = CLLocationManager()
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")){
            locationManager!.requestAlwaysAuthorization()
        }
        locationManager!.delegate = self
        locationManager?.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(region)
        locationManager!.startRangingBeaconsInRegion(region)
        locationManager!.startUpdatingLocation()
        if(application.respondsToSelector("requesterUserNotificationSettings: ")){
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound, categories: nil
                )
            )
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

/*
extension AppDelegate: CLLocationManagerDelegate {
    func beaconNotificationMessage(message: String!){
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    func func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let viewController:ViewController = window!.rootViewController as ViewController
        ViewController.beacons = beacons as [CLBeacon]?
        ViewController.tableView.reloadData()
        
        NSLog("didRangeBeacons");
        var message:String = ""
        
        if(beacons.count > 0) {
            let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
            
            if(nearestBeacon:proximity == lastProximity || nearestBeacon.proximity == CLProximity.Unknown){
                return;
            }
            lastProximity = nearestBeacon.proximity;
            
            switch nearestBeacon.proximity {
            case CLProximity.Far: message = "Proximity: Far"
            case CLProximity.Near: message = "Proximity: Near"
            case CLProximity.Immediate: message = "Proximity: Immediate"
            case CLProximity.Unknown: return
            }
        } else {
            message = "No beacons"
        }
        
        NSLog("%@", message)
        beaconNotificationMessage(message)
    }
}
*/
