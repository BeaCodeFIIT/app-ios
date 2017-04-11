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
        
        setTitle(titleText: SharingManager.sharedInstance.selectedEvent?.name)
        numberOfRowsInSection = (SharingManager.sharedInstance.selectedEvent?.categories?.count)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
            eventDetailTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section >= 2 {
            tableView.deselectRow(at: indexPath, animated: true)
            var exhibits = SharingManager.sharedInstance.selectedEvent?.exhibits?.filter { $0.category ==  SharingManager.sharedInstance.selectedEvent?.categories![indexPath.section - 2].name }
            SharingManager.sharedInstance.selectedExhibit = exhibits?[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        
        if section >= 2 && section <= (SharingManager.sharedInstance.selectedEvent?.categories?.count)! + 2 {
            button = UIButton(frame: CGRect(x: 30, y: 0, width: tableView.bounds.size.width-30, height: 30))
            button.setTitle(SharingManager.sharedInstance.selectedEvent?.categories?[section-2].name, for: .normal)
            
            let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            if (SharingManager.sharedInstance.selectedEvent?.categories?[section-2].hidden)! {
                iconView.image = #imageLiteral(resourceName: "right_arrrow")
            } else {
                iconView.image = #imageLiteral(resourceName: "down_arrow")
            }
            iconView.backgroundColor = UIColor.white
            headerView.addSubview(iconView)
        } else if section == 0 {
            button.setTitle("ABOUT", for: .normal)
        } else if section == 1 {
            button.setTitle("PHOTOS", for: .normal)
        }
        
        button.tag = section
        button.addTarget(self, action: #selector(headerButtonTap), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.titleEdgeInsets.left = 10
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        headerView.tintColor = UIColor.black
        
        headerView.addSubview(button)
        return headerView
    }
    
    func headerButtonTap(_ sender: UIButton) {
        
        sender.superview?
            .subviews
            .flatMap{$0 as? UIImageView}
            .forEach {view in

                var selectedCategory = SharingManager.sharedInstance.selectedEvent?.categories?.filter {
                    let buttons = view.superview?.subviews.flatMap{$0 as? UIButton}
                    let button = buttons?[0]
                    return $0.name == button?.titleLabel?.text
                }[0]
                
                if view.image == #imageLiteral(resourceName: "right_arrrow") {
                    
                    for (index, category) in (SharingManager.sharedInstance.selectedEvent?.categories)!.enumerated() {
                        if category.name == selectedCategory?.name {
                            SharingManager.sharedInstance.selectedEvent?.categories?[index].hidden = false
                            Logger.info(message: "Section \(String(describing: SharingManager.sharedInstance.selectedEvent?.categories?[index].name)) is now shown.")
                        }
                    }
                    
                    UIView.transition(with: view,
                                      duration: 0.25,
                                      options: .transitionCrossDissolve,
                                      animations: { view.image = #imageLiteral(resourceName: "down_arrow")},
                                      completion: nil)
                    
                    UIView.transition(with: eventDetailTable,
                                      duration: 0.25,
                                      options: .transitionCrossDissolve,
                                      animations: {self.eventDetailTable.reloadData()},
                                      completion: nil)
                    
                } else {
                    
                    
                    for (index, category) in (SharingManager.sharedInstance.selectedEvent?.categories)!.enumerated() {
                        if category.name == selectedCategory?.name {
                            SharingManager.sharedInstance.selectedEvent?.categories?[index].hidden = true
                            Logger.info(message: "Section \(String(describing: SharingManager.sharedInstance.selectedEvent?.categories?[index].name)) is now hidden.")
                        }
                    }
                    
                    UIView.transition(with: view,
                                      duration: 0.25,
                                      options: .transitionCrossDissolve,
                                      animations: { view.image = #imageLiteral(resourceName: "right_arrrow")},
                                      completion: nil)
                    
                    UIView.transition(with: eventDetailTable,
                                      duration: 0.25,
                                      options: .transitionCrossDissolve,
                                      animations: {self.eventDetailTable.reloadData()},
                                      completion: nil)

                }
            }
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

}
