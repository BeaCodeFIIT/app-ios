//
//  Beacon.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

struct Beacon {
    var id: Int?
    var UUID: String?
    var major: String?
    var minor: String?
    var coorX: Double?
    var coorY: Double?
    var exhibitId: Int?
    
    init() {}
    
    init(id: Int, UUID: String, major: String, minor: String, coorX: Double, coorY: Double, exhibitId: Int) {
        self.id = id
        self.UUID = UUID
        self.major = major
        self.minor = minor
        self.coorX = coorX
        self.coorY = coorY
        self.exhibitId = exhibitId
    }
}
