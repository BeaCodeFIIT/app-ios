//
//  Exhibit.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class Exhibit {
    var id: String?
    var name: String?
    var description: String?
    var start: Date?
    var end: Date?
    
    init(id: String, name: String, description: String, start: Date, end: Date) {
        self.id = id
        self.name = name
        self.description = description
        self.start = start
        self.end = end
    }
    
}
