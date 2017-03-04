//
//  EventDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 07/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import ObjectMapper

struct EventDto: Mappable {
    var id: Int?
    var name: String?
    var start: String?
    var end: String?
    var location: String?
    var description: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id     <- map["id"]
        name  <- map["name"]
        start  <- map["start"]
        end  <- map["end"]
        location  <- map["location"]
        description  <- map["description"]
    }
}
