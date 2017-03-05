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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(EventDetailViewController.imageTapped),
                                               name: NSNotification.Name(rawValue: "photoFromSliderTapped"),
                                               object: nil)
        
        setTitle(titleText: SharingManager.sharedInstance.selectedEvent.title)
        prepareExhibits()
        SharingManager.sharedInstance.lastIndexInCategory = 0
        SharingManager.sharedInstance.lastCategory = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
            eventDetailTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        SharingManager.sharedInstance.selectedEvent.selectedExhibit = indexPath.row
        SharingManager.sharedInstance.getSelectedExhibit().position = indexPath.row
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
    
    func prepareExhibits() {
//        let exhibits = SharingManager.sharedInstance.selectedEvent.categorizedExhibits
//        exhibits.categories.removeAll()
//
//        for exhibit in SharingManager.sharedInstance.selectedEvent.exhibits {
//            if exhibits.categories[exhibit.category] == nil {
//                exhibits.categories[exhibit.category] = Array<Exhibit>()
//            }
//            exhibits.categories[exhibit.category]?.append(exhibit)
//        }
        let exhibits = SharingManager.sharedInstance.selectedEvent.categorizedExhibits.exhibits
        for exhibit in SharingManager.sharedInstance.selectedEvent.exhibits {
            
        }
    }

}
