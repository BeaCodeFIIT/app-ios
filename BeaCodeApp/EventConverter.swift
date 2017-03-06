//
//  EventConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 07/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit
import Foundation

public  class EventConverter {
        //EventDto -> Event
    
    static let shared = EventConverter()

    func convert(input: EventDto) -> Event? {
        
        var event = Event()
        event.id = input.id
        event.title = input.name
        event.date = input.start
        event.description = input.description
        event.categories = input.categories
        
        return event
    }
}
