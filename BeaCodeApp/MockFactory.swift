//
//  MockFactory.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

enum mockSet {
    case ces
    case flora
    case geneva
    case tutan
}

class EventFactory {
    
    func getEvent(set: mockSet) -> Event {
        switch set {
        case .ces:
            return Event(title: "Consumer Electronics Show 2016",
                         description: "CES is a global consumer electronics and consumer technology tradeshow that takes place every January in Las Vegas, Nevada.",
                         date: "2016-12-10 20:00:00".toDateTime(),
                         thumbnail: UIImage(named: "ces0")!,
                         organizer: "CES inc.",
                         location: "Las Vegas, Nevada",
                         photos: loadImages(prefix: "ces", count: 5))
        case .flora:
            return Event(title: "Flóra Bratislava 2016",
                         description: "Pozývame Vás na 36. ročník medzinárodného veľtrhu kvetín a záhradníctva.",
                         date: "2016-12-01 09:00:00".toDateTime(),
                         thumbnail: UIImage(named: "flora0")!,
                         organizer: "Kulla s.r.o.",
                         location: "Bratislava, Slovakia",
                         photos: loadImages(prefix: "flora", count: 5))
        case .geneva:
            return Event(title: "Geneva Motor Show 2017",
                         description: "From the first car exhibition in Switzerland in 1905 to the international motor show of nowadays; the Geneva International Motor Show is one of the top five events worldwide not to be missed. An exciting adventure to discover.",
                         date: "2017-02-18 19:00:00".toDateTime(),
                         thumbnail: UIImage(named: "geneva0")!,
                         organizer: "Comité Permanent du Salon International de l'Automobile à Genève",
                         location: "Geneva, Switzerland",
                         photos: loadImages(prefix: "geneva", count: 5))
        case .tutan:
            return Event(title: "The treasures of Tutankhamun",
                         description: "Tutankhamun: His Tomb and His Treasures presents more than a thousand objects. Because they are museum-quality replicas of objects that are otherwise strongly guarded, the exhibition offers visitors the unique chance to explore a three-dimensional reconstruction of the pharaoh's actual tomb. Walk among the gold statues and other decorative items, just as Carter did nearly a century ago.",
                         date: "2017-09-10 10:30:00".toDateTime(),
                         thumbnail: UIImage(named: "tutan0")!,
                         organizer: "Prague Museum",
                         location: "Prague, Czech Republic",
                         photos: loadImages(prefix: "tutan", count: 5))
        }
    }
    
    func loadImages(prefix: String, count: Int) -> [UIImage] {
        var images = [UIImage]()
        for index in 0...count {
            images.append(UIImage(named: "\(prefix)\(index)")!)
        }
        return images
    }
    
}

class ExhibitFactory {
    
    func getEvent(set: mockSet) {
        
    }
    
}


extension String {
    
    func toDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString : Date = dateFormatter.date(from: self)!
        return dateFromString
    }
    
}
