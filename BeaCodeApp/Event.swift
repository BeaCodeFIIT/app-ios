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
    var id: String?
    var name: String?
    var start: Date?
    var end: Date?
    var description: String?
    var location: Location?
    var categories: Array<Category>?
    
}
