//
//  ExhibitDetailViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 07/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

class ExhibitDetailViewController: UIViewController {
    @IBOutlet weak var exhibitPhoto: UIImageView!
    @IBOutlet weak var exhibitDescription: UILabel!
    @IBOutlet weak var exhibitAddButton: UIBarButtonItem!
    
    @IBAction func exhibitAddButtonTapped(_ sender: Any) {
        if SharingManager.sharedInstance.selectedEvent.selectedExhibit.isSelected {
            exhibitAddButton.title = "Add"
            SharingManager.sharedInstance.selectedEvent.selectedExhibit.isSelected = false
        } else {
            exhibitAddButton.title = "Remove"
            SharingManager.sharedInstance.selectedEvent.selectedExhibit.isSelected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exhibitPhoto.image = SharingManager.sharedInstance.selectedEvent.selectedExhibit.photo
        exhibitDescription.text = SharingManager.sharedInstance.selectedEvent.selectedExhibit.descrition
        setTitle(titleText: SharingManager.sharedInstance.selectedEvent.selectedExhibit.title)
        
        exhibitAddButton.title = SharingManager.sharedInstance.selectedEvent.selectedExhibit.isSelected ? "Remove" : "Add"
    }
    
    func buttonAction() {}
    
    override func viewDidLayoutSubviews() {
        exhibitDescription.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
