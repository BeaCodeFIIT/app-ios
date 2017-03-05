//
//  SharingManager.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 02/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class SharingManager {
    var selectedEvent: Event = Event()
    var selectedCategories: [String] = [String]()
    
    func getSelectedExhibit() -> Exhibit {
        return selectedEvent.exhibits[selectedEvent.selectedExhibit]
    }
    
    func setSelectedExhibit(exhibit: Exhibit) {
        selectedEvent.selectedExhibit = exhibit.position
    }
    
    var selectedExhibitPhotoIndex = 0
    
    var lastCategory = ""
    var lastIndexInCategory = 0
    
    static let sharedInstance = SharingManager()
}
