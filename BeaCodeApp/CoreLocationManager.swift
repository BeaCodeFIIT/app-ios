//
//  CoreLocationManager.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 9.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit
import CoreLocation

//public protocol CoreLocationManagerProtocol {
//
//    func getNearestBeacon() -> CLBeacon
//    func setNearestBeacon(beacon: CLBeacon!)
//}

public class CoreLocationManager: NSObject, CLLocationManagerDelegate {//, CoreLocationManagerProtocol {

    let locationManager = CLLocationManager()
    var beaconsArray = [Beacon]()
    
//    static let sharedInstance = CoreLocationManager()
//    private var nearestBeacon = CLBeacon()

    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! as UUID, identifier: "Estimotes")

    public override init() {
        super.init()
    
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    func startMonitoring() {

        locationManager.startMonitoring(for: region)
        locationManager.startRangingBeacons(in: region)

    }

    func stopMonitoring() {

        locationManager.stopMonitoring(for: region)
        locationManager.stopRangingBeacons(in: region)
        
    }

    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {

        if state == .inside {

            manager.startRangingBeacons(in: self.region)
            manager.startUpdatingLocation()
            
        }
    }

    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //notification
    }

    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        manager.requestState(for: region)
    }

    public func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//        setNearestBeacon(beacon: beacons.first!)
        
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
                        
                        for existingBeacons in DataController.sharedInstance.availableBeacons {
                            
//                            if DataController.sharedInstance.availableBeacons.contains(where: (currBeacon as Beacon) {
//                                result in
//                                
//                                if result {
//                                    if existingBeacons == currBeacon && beacon.accuracy > 0.0 {
//                                        
//                                        existingBeacons.distanceFromUser = beacon.accuracy
//                                        
//                                    }
//                                        
//                                    else {
//                                        
//                                        DataController.sharedInstance.availableBeacons.append(currBeacon)
//                                        
//                                    }
//                                }
//                            })
                        }
                        
                    }
                    
                    if DataController.sharedInstance.availableBeacons.count > 2 {
                        
                        DataController.sharedInstance.calculateDistance()
                        
                    }
                }
            }
        }
        
        
        print("\(beacons.count) beacons detected")
    }

    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        if status == .authorizedAlways {
            
            print("Beacon location authorization always enabled")
            manager.startMonitoring(for: region)
            manager.requestState(for: region)
            
        } else {
            print("Beacon location authorization always disabled")
        }
    }

//    public func setNearestBeacon(beacon: CLBeacon!) {
//        nearestBeacon = beacon
//    }
//
//    public func getNearestBeacon() -> CLBeacon {
//        return nearestBeacon
//    }
}
