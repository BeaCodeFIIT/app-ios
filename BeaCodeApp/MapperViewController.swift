//
//  MapperViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 24/04/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import CoreLocation
import UIKit

class MapperViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var svgExampleView: SVGExampleView!
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")! as UUID, identifier: "sk.bc.IndoorNav")
    var beaconsArray = [BeaconL]()
    var notificationStatus = false

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(showDetail), name: Notification.Name.init(rawValue: "showDetail"), object: nil)
    
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.4
        scrollView.maximumZoomScale = 1.5
        
        scrollView.contentSize.width = 1199
        scrollView.contentSize.height = 800
        
        scrollView.addSubview(svgExampleView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation), name: NSNotification.Name(rawValue: "updateLocation"), object: nil)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view.
    }
    
    func updateLocation() {
//        pinImageFrame.origin.x = CGFloat(DataController.sharedInstance.actualPosition.positionX!)
//        pinImageFrame.origin.y = CGFloat(DataController.sharedInstance.actualPosition.positionY!)
    }
    
    func showDetail() {
        self.performSegue(withIdentifier: "showFuckinDetail", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return svgExampleView
    }
    
    func startMonitoring() {
        
        locationManager.startMonitoring(for: region)
        locationManager.startRangingBeacons(in: region)
        
    }
    
    func stopMonitoring() {
        
        locationManager.stopMonitoring(for: region)
        locationManager.stopRangingBeacons(in: region)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        manager.requestState(for: region)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside {
            
            manager.startRangingBeacons(in: self.region)
            manager.startUpdatingLocation()
            
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            for var currBeacon in self.beaconsArray {
                if currBeacon == beacon {
                    currBeacon.lastSeenBeacon = beacon
                    
                    if beacon.accuracy > 0.0 {
                        
                        currBeacon.distanceFromUser = beacon.accuracy
                        
                    } else {
                        
                        currBeacon.distanceFromUser = 99999
                        
                    }
                    
                    if DataController.sharedInstance.availableBeacons.isEmpty {
                        
                        DataController.sharedInstance.availableBeacons.append(currBeacon)
                        
                    } else {
                        
                        for var existingBeacons in DataController.sharedInstance.availableBeacons {
                            
                            if DataController.sharedInstance.availableBeacons.contains(where: { currBeacon -> Bool in
                                if currBeacon.name != nil {
                                    return true
                                }
                                return false
                            }) != false {
                             
                                if existingBeacons.name == currBeacon.name {
                                    if beacon.accuracy > 0.0 {
                                        existingBeacons.distanceFromUser = beacon.accuracy
                                        
                                    } else {
                                        DataController.sharedInstance.availableBeacons.append(currBeacon)
                                    }
                                }
                                
                            } else {
                                
                                DataController.sharedInstance.availableBeacons.append(currBeacon)
                                
                            }
                        }
                    }
                    
                    if DataController.sharedInstance.availableBeacons.count > 2 {
                        
                        DataController.sharedInstance.calculateDistance()
                        
                    }
                }
            }
        }
        

    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            
            manager.startMonitoring(for: region)
            manager.requestState(for: region)
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        if notificationStatus {
            
            let notification = UILocalNotification()
            notification.alertBody = "Welcome at FIIT STU"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.presentLocalNotificationNow(notification)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        manager.stopRangingBeacons(in: self.region)
        
        if notificationStatus {
            
            let notification = UILocalNotification()
            notification.alertBody = "You are leaving FIIT STU."
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.presentLocalNotificationNow(notification)
            
            DataController.sharedInstance.availableArea = nil
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
