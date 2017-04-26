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
        let group = Group(contents: [])
        
        group.contents.append(Macaw.Image(src: "defaultmap.png", w: 1199, place: .move(dx: 0, dy: 0)))
        
        if let beacons = SharingManager.sharedInstance.selectedEvent?.beacons {
            for beacon in beacons {
                print("processing beacon n. \(beacon.id ?? 0)")
                if beacon.coorX != nil && beacon.coorY != nil && beacon.id! < 5 {
                    
                    let image = Macaw.Image(src: "pin_blue.png", w: 30, place: .move(dx: beacon.coorX!, dy: beacon.coorY!-15))

                    image.onTap { event in
                        if image.src == "pin_blue.png" {
                            image.src = "pin_red.png"
                        } else {
                            image.src = "pin_blue.png"
                        }
                    }
                    
                    image.onTap { event in
                        print("Beacon minor: \(beacon.id!) tapped")
                        var topVc = UIApplication.shared.keyWindow?.rootViewController
                        while (topVc!.presentedViewController) != nil {
                            topVc = topVc!.presentedViewController
                        }
                        
                        SharingManager.sharedInstance.selectedExhibit = SharingManager.sharedInstance.selectedEvent?.exhibits?[beacon.id!-1];
                        NotificationCenter.default.post(Notification(name: Notification.Name.init(rawValue: "showDetail"), object: nil, userInfo: nil))
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
