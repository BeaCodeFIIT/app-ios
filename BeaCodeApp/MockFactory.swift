//
//  MockFactory.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

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
            
            var categories = Array<Category>()
            categories.append(Category(id: 1, name: "Notebooks"))
            categories.append(Category(id: 1, name: "TVs"))
            categories.append(Category(id: 1, name: "Drones"))
            
            var images = Array<Image>()
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "ces1")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "ces2")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "ces3")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "ces4")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "ces5")))
            
            var beacons = Array<Beacon>()
            do {
                if let file = Bundle.main.url(forResource: "beacons", withExtension: "json") {
                    print("LOADING BEACONS - FILE FOUND")
                    let data = try Data(contentsOf: file)
                    let json = JSON(data)
                    print(json)
                    
                    var beaconsDto = [BeaconDto]()
                    for beacon in json["data"] {
                        beaconsDto.append(BeaconDto(json: beacon.1))
                    }
                    
                    print("LOADING BEACONS - FILE FOUND - \(beaconsDto.count) beacons loaded")
                    
                    for beaconDto in beaconsDto {
                        beacons.append(BeaconConverter.shared.convert(input: beaconDto)!)
                    }
                } else {
                    print("LOADING BEACONS - No JSON file with beacons found")
                }
            } catch  {
                print(error.localizedDescription)
            }
            
            var event = Event(id: 1,
                              name: "Consumer Electronics Show 2016",
                              start: "2016-12-01 09:00:00".toDateTime(),
                              end: "2016-12-01 09:00:00".toDateTime(),
                              description: "CES is a global consumer electronics and consumer technology tradeshow that takes place every January in Las Vegas, Nevada.",
                              location: Location(id: 1, name: "Las Vegas, Nevada", latitude: "123", longitude: "123"),
                              images: images,
                              categories: categories,
                              beacons: beacons,
                              exhibits: Array<Exhibit>())
            
            var imagesExh1 = Array<Image>()
            imagesExh1.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "ces_ex0")))
            
            event.exhibits!.append(Exhibit(id: 1,
                                           name: "MacBook Pro",
                                           description: "Newest Macintosh laptop from Apple. New touch bar and touch ID, better screen and much more.",
                                           category: "Notebooks",
                                           start: "2016-12-01 09:00:00".toDateTime(),
                                           end: "2016-12-01 09:00:00".toDateTime(),
                                           images: imagesExh1,
                                           beacons: Array<Beacon>()))
            
            var imagesExh2 = Array<Image>()
            imagesExh2.append(Image(id: 2, description: "", filePath: "", image: #imageLiteral(resourceName: "ces_ex1")))
            
            event.exhibits!.append(Exhibit(id: 1,
                                           name: "Samsung 8K TV",
                                           description: "The South Korean tech maker put an exclusive first look at its new TVs event today at Consumer Electronics Show.",
                                           category: "TVs",
                                           start: "2016-12-01 09:00:00".toDateTime(),
                                           end: "2016-12-01 09:00:00".toDateTime(),
                                           images: imagesExh2,
                                           beacons: Array<Beacon>()))
            
            var imagesExh3 = Array<Image>()
            imagesExh3.append(Image(id: 3, description: "", filePath: "", image: #imageLiteral(resourceName: "ces_ex2")))
            
            event.exhibits!.append(Exhibit(id: 2,
                                           name: "DJI Phantom 4",
                                           description: "The sexiest drone that DJI ever designed, welcome to the era of VISION. DJI’s Phantom has been our favorite model of drone for the last few years, but this latest version doesn’t merely hold onto the mantle as the best unit you can buy. By adding computer vision and fully autonomous capabilities, the Phantom 4 has dramatically raised the bar on what is possible with a consumer caliber camera drone, both for complete amateurs who want to start flying and for professionals who are crafting complex and dangerous shots.",
                                           category: "Drones",
                                           start: "2016-12-01 09:00:00".toDateTime(),
                                           end: "2016-12-01 09:00:00".toDateTime(),
                                           images: imagesExh3,
                                           beacons: Array<Beacon>()))
            return event
        case .flora:
            
            var images = Array<Image>()
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "flora0")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "flora1")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "flora2")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "flora3")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "flora4")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "flora5")))
            
            let event = Event(id: 2,
                              name: "Flóra Bratislava 2016",
                              start: "2016-12-01 09:00:00".toDateTime(),
                              end: "2016-12-01 09:00:00".toDateTime(),
                              description: "Pozývame Vás na 36. ročník medzinárodného veľtrhu kvetín a záhradníctva.",
                              location: Location(id: 3, name: "Bratislava, Slovakia", latitude: "123", longitude: "123"),
                              images: images,
                              categories: Array<Category>(),
                              beacons: Array<Beacon>(),
                              exhibits: Array<Exhibit>())
            return event
        case .geneva:
            
            var categories = Array<Category>()
            categories.append(Category(id: 1, name: "Gasoline"))
            categories.append(Category(id: 1, name: "EV"))
            
            var images = Array<Image>()
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva0")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva1")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva2")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva3")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva4")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva5")))
            
            var event = Event(id: 3,
                              name: "Geneva Motor Show 2017",
                              start: "2016-12-01 09:00:00".toDateTime(),
                              end: "2016-12-01 09:00:00".toDateTime(),
                              description: "From the first car exhibition in Switzerland in 1905 to the international motor show of nowadays; the Geneva International Motor Show is one of the top five events worldwide not to be missed. An exciting adventure to discover.",
                              location: Location(id: 2, name: "Geneva, Switzerland", latitude: "123", longitude: "123"),
                              images: images,
                              categories: categories,
                              beacons: Array<Beacon>(),
                              exhibits: Array<Exhibit>())
            
            var imagesExh1 = Array<Image>()
            imagesExh1.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "geneva_ex0")))
            
            event.exhibits!.append(Exhibit(id: 1,
                                           name: "Tesla Model S",
                                           description: "Model S is designed from the ground up to be the safest, most exhilarating sedan on the road. With unparalleled performance delivered through Tesla's unique, all-electric powertrain, Model S accelerates from 0 to 60 mph in as little as 2.5 seconds. Model S comes with Autopilot capabilities designed to make your highway driving not only safer, but stress free.",
                                           category: "EV",
                                           start: "2016-12-01 09:00:00".toDateTime(),
                                           end: "2016-12-01 09:00:00".toDateTime(),
                                           images: imagesExh1,
                                           beacons: Array<Beacon>()))
            
            var imagesExh2 = Array<Image>()
            imagesExh2.append(Image(id: 1, description: "second", filePath: "", image: #imageLiteral(resourceName: "geneva_ex1")))
            
            event.exhibits!.append(Exhibit(id: 1,
                                           name: "Jaguar F-Pace",
                                           description: "The F-PACE takes the Jaguar DNA of legendary performance, handling and luxury, and adds practicality and space. F-PACE has the performance for every road.",
                                           category: "Gasoline",
                                           start: "2016-12-01 09:00:00".toDateTime(),
                                           end: "2016-12-01 09:00:00".toDateTime(),
                                           images: imagesExh2,
                                           beacons: Array<Beacon>()))

            var imagesExh3 = Array<Image>()
            imagesExh3.append(Image(id: 1, description: "Mazda 6", filePath: "", image: #imageLiteral(resourceName: "geneva_ex2")))
            
            event.exhibits!.append(Exhibit(id: 1,
                                           name: "Mazda 6",
                                           description: "It's easy to see why the Mazda 6 is one of our favourite family saloons. It looks great, drives brilliantly and won't cost the earth to run.",
                                           category: "Gasoline",
                                           start: "2016-12-01 09:00:00".toDateTime(),
                                           end: "2016-12-01 09:00:00".toDateTime(),
                                           images: imagesExh3,
                                           beacons: Array<Beacon>()))
            return event
        case .tutan:
            var images = Array<Image>()
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "tutan0")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "tutan1")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "tutan2")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "tutan3")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "tutan4")))
            images.append(Image(id: 1, description: "", filePath: "", image: #imageLiteral(resourceName: "tutan5")))
            
            let event = Event(id: 4,
                              name: "The treasures of Tutankhamun",
                              start: "2016-12-01 09:00:00".toDateTime(),
                              end: "2016-12-01 09:00:00".toDateTime(),
                              description: "Tutankhamun: His Tomb and His Treasures presents more than a thousand objects. Because they are museum-quality replicas of objects that are otherwise strongly guarded, the exhibition offers visitors the unique chance to explore a three-dimensional reconstruction of the pharaoh's actual tomb. Walk among the gold statues and other decorative items, just as Carter did nearly a century ago.",
                              location: Location(id: 4, name: "Bratislava, Slovakia", latitude: "123", longitude: "123"),
                              images: images,
                              categories: Array<Category>(),
                              beacons: Array<Beacon>(),
                              exhibits: Array<Exhibit>())
            return event
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

extension String {
    
    func toDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString : Date = dateFormatter.date(from: self)!
        return dateFromString
    }
    
}
