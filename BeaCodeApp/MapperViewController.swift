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
    
    @IBOutlet weak var popUpView: UIView!
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")! as UUID, identifier: "beacodeapp.BeaCodeApp")
    var beaconsArray = [BeaconL]()
    
    var userPinImage = UIImageView()
    var notificationStatus = false

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for beacon in (SharingManager.sharedInstance.selectedEvent?.beacons)! {
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")!, positionX: 840, positionY: 458, majorValue: 10, minorValue: 6, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil, visited: false))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")!, positionX: 896, positionY: 476, majorValue: 10, minorValue: 16, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil, visited: false))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")!, positionX: 967, positionY: 509, majorValue: 10, minorValue: 17, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil, visited: false))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")!, positionX: 1007, positionY: 441, majorValue: 10, minorValue: 18, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil, visited: false))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")!, positionX: 930, positionY: 398, majorValue: 10, minorValue: 19, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil, visited: false))
        
        beaconsArray.append(BeaconL(name: nil, uuid: NSUUID(uuidString: "E555447F-D91C-4668-A32B-78304DB132D6")!, positionX: 865, positionY: 383, majorValue: 10, minorValue: 3, distanceFromUser: nil, beaconEdge: nil, lastSeenBeacon: nil, visited: false))

        //}

        popUpView.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail), name: Notification.Name.init(rawValue: "showDetail"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: Notification.Name.init("locatedBeacon"), object: nil)
    
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
    
    func showPopUp() {
        UIView.animate(withDuration: 0.4, animations: {
            
            self.popUpView.alpha = 1
        })
    }
    
    func updateLocation() {
        
        userPinImage.frame.origin.y = CGFloat(DataController.sharedInstance.actualPosition.positionY!)
        userPinImage.frame.origin.x = CGFloat(DataController.sharedInstance.actualPosition.positionX!)

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        showPopUp()
    }
    
    @IBAction func okBtnWasPressed(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4, animations: {
        
            self.popUpView.alpha = 0
        })
    }
    
    let bc = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1)
    let gc = UIColor.lightGray
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    @IBAction func star1tapped(_ sender: Any) {
        star1.setTitleColor(bc, for: .normal)
        star2.setTitleColor(gc, for: .normal)
        star3.setTitleColor(gc, for: .normal)
        star4.setTitleColor(gc, for: .normal)
        star5.setTitleColor(gc, for: .normal)
    }
    
    @IBAction func star2tapped(_ sender: Any) {
        star1.setTitleColor(bc, for: .normal)
        star2.setTitleColor(bc, for: .normal)
        star3.setTitleColor(gc, for: .normal)
        star4.setTitleColor(gc, for: .normal)
        star5.setTitleColor(gc, for: .normal)
    }
    
    @IBAction func star3tapped(_ sender: Any) {
        star1.setTitleColor(bc, for: .normal)
        star2.setTitleColor(bc, for: .normal)
        star3.setTitleColor(bc, for: .normal)
        star4.setTitleColor(gc, for: .normal)
        star5.setTitleColor(gc, for: .normal)
    }
    
    @IBAction func star4tapped(_ sender: Any) {
        star1.setTitleColor(bc, for: .normal)
        star2.setTitleColor(bc, for: .normal)
        star3.setTitleColor(bc, for: .normal)
        star4.setTitleColor(bc, for: .normal)
        star5.setTitleColor(gc, for: .normal)
    }
    
    @IBAction func star5tapped(_ sender: Any) {
        star1.setTitleColor(bc, for: .normal)
        star2.setTitleColor(bc, for: .normal)
        star3.setTitleColor(bc, for: .normal)
        star4.setTitleColor(bc, for: .normal)
        star5.setTitleColor(bc, for: .normal)
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
