//
//  MyEventsViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class MyEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var eventsTable: UITableView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = mockEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.eventsTable.dequeueReusableCell(withIdentifier: "MyEventTableViewCell_ID", for: indexPath) as! MyEventTableViewCell
        cell = fillCell(cell: cell, event: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TODAY"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SharingManager.sharedInstance.selectedEvent = events[indexPath.row]
    }
    
    func fillCell(cell: MyEventTableViewCell, event: Event) -> MyEventTableViewCell {
        cell.eventImage.image = event.thumbnail
        cell.eventTitle.text = event.title
        cell.eventSubtitle.text = event.description
        return cell
    }
    
    func mockEvents() -> [Event] {
        let eventFactory = EventFactory()
        var events = [Event]()
        events.append(eventFactory.getEvent(set: mockSet.ces))
        events.append(eventFactory.getEvent(set: mockSet.flora))
        events.append(eventFactory.getEvent(set: mockSet.geneva))
        events.append(eventFactory.getEvent(set: mockSet.tutan))
        return events
    }
    
}
