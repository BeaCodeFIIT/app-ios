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
    var title: String = ""
    var photo: UIImage = UIImage()
    var descrition: String = ""
    var isSelected: Bool = false
    var position: Int = 0
    var category: String = ""
    
    init(title: String, description: String, thumbnail: UIImage, position: Int, category: String) {
        self.title = title
        self.descrition = description
        self.photo = thumbnail
        self.isSelected = false
        self.position = position
        self.category = category
    }
}
