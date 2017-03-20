//
//  NavigationViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 03/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import NMPopUpViewSwift

public class NavigationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var actualDistanceLabel: UILabel!
    @IBOutlet weak var inRangeLabel: UILabel!
    
    @IBAction func increaseInterval(_ sender: Any) {
        timeIntervalInSeconds.add(1)
        intervalLabel.text = "\(timeIntervalInSeconds)s"
    }
    
    @IBAction func decreaseInterval(_ sender: Any) {
        if timeIntervalInSeconds > 2 {
            timeIntervalInSeconds.subtract(1)
            intervalLabel.text = "\(timeIntervalInSeconds)s"
        }
    }

    var locationManager: CLLocationManager!
    var popVC: PopUpViewControllerSwift!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleText: "NAVIGATION")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        let bundle = Bundle(for: PopUpViewControllerSwift.self)
        popVC = PopUpViewControllerSwift(nibName: "PopUpViewController_iPhone6Plus", bundle: bundle)
        
        initBeaconTracking()
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    let uuid = UUID(uuidString: "DEADBEEF-CA1F-BABE-FEED-FEEDC0DEFACE")!
    
    func startScanning() {
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "Gimbals")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    var trackedBeacons: Dictionary<String, BeaconMeasuraments>!
    var timeStart: Date!
    var timeIntervalInSeconds: Double = 5
    
    func initBeaconTracking() {
        trackedBeacons = Dictionary<String, BeaconMeasuraments>()
        timeStart = Date()
        intervalLabel.text = "\(timeIntervalInSeconds)s"
    }
    
    public func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        inRangeLabel.text = "\(beacons.count)"
        if beacons.count > 0 {
            let nearestBeacon = beacons.first
            let rounded = String(format: "%.1f", nearestBeacon!.accuracy)
            
            print("Info: \(beacons.count) beacons detected")
            print("Info: Nearest beacon \t\(nearestBeacon!.major)-\(nearestBeacon!.minor)")
            print("Info: Accuracy \t\t\(String(format: "%.1f", nearestBeacon!.accuracy))m\n")
         
            if nearestBeacon!.accuracy > 0 {
                actualDistanceLabel.text = rounded
                uuidLabel.text = nearestBeacon?.proximityUUID.uuidString
                majorLabel.text = nearestBeacon?.major.stringValue
                minorLabel.text = nearestBeacon?.minor.stringValue
            }
            
            let timeNow = Date()
            
            if timeNow.timeIntervalSince(timeStart) > timeIntervalInSeconds {
                timeStart = Date()
                let closestBeacon = Array(trackedBeacons.values).sorted(by: { $0.0.avgDistance < $0.1.avgDistance }).first
                if closestBeacon != nil {
                    let roundedAvg = String(format: "%.1f", closestBeacon!.avgDistance)
                    print("Info: AVG DISTANCE: \(roundedAvg)m\n\n\n")
                    
                    uuidLabel.text = uuid.uuidString
                    majorLabel.text = closestBeacon!.major
                    minorLabel.text = closestBeacon!.minor
                    distanceLabel.text = roundedAvg
                    trackedBeacons = Dictionary<String, BeaconMeasuraments>()
                    
                    if closestBeacon!.avgDistance < 1.0 { //is closer than 1m
//                        presentPopup()
                    }
                }
            }
            
            for beacon in beacons {
                if beacon.accuracy < 0 {
                    print("info: Ignoring beacon with negative accuracy.")
                } else {
                    let key = keyForBeacon(beacon: beacon)
                    if trackedBeacons[key] == nil {
                        trackedBeacons[key] = newBeaconMeasuraments(beacon: beacon)
                    } else {
                        trackedBeacons[key]?.accuracyMeasuraments.append(beacon.accuracy)
                        let sum = trackedBeacons[key]?.accuracyMeasuraments.reduce(0, +)
                        let count = trackedBeacons[key]?.accuracyMeasuraments.count
                        trackedBeacons[key]?.avgDistance = sum! / Double(count!)
                    }
                    
                }
                
            }
            
            
        } else {
            inRangeLabel.text = "0"
            uuidLabel.text = "-"
            majorLabel.text = "-"
            minorLabel.text = "-"
            actualDistanceLabel.text = "0.0m"
            distanceLabel.text = "0.0m"
        }
    }
    
    func getClosestBeaconByAverageDistance(trackedBeacons: Dictionary<String, BeaconMeasuraments>) -> BeaconMeasuraments? {
        return Array(trackedBeacons.values).sorted(by: { $0.0.avgDistance < $0.1.avgDistance }).first
    }
    
//    func presentPopup() {
//        if !SharingManager.sharedInstance.selectedEvent.exhibits.isEmpty && !popVC.isActive {
//            popVC.title = "test popup view"
//            popVC.showInView(self.view,
//                             withImage: SharingManager.sharedInstance.selectedEvent.exhibits[0].photo,
//                             withMessage: SharingManager.sharedInstance.selectedEvent.exhibits[0].title,
//                             animated: true)
//        }
//        
//
//    }
    
    func keyForBeacon(beacon: CLBeacon) -> String {
        return "\(uuid)+\(beacon.major)+\(beacon.minor)"
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTitle(titleText: String) {
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        if let navButtons = self.navigationController?.navigationBar.items {
            if navButtons.count > 0 {
                navButtons[0].title = ""
            }
        }
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = titleLable
        titleLable.text = titleText
        titleLable.textColor = UIColor.white
        titleLable.font = titleLable.font.withSize(CGFloat(24))
    }
    
    func newBeaconMeasuraments(beacon: CLBeacon) -> BeaconMeasuraments {
        var beaconMeasuraments = BeaconMeasuraments()
        beaconMeasuraments.key = keyForBeacon(beacon: beacon)
        beaconMeasuraments.major = beacon.major.stringValue
        beaconMeasuraments.minor = beacon.minor.stringValue
        beaconMeasuraments.accuracyMeasuraments.append(beacon.accuracy)
        return beaconMeasuraments
    }
}

struct BeaconMeasuraments {
    var key: String = ""
    var minor: String = ""
    var major: String = ""
    var accuracyMeasuraments = [Double]()
    var avgDistance: Double = 0.0
}
