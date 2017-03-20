//
//  CategorizedExhibits.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 05/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

struct CategorizedExhibits {
    var categories = [String : Array<Exhibit>]()
    
    func getExhibits(category: String) -> Array<Exhibit> {
        return categories[category]!
    }
    
    var exhibits = Array<Exhibit>()
}
