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

struct Beacon {

    var name: String?
    var uuid: NSUUID?
    var positionX : Float?
    var positionY : Float?
    var majorValue: NSNumber?
    var minorValue: NSNumber?
    var distanceFromUser : Double?
    
    var beaconEdge : Int?
    
    var lastSeenBeacon: CLBeacon?
    
}

func ==(item: Beacon, beacon: CLBeacon) -> Bool {
    return ((beacon.proximityUUID.uuidString == item.uuid!.uuidString)
        && (Int(beacon.major) == Int(item.majorValue!))
        && (Int(beacon.minor) == Int(item.minorValue!)))
}
