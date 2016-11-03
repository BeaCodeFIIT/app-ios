//
//  EventDetailViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventDetailTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delete empty cells
        self.eventDetailTable.tableFooterView = UIView()
        
        //resize cells based on content
        self.eventDetailTable.estimatedRowHeight = 100
        self.eventDetailTable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
