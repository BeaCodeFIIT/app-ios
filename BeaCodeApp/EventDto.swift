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
    var location: String?
    var description: String?
    var categories = [Category]()
    
    public init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.start = json["start"].string
        self.end = json["end"].string
        self.location = json["location"].string
        self.description = json["description"].string
        
        for category in json["categories"] {
            categories.append(Category(json: category.1))
        }
    }
}
