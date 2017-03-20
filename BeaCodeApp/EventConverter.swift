//
//  EventConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 07/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit
import Foundation

public class EventConverter {
    //EventDto -> Event
    
    static let shared = EventConverter()

    func convert(input: EventDto) -> Event? {
        
        var event = Event()
        event.id = input.id
        event.name = input.name
        event.start = input.start?.toDateTime()
        event.end = input.end?.toDateTime()
        event.location = LocationConverter.shared.convert(input: input.location!)
        event.description = input.description
        
        for imageDto in input.images {
            event.images?.append(ImageConverter.shared.convert(input: imageDto)!)
        }
        
        for categoryDto in input.categories {
            event.categories?.append(CategoryConverter.shared.convert(input: categoryDto)!)
        }
        
        for beaconDto in input.beacons {
            event.beacons?.append(BeaconConverter.shared.convert(input: beaconDto)!)
        }
        
        return event
    }
}
