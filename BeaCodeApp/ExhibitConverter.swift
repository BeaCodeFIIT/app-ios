//
//  ExhibitConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public class ExhibitConverter {
    //ExhibitDto -> Exhibit
    
    static let shared = ExhibitConverter()
    
    func convert(input: ExhibitDto) -> Exhibit? {
        
        var exhibit = Exhibit()
        exhibit.id = input.id
        exhibit.name = input.name
        exhibit.description = input.description
        exhibit.start = input.start?.toDateTime()
        exhibit.end = input.end?.toDateTime()
        
        for imageDto in input.images {
            exhibit.images?.append(ImageConverter.shared.convert(input: imageDto)!)
        }
        
        for beaconDto in input.beacons {
            exhibit.beacons?.append(BeaconConverter.shared.convert(input: beaconDto)!)
        }
        
        return exhibit
    }
}
