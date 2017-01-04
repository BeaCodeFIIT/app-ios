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
        setTitle(titleText: "MY EVENTS")

        //MARK: - Call for all events
        var serviceCall = ServiceCall()
        serviceCall.requestMethod = .post
        serviceCall.requestParams = nil
        serviceCall.requestUrl = "/app/events"

        NetworkServiceManager.sharedInstance.makeRequest(serviceCall: serviceCall, completition: { result in
            print(result)
        })

        //MARK: - Call for logged user
        serviceCall.requestMethod = .get
        serviceCall.requestParams = nil
        serviceCall.requestUrl = "/api/app/logged-in-user"

        NetworkServiceManager.sharedInstance.makeRequest(serviceCall: serviceCall, completition: { result in
        print(result)
        })

        //Beacon test call
        print("Testing core location")
        let clmanager = CoreLocationManager()
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
    
    func setTitle(titleText: String) {
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        if let navButtons = self.navigationController?.navigationBar.items {
            if navButtons.count > 0 {
                navButtons[0].title = ""
            }
        }
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = titleLable
        titleLable.text = titleText
        titleLable.textColor = UIColor.white
        titleLable.font = titleLable.font.withSize(CGFloat(24))
    }
    
}
