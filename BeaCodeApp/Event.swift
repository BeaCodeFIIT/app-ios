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
    var id: Int!
    var title: String!
    var description: String!
    var thumbnail: UIImage!
    var date: Date!
    var organizer: String!
    var location: String!
    var selectedExhibit: Exhibit!
    
    var photos = [UIImage]()
    var exhibits = [Exhibit]()
    var categorizedExhibits = CategorizedExhibits()
    var sections = Array<Section>()
    
    
    func getExpandedSectionsCount() -> Int {
        var expanded = 0
        for section in sections {
            if !section.collapsed {
                expanded += 1
            }
        }
        return expanded
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.thumbnail = UIImage()
        self.date = Date()
        self.organizer = ""
        self.location = ""
    }
    
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
        self.photos = photos
    }
    
    func downloadImage(imageUrl: String) -> UIImage {
        return UIImage()
    }
}
