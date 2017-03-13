//
//  Event.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

struct Event {
    var id: Int?
    var name: String?
    var start: Date?
    var end: Date?
    var description: String?
    var location: Location?
    var categories: Array<Category>?
    
    init(id: Int, name: String, start: Date, end: Date, description: String, location: Location, categories: Array<Category>) {
        self.id = id
        self.name = name
        self.start = start
        self.end = end
        self.description = description
        self.location = location
        self.categories = categories
    }
}
