//
//  EventImage.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

class Image {
    var id: String?
    var description: String?
    var filePath: String?
    
    init(id: String, description: String, filePath: String) {
        self.id = id
        self.description = description
        self.filePath = filePath
    }
}
