//
//  DataController.swift
//  IndoorNav
//
//  Created by Peter Augustín on 25.04.16.
//  Copyright © 2016 Peter Augustin. All rights reserved.
//

import UIKit

class DataController: NSObject {

    static let sharedInstance = DataController()
    var maps = [Area]()
    
    var currentLocation = Coordinate()
    var availableBeacons = [Beacon]()
    var availableArea : Area?
    
    var actualPosition = Coordinate()
    var goalPosition = Coordinate()

    override init() {

    }
    
    func calculateDistance() {
        
        availableBeacons = self.availableBeacons.sorted(by: { (element1, element2) -> Bool in
             if element1.distanceFromUser! > 0.0 && element2.distanceFromUser! > 0.0 {
                return element1.distanceFromUser! < element2.distanceFromUser!
            }
            
            return false
        })
        
        //PROCEED TRILATERATION
        var beaconLocation1 = [availableBeacons[0].positionX, availableBeacons[0].positionY]
        var beaconLocation2 = [availableBeacons[1].positionX, availableBeacons[1].positionY]
        var beaconLocation3 = [availableBeacons[2].positionX, availableBeacons[2].positionY]
        
        //All points in same line
        if beaconLocation1[1] == beaconLocation2[1] && beaconLocation1[1] == beaconLocation3[1] {
            
            let totalD = availableBeacons[0].distanceFromUser! + availableBeacons[1].distanceFromUser!
            
            var positionD = (availableBeacons[1].positionX! - availableBeacons[0].positionX!)
            
            if positionD < 0 {
                
                positionD = abs(positionD)
            
            }
            
            var x = Float(availableBeacons[0].distanceFromUser!/totalD) * positionD
            
            if availableBeacons[0].positionX! > availableBeacons[1].positionX! {
                
                x = availableBeacons[0].positionX! - x
                
            } else {
                
                x = availableBeacons[0].positionX! + x
                
            }
            
            
            let y = availableBeacons[0].positionY!
            
            if availableArea == nil {
                
                self.availableArea = determinateArea(beacon: availableBeacons[0])
                
                if GraphMapping.sharedInstance.mappedPositions.count == 0 {
                    
                    GraphMapping.sharedInstance.createMapPositions(availableBeacons: (DataController.sharedInstance.availableArea?.beacons)!)
                    
                }
                
            }
            
            let trilateratedCoordinates = NSMutableArray()
            trilateratedCoordinates.add(x)
            trilateratedCoordinates.add(y)
            
            setActualPositioning(trilateratedCoordinates: trilateratedCoordinates)
            
            //different positions of all points
        } else if beaconLocation1[0] == beaconLocation2[0] && beaconLocation1[0] == beaconLocation3[0] {
            
            let totalD = availableBeacons[0].distanceFromUser! + availableBeacons[1].distanceFromUser!
            
            var positionD = (availableBeacons[1].positionY! - availableBeacons[0].positionY!)
            
            if positionD < 0 {
                
                positionD = abs(positionD)
                
            }
            
            var y = Float(availableBeacons[0].distanceFromUser!/totalD) * positionD
            
            if availableBeacons[0].positionY! > availableBeacons[1].positionY! {
                
                y = availableBeacons[0].positionY! - y
                
            } else {
                
                y = availableBeacons[0].positionY! + y
                
            }
            
            
            let x = availableBeacons[0].positionX!
            
            if availableArea == nil {
                
                self.availableArea = determinateArea(beacon: availableBeacons[0])
                
                if GraphMapping.sharedInstance.mappedPositions.count == 0 {
                    
                    GraphMapping.sharedInstance.createMapPositions(availableBeacons: (DataController.sharedInstance.availableArea?.beacons)!)
                    
                }
                
            }
            
            let trilateratedCoordinates = NSMutableArray()
            trilateratedCoordinates.add(x)
            trilateratedCoordinates.add(y)
            
            setActualPositioning(trilateratedCoordinates: trilateratedCoordinates)
            
        } else if DataController.sharedInstance.availableBeacons.count > 2 {
            
            let ex = NSMutableArray()
            var temp = 0.0
            for i in 0..<beaconLocation1.count {
                let t1 = Double(beaconLocation2[i]!)
                let t2 = Double(beaconLocation1[i]!)
                let t = t1 - t2
                temp += (t*t)
            }
            
            for i in 0..<beaconLocation1.count {
                let t1 = Double(beaconLocation2[i]!)
                let t2 = Double(beaconLocation1[i]!)
                let exx = (t1-t2)/sqrt(temp)
                ex.add(exx)
            }
            
            let p3p1 = NSMutableArray()
            for i in 0..<beaconLocation3.count {
                let t1 = Double(beaconLocation3[i]!)
                let t2 = Double(beaconLocation1[i]!)
                let t3 = t1 - t2
                p3p1.add(t3)
            }
            
            var ival = 0.0
            for i in 0..<ex.count {
                let t1 = (ex.object(at: i) as AnyObject).doubleValue
                let t2 = (p3p1.object(at: i) as AnyObject).doubleValue
                ival += (t1!*t2!)
            }
            
            let ey = NSMutableArray()
            var p3p1i = 0.0
            for i in 0..<beaconLocation3.count {
                let t1 = Double(beaconLocation3[i]!)
                let t2 = Double(beaconLocation1[i]!)
                let t3 = ((ex.object(at: i) as AnyObject).doubleValue) * ival
                let t = t1 - t2 - t3
                p3p1i += (t*t)
            }
            
            if beaconLocation1[1]! == beaconLocation2[1]! && beaconLocation1[1]! == beaconLocation3[1]! {
                ey.add(-0.5)
                ey.add(-0.5)
            } else {
                
                for i in 0..<beaconLocation3.count {
                    let t1 = Double(beaconLocation3[i]!)
                    let t2 = Double(beaconLocation1[i]!)
                    let t3 = ((ex.object(at: i) as AnyObject).doubleValue) * ival
                    let eyy = (t1-t2-t3)/sqrt(p3p1i)
                    ey.add(eyy)
                }
                
            }
            
            let d = sqrt(temp)
            var jval = 0.0
            
            for i in 0..<ey.count {
                let t1 = (ey[i] as AnyObject).doubleValue
                let t2 = (p3p1[i] as AnyObject).doubleValue
                jval += (t1!*t2!)
            }
            
            let xval = (pow(availableBeacons[0].distanceFromUser!, 2)-pow(availableBeacons[1].distanceFromUser!,2) + pow(d,2))/(2*d)
            let yval = ((pow(availableBeacons[0].distanceFromUser!, 2)-pow(availableBeacons[2].distanceFromUser!,2) + pow(ival,2) + pow(jval,2))/(2*jval)) - ((ival/jval)*xval)
            
            let trilateratedCoordinates = NSMutableArray()
            for i in 0..<beaconLocation1.count {
                let t1 = Double(beaconLocation1[i]!)
                let t2 = ((ex.object(at: i) as AnyObject).doubleValue) * xval
                let t3 = ((ey.object(at: i) as AnyObject).doubleValue) * yval
                let triptx = t1+t2+t3
                trilateratedCoordinates.add(triptx)
            }
            
            if availableArea == nil {
                
                self.availableArea = determinateArea(beacon: availableBeacons[0])
                
                if GraphMapping.sharedInstance.mappedPositions.count == 0 {
                    
                    GraphMapping.sharedInstance.createMapPositions(availableBeacons: (DataController.sharedInstance.availableArea?.beacons)!)
                    
                }
                
            }
            
            setActualPositioning(trilateratedCoordinates: trilateratedCoordinates)
            
        }
    }
    
    func setActualPositioning(trilateratedCoordinates : NSMutableArray) {

        actualPosition.positionX = (trilateratedCoordinates[0] as AnyObject).integerValue
        actualPosition.positionY = (trilateratedCoordinates[1] as AnyObject).integerValue
        
        //TODO: - Marek toto je observer, handluj si ho kde potrebujes, vrati ti aktualnu polohu ;) (x,y)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLocation"), object: actualPosition)
        
        print("PositionX : " + String(actualPosition.positionX!) + "\nPositionY : " + String(actualPosition.positionY!) + "\n\n")
    
    }
    
    func determinateArea(beacon : Beacon) -> Area? {
        
        for area in DataController.sharedInstance.maps {
            for availableBeacon in area.beacons! {
                if availableBeacon.name == beacon.name {
                    return area
                }
            }
        }
        
        return nil
    }
    
    func setArea(areas : [Area]) {
        
        self.maps = areas
        
    }

}
