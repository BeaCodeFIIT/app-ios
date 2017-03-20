//
//  EventImage.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

struct Image {
    var id: Int?
    var description: String?
    var filePath: String?
    var image: UIImage?
    
    init() {}
    
    init(id: Int, description: String, filePath: String, image: UIImage) {
        self.id = id
        self.description = description
        self.filePath = filePath
        self.image = image
    }
}
