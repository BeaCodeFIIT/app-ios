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

    func convert(input: EventDto) throws -> Event? {
        
        guard let title = input.name else {
            return nil
        }
        
        guard let description = input.description else {
            return nil
        }
        
        return Event(
            title: title,
            description: description,
            date: (input.start?.toDateTime())!,
            thumbnail: UIImage(),
            organizer: "Marecek",
            location: input.location!)
    }
}
