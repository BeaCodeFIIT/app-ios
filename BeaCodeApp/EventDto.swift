//
//  EventDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 07/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import SwiftyJSON

struct EventDto {
    var id: Int?
    var name: String?
    var start: String?
    var end: String?
    var location: LocationDto?
    var description: String?
    var images = [ImageDto]()
    var categories = [CategoryDto]()
    var beacons = [BeaconDto]()
    var map: MapDto?
    
    public init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.start = json["start"].string
        self.end = json["end"].string
        self.location = LocationDto(json: json["location"])
        self.description = json["description"].string
        
        for image in json["images"] {
            images.append(ImageDto(json: image.1))
        }
        
        for category in json["categories"] {
            categories.append(CategoryDto(json: category.1))
        }
        
        for beacon in json["beacons"] {
            beacons.append(BeaconDto(json: beacon.1))
        }
        
        self.map = MapDto(json: json["map"])
    }
    
}
