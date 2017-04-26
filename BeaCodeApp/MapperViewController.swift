//
//  MapperViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 24/04/2017.
//  Copyright © 2017 Marek. All rights reserved.
//

import CoreLocation
import UIKit
import UserNotifications

class MapperViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var svgExampleView: SVGExampleView!
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")! as UUID, identifier: "beacodeapp.BeaCodeApp")
    var beaconsArray = [BeaconL]()
    
    var userPinImage = UIImageView()
    var notificationStatus = false

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for beacon in (SharingManager.sharedInstance.selectedEvent?.beacons)! {
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 969, positionY: 112.7, majorValue: 1, minorValue: 102, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 1024, positionY: 130.7, majorValue: 1, minorValue: 103, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 972, positionY: 166.7, majorValue: 1, minorValue: 106, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 1016, positionY: 221, majorValue: 1, minorValue: 107, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 957, positionY: 270, majorValue: 1, minorValue: 108, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 1016, positionY: 309.9, majorValue: 1, minorValue: 109, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))

        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 957, positionY: 348.3, majorValue: 1, minorValue: 110, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))

        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!, positionX: 1016, positionY: 370.3, majorValue: 1, minorValue: 111, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil))


        //}


        NotificationCenter.default.addObserver(self, selector: #selector(showDetail), name: Notification.Name.init(rawValue: "showDetail"), object: nil)
    
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.4
        scrollView.maximumZoomScale = 1.5
        
        scrollView.contentSize.width = 1199
        scrollView.contentSize.height = 800
        
        scrollView.addSubview(svgExampleView)
        svgExampleView.addSubview(userPinImage)
        
        userPinImage.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        userPinImage.image = UIImage(named: "position.png")
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation), name: NSNotification.Name(rawValue: "updateLocation"), object: nil)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view.
    }
    
    func updateLocation() {
        
        userPinImage.frame.origin.y = CGFloat(DataController.sharedInstance.actualPosition.positionY!)
        userPinImage.frame.origin.x = CGFloat(DataController.sharedInstance.actualPosition.positionX!)
        

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

                            if DataController.sharedInstance.availableBeacons.contains(where: { $0.minorValue == currBeacon.minorValue }) {
                        
                                let i = DataController.sharedInstance.availableBeacons.index(where: { $0.minorValue == currBeacon.minorValue })
                                
                                if existingBeacons.minorValue == currBeacon.minorValue && beacon.accuracy > 0.0 {
                                  
                                    DataController.sharedInstance.availableBeacons[i!].distanceFromUser = beacon.accuracy
                                    
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
    
        if #available(iOS 10, *) {
            let content = UNMutableNotificationContent()
            content.title = "Welcome at FIIT STU"
            content.body = "Have a nice IITSRC conference!"
            content.sound = UNNotificationSound.default()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "enterNotification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                }
            }
            
        } else {
            let notification = UILocalNotification()
            notification.alertBody = "Welcome at FIIT STU"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.presentLocalNotificationNow(notification)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
//        manager.stopRangingBeacons(in: self.region)
        
            if #available(iOS 10, *) {
                let content = UNMutableNotificationContent()
                content.title = "You are leaving FIIT STU."
                content.body = "Thanks for coming."
                content.sound = UNNotificationSound.default()
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "exitNotification", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) {(error) in
                    if let error = error {
                        print("Uh oh! We had an error: \(error)")
                    }
                }
                
            } else {
            
                let notification = UILocalNotification()
                notification.alertBody = "You are leaving FIIT STU."
                notification.soundName = UILocalNotificationDefaultSoundName
                UIApplication.shared.presentLocalNotificationNow(notification)
                
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
