//
//  Log.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 19/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

class Logger {
    static let logActive = true
    
    static func info(message: String) {
        if logActive {
            print("INFO: \(message)")
        }
    }
    
    static func error(message: String) {
        if logActive {
            print("INFO: \(message)")
        }
    }
}
