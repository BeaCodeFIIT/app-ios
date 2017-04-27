//
//  Beacon.swift
//  IndoorNav
//
//  Created by Peter Augustín on 24.03.16.
//  Copyright © 2016 Peter Augustin. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import CoreData

let CONST_DISTANCE = 99999

struct BeaconL {

    var id: Int?
    var name: String?
    var uuid: NSUUID?
    var positionX : Float?
    var positionY : Float?
    var majorValue: Int?
    var minorValue: Int?
    var distanceFromUser : Double?
    
    var beaconEdge : Int?
    
    var lastSeenBeacon: CLBeacon?
    
    var visited = false
    var feedback = false
    
}

func ==(item: BeaconL, beacon: CLBeacon) -> Bool {
    return ((beacon.proximityUUID.uuidString == item.uuid!.uuidString)
        && (Int(beacon.major) == Int(item.majorValue!))
        && (Int(beacon.minor) == Int(item.minorValue!)))
}
