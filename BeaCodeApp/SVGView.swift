//
//  SVGView.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 03/04/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import UIKit
import Macaw

class SVGExampleView: MacawView {
    
    required init?(coder aDecoder: NSCoder) {
//        do {
//            try super.init(node: SVGParser.parse(path: "defaultmap"), coder: aDecoder)
//
//        } catch  {
//            print("File not found")
//            super.init(coder: aDecoder)
//        }
        
//        let rect = Rect(x: 100, y: 75, w: 175, h: 30).round(r: 5).fill(with: Color(val: 0xfcc07c))
//        let circle = Circle(cx: 100, cy: 100, r: 100).fill(with: Color.blue)
        let group = Group(contents: [])
        group.contents.append(Macaw.Image(src: "defaultmap.png", w: 750, place: .move(dx: 0, dy: 0)))
        
        if let beacons = SharingManager.sharedInstance.selectedEvent?.beacons {
            for beacon in beacons {
                print("processing beacon n. \(beacon.id ?? 0)")
                if beacon.coorX != nil && beacon.coorY != nil {
                    
                    let image = Macaw.Image(src: "pin_blue.png", w: 10, place: .move(dx: beacon.coorX! / 10, dy: beacon.coorY! / 10))

                    image.onTap { event in
                        if image.src == "pin_blue.png" {
                            image.src = "pin_red.png"
                        } else {
                            image.src = "pin_blue.png"
                        }
                    }
                    
                    image.onTap { event in
                        print("Beacon image id: \(beacon.id ?? -1) tapped")
                        var topVc = UIApplication.shared.keyWindow?.rootViewController
                        while (topVc!.presentedViewController) != nil {
                            topVc = topVc!.presentedViewController
                        }
                        
                        SharingManager.sharedInstance.selectedExhibit = SharingManager.sharedInstance.selectedEvent?.exhibits?[0];
                        
                        let vc = topVc!.storyboard!.instantiateViewController(withIdentifier: "ExhibitDetailViewControllerId")
                        topVc?.present(vc, animated: true, completion: nil)
                    }
                    
                    group.contents.append(image)
                    
                    print("adding pin")
                } else {
                    print("beacon n. \(beacon.id ?? 0) rejected")
                }
            }
        }
        
        super.init(node: group, coder: aDecoder)
    }
    
}