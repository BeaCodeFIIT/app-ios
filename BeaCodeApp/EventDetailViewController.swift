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
        self.eventDetailTable.tableFooterView = UIView() //delete empty cells
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
