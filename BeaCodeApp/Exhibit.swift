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

    init(title: String, description: String, thumbnail: UIImage) {
        self.title = title
        self.descrition = description
        self.photo = thumbnail
    }
}
