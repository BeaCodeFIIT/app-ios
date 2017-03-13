//
//  LocationDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocationDto {
    var id: Int?
    var name: String?
    var latitude: String?
    var longitude: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.latitude = json["latitude"].string
        self.longitude = json["longitude"].string
    }
}
