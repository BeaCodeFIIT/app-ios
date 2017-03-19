//
//  FIITBeaconConverter.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public  class FIITBeaconConverter {
    //EventDto -> Event
    
    static let shared = FIITBeaconConverter()
    
    func convert(input: FIITBeaconDto) -> FIITBeacon {
        return FIITBeacon(id: input.id, uuid: input.uuid, major: input.major, minor: input.minor, coorX: input.coorX, coorY: input.coorY)
    }
}
