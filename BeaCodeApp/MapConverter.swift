//
//  MapConverter.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public class MapConverter {
    //MapDto -> Map
    
    static let shared = MapConverter()
    
    func convert(input: MapDto) -> Map? {
        
        var map = Map()
        map.id = input.id
        map.description = input.description
        map.filePath = input.filePath
        
        return map
    }
}
