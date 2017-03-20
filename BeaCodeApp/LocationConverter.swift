//
//  LocationConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public class LocationConverter {
    //LocationDto -> Location
    
    static let shared = LocationConverter()
    
    func convert(input: LocationDto) -> Location? {
        
        var location = Location()
        location.id = input.id
        location.name = input.name
        location.latitude = input.latitude
        location.longitude = input.longitude
        
        return location
    }
}
