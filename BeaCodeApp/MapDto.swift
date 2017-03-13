//
//  MapDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import SwiftyJSON

class MapDto {
    var id: Int?
    var description: String?
    var filePath: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.description = json["description"].string
        self.filePath = json["pathWithFile"].string
    }
    
}
