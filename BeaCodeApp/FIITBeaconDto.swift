//
//  FIITBeaconDto.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import SwiftyJSON

struct FIITBeaconDto {
    
    var id: Int?
    var uuid: String?
    var major: Double?
    var minor: Double?
    var coorX: Double?
    var coorY: Double?
    
    public init(json: JSON) {
        id = json["id"].int
        uuid = json["UUID"].string
        major = json["major"].double
        minor = json["minor"].double
        coorX = json["coorX"].double
        coorY = json["coorY"].double
    }
}
