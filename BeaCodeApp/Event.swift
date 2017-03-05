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
    var title: String
    var description: String
    var thumbnail: UIImage
    var date: Date
    var organizer: String
    var location: String
    var selectedExhibit: Int
    
    var photos = [UIImage]()
    var exhibits = [Exhibit]()
    var categorizedExhibits = CategorizedExhibits()
    
    init() {
        self.title = ""
        self.description = ""
        self.thumbnail = UIImage()
        self.date = Date()
        self.organizer = ""
        self.location = ""
        self.selectedExhibit = 0
    }
    
    init(title: String, description: String, date: Date, thumbnail: UIImage, organizer: String, location: String) {
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.date = date
        self.organizer = organizer
        self.location = location
        self.selectedExhibit = 0
    }
    
    init(title: String, description: String, date: Date, thumbnail: UIImage, organizer: String, location: String, photos: [UIImage]) {
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.date = date
        self.organizer = organizer
        self.location = location
        self.photos = photos
        self.selectedExhibit = 0
    }
    
    func downloadImage(imageUrl: String) -> UIImage {
        return UIImage()
    }
}
