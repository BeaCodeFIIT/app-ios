//
//  BeaconConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public class BeaconConverter {
    //BeaconDto -> Beacon
    
    static let shared = BeaconConverter()
    
    func convert(input: BeaconDto) -> Beacon? {
        
        var beacon = Beacon()
        beacon.id = input.id
        beacon.UUID = input.UUID
        beacon.major = input.major
        beacon.minor = input.minor
        beacon.coorX = input.coorX
        beacon.coorY = input.coorY
        beacon.exhibitId = input.exhibitId
        
        return beacon
    }
}
