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
