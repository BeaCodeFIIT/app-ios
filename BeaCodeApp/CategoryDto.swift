//
//  CategoryDto.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CategoryDto {
    
    var id: Int?
    var name: String?
    
    public init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
    }
}
