//
//  ExhibitDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExhibitDto {
    var id: Int?
    var name: String?
    var description: String?
    var start: String?
    var end: String?
    var images = [ImageDto]()
    var beacons = [BeaconDto]()
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.description = json["description"].string
        self.start = json["start"].string
        self.end = json["end"].string
        
        for image in json["images"] {
            images.append(ImageDto(json: image.1))
        }
        
        for beacon in json["beacons"] {
            beacons.append(BeaconDto(json: beacon.1))
        }
    }
    
}
