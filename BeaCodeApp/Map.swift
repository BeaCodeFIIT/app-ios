//
//  Map.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

struct Map {
    var id: Int?
    var description: String?
    var filePath: String?
    
    init() {}
    
    init(id: Int, description: String, filePath: String) {
        self.id = id
        self.description = description
        self.filePath = filePath
    }
    
}
