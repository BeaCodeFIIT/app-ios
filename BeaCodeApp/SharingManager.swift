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
    var selectedEvent: Event = Event(title: "",
                                     description: "",
                                     date: Date(),
                                     thumbnail: UIImage(),
                                     organizer: "",
                                     location: "")
    
    static let sharedInstance = SharingManager()
}
