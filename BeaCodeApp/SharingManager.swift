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
    var selectedEvent: Event?
    var selectedExhibit: Exhibit?
    
    var selectedCategories: [String] = [String]()
    var selectedExhibitPhotoIndex = 0
    
    static let sharedInstance = SharingManager()
}
