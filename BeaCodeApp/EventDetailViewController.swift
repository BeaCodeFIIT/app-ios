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
    var numberOfRowsInSection = 0
    
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
        numberOfRowsInSection = SharingManager.sharedInstance.selectedEvent.sections.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
            eventDetailTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedExhibit = SharingManager.sharedInstance.selectedEvent.sections[indexPath.section-2].items[indexPath.row]
        SharingManager.sharedInstance.selectedEvent.selectedExhibit =  selectedExhibit
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        button.tag = section
        button.addTarget(self, action: #selector(headerButtonTap), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.titleEdgeInsets.left = 10
        
        if section >= 2 && section <= SharingManager.sharedInstance.selectedEvent.sections.count + 2 {
            button.setTitle(SharingManager.sharedInstance.selectedEvent.sections[section-2].name, for: .normal)
        } else if section == 0 {
            button.setTitle("ABOUT", for: .normal)
        } else if section == 1 {
            button.setTitle("PHOTOS", for: .normal)
        }
        
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        headerView.tintColor = UIColor.black
        
        headerView.addSubview(button)
        return headerView
    }
    
    func headerButtonTap(_ sender: UIButton) {
        SharingManager.sharedInstance.selectedEvent.sections[sender.tag-2].collapsed = !SharingManager.sharedInstance.selectedEvent.sections[sender.tag-2].collapsed
        print("Header button with tag \(sender.tag) tapped. Value \(SharingManager.sharedInstance.selectedEvent.sections[sender.tag-2].collapsed)")
    }
    
    func setTitle(titleText: String?) {
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
        var dic = [String : Array<Exhibit>]()
        
        for exhibit in SharingManager.sharedInstance.selectedEvent.exhibits {
            if dic[exhibit.category] == nil {
                dic[exhibit.category] = Array<Exhibit>()
            }
            dic[exhibit.category]?.append(exhibit)
        }
        
        for category in dic {
            SharingManager.sharedInstance.selectedEvent.sections.append(Section(name: category.key, items: category.value, collapsed: false))
        }
    }

}
