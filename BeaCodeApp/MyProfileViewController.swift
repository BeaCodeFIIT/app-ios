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

class MyProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addTagButton: UIButton!
    
    @IBAction func addTag(_ sender: Any) {
        tagView.addTag("new tag")
        tagView.reloadInputViews()
    }
    
    @IBOutlet weak var tagView: TagListView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleText: "MY PROFILE")
        
        tagView.textFont = UIFont.systemFont(ofSize: 20)
        tagView.alignment = .center

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
