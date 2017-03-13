//
//  Beacon.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

class Beacon {
    var id: String?
    var UUID: String?
    var major: String?
    var minor: String?
    var coorX: String?
    var coorY: String?
    
    init(id: String, UUID: String, major: String, minor: String, coorX: String, coorY: String) {
        self.id = id
        self.UUID = UUID
        self.major = major
        self.minor = minor
        self.coorX = coorX
        self.coorY = coorY
    }
}
