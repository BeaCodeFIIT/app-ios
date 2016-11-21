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
    var title: String
    var photo: UIImage
    var descrition: String
    var isSelected: Bool
    var position: Int

    
    init() {
        self.title = ""
        self.descrition = ""
        self.photo = UIImage()
        self.isSelected = false
        self.position = 0
    }
    
    init(title: String, description: String, thumbnail: UIImage, position: Int) {
        self.title = title
        self.descrition = description
        self.photo = thumbnail
        self.isSelected = false
        self.position = position
    }
}
