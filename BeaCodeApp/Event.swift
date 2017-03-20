//
//  Event.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

struct Event {
    var id: Int?
    var name: String?
    var start: Date?
    var end: Date?
    var description: String?
    var location: Location?
    var images: Array<Image>?
    var categories: Array<Category>?
    var beacons: Array<Beacon>?
    var exhibits: Array<Exhibit>?
    
    init() {}
    
    init(id: Int, name: String, start: Date, end: Date, description: String, location: Location, images: Array<Image>, categories: Array<Category>, beacons: Array<Beacon>, exhibits: Array<Exhibit>) {
        self.id = id
        self.name = name
        self.start = start
        self.end = end
        self.description = description
        self.location = location
        self.images = images
        self.categories = categories
        self.beacons = beacons
        self.exhibits = exhibits
    }
}
