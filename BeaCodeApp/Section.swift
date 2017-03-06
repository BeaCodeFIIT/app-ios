//
//  Section.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 05/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

class Section {
    var name: String!
    var headerRow: Int!
    var items: Array<Exhibit>!
    var collapsed: Bool!
    
    init(name: String, items: Array<Exhibit>, collapsed: Bool) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
    
}
