//
//  BeaconDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import SwiftyJSON

class BeaconDto {
    var id: Int?
    var UUID: String?
    var major: String?
    var minor: String?
    var coorX: String?
    var coorY: String?
    var exhibitId: Int?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.UUID = json["UUID"].string
        self.major = json["major"].string
        self.minor = json["mino"].string
        self.coorX = json["coorX"].string
        self.coorY = json["coorY"].string
        self.exhibitId = json["exhibitId"].int
    }
    
}
