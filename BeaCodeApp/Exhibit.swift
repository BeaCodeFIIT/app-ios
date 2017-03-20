//
//  Exhibit.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

struct Exhibit {
    var id: Int?
    var name: String?
    var description: String?
    var category: String?
    var start: Date?
    var end: Date?
    var images: Array<Image>?
    var beacons: Array<Beacon>?
    
    init() {}
    
    init(id: Int, name: String, description: String, category: String, start: Date, end: Date, images: Array<Image>, beacons: Array<Beacon>) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.start = start
        self.end = end
        self.images = images
        self.beacons = beacons
    }
    
}
