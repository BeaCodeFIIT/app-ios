//
//  MyProfileViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import TagListView

class MyProfileViewController: UIViewController, TagListViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var tagView: TagListView!
    
    @IBAction func addTag(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add tag", message: "Enter a keyword and press \"Ok\"", preferredStyle:
            UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: textFieldHandler)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
            if let fields = alert.textFields {
                if let tag = fields[0].text {
                    self.tagView.addTag(tag)
                }
            }
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction) in }))
        
        self.present(alert, animated: true, completion: nil)
        tagView.reloadInputViews()
    }
    
    var isEditingState = false
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
//        print("Tag pressed: \(title), \(sender)")
        sender.removeTag(title)
    }
    
    func textFieldHandler(textField: UITextField!) {
        if (textField) != nil {
            textField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagView.delegate = self
        setTitle(titleText: "MY PROFILE")
        
        tagView.textFont = UIFont.systemFont(ofSize: 20)
        tagView.alignment = .left

        tagView.addTag("cars")
        tagView.addTag("technology")
        tagView.addTag("space")
        tagView.addTag("flight")
        tagView.addTag("science")
        tagView.addTag("nature")
        tagView.addTag("astronomy")
        tagView.addTag("histroy")
        tagView.addTag("blablabla")
    
        applyButtonBorder(button: addTagButton)
        
    }
    
    
    func applyButtonBorder(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1).cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
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
