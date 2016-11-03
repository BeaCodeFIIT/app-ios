//
//  Event.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var title: String
    var description: String
    var thumbnail: UIImage
    var date: Date
    var organizer: String
    var location: String
    
    var photos = [UIImage]()
    var exhibits = [Exhibit]()
    
    
    init(title: String, description: String, date: Date, thumbnail: UIImage, organizer: String, location: String) {
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.date = date
        self.organizer = organizer
        self.location = location
    }
    
    init(title: String, description: String, date: Date, thumbnail: UIImage, organizer: String, location: String, photos: [UIImage]) {
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.date = date
        self.organizer = organizer
        self.location = location
    }
}
