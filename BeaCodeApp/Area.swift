//
//  Area.swift
//  IndoorNav
//
//  Created by Peter Augustín on 09.04.16.
//  Copyright © 2016 Peter Augustin. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage
import CoreData

struct Area {

    var beacons : [Beacon]?
    var rooms : [Room]?
    var mapImage : UIImage?
    var areaName : String?
    var areaId : Int?
    
    func getRoomsById(mapId : Int, completition: (_ responseCode : ResponseStatusCode,_ data: AnyObject) -> Void) {
        
       
        
    }
    
    func getBeaconsById(mapId : Int, completition: (_ responseCode : ResponseStatusCode,_ data: AnyObject) -> Void) {
        
        
    }
    
    func downloadImage(urlString : String, completition: (_ responseCode : ResponseStatusCode,_ data: Image) -> Void) {
        
        
    }
}
