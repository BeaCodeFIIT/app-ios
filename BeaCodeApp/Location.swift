//
//  Location.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

struct Location {
    var id: Int?
    var name: String?
    var latitude: String?
    var longitude: String?
    
    init() {}
    
    init(id: Int, name: String, latitude: String, longitude: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
