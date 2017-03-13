//
//  Category.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 06/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import SwiftyJSON

struct Category {
    
    var id: Int?
    var name: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
