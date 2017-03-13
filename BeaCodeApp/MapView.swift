//
//  MapView.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 13/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import Macaw

class MapView: MacawView {
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let svg = try SVGParser.parse(path: "floor3")
            super.init(node: svg, coder: aDecoder)
        } catch _ {
            print("SVG file not found.")
            let text = Text(text: "SVG file not found.", place: .move(dx: 145, dy: 100))
            super.init(node: text, coder: aDecoder)
        }
    }
}
