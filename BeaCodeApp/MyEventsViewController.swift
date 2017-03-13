//
//  MyEventsViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class MyEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var eventsTable: UITableView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleText: "MY EVENTS")
        
        //Beacon test call
        print("Testing core location")
        let clmanager = CoreLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        //API TEST CALL
        var serviceCall = ServiceCall()
        serviceCall.requestMethod = .post
        serviceCall.requestParams = nil
        serviceCall.requestUrl = "/app/events"
        
        events.removeAll()
        
        NetworkServiceManager.sharedInstance.makeRequest(serviceCall: serviceCall, completition: { result in
        
            if result != nil{
                for event in (result?["data"])! {
                    let eventDto = EventDto(json: event.1)
                    self.events.append(EventConverter.shared.convert(input: eventDto)!)
                }
                self.eventsTable.reloadData()
                
                PKHUD.sharedHUD.hide()
            } else {
                PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "Error", subtitle: "Internet or server error")
                PKHUD.sharedHUD.hide(afterDelay: 1.0)
            }
        })
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
        
        var serviceCall = ServiceCall()
        serviceCall.requestMethod = .post
        serviceCall.requestParams = nil
        serviceCall.requestUrl = "/app/events/\(events[indexPath.row].id!)/exhibits"
        
        NetworkServiceManager.sharedInstance.makeRequest(serviceCall: serviceCall, completition: { result in
            
            if result != nil{
                for event in (result?["data"])! {
                    let eventDto = EventDto(json: event.1)
                    self.events.append(EventConverter.shared.convert(input: eventDto)!)
                }
                self.eventsTable.reloadData()
                
                PKHUD.sharedHUD.hide()
            } else {
                PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "Error", subtitle: "Internet or server error")
                PKHUD.sharedHUD.hide(afterDelay: 1.0)
            }
        })
        
        self.performSegue(withIdentifier: "detail_segue", sender: self)
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
