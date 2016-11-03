
//
//  SearchViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchTable: UITableView!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide keyboard on tap
        self.hideKeyboardWhenTappedAround()
        
        //delete empty cells
        self.searchTable.tableFooterView = UIView()
        
        //resize cells based on content
        self.searchTable.estimatedRowHeight = 100
        self.searchTable.rowHeight = UITableViewAutomaticDimension
        
        events = mockEvents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchTable.dequeueReusableCell(withIdentifier: "SearchItemTableViewCell_ID", for: indexPath) as! SearchItemTableViewCell
        cell.searchItemLabel.text = events[indexPath.row].title
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
