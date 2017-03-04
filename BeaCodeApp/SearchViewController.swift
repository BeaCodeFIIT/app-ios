
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
    @IBOutlet weak var searchBar: UITextField!
    
    var events = [Event]()
    var allEvents = [Event]()
    
    @IBAction func searchChange(_ sender: Any) {
        events = [Event]()
        for event in allEvents {
            if event.title.lowercased().hasPrefix(searchBar.text!.lowercased()) {
                events.append(event)
            }
        }
        searchTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide keyboard on tap
        self.hideKeyboardWhenTappedAround()
        
        searchBar.delegate = self
        
        //delete empty cells
        self.searchTable.tableFooterView = UIView()
        
        //resize cells based on content
        self.searchTable.estimatedRowHeight = 100
        self.searchTable.rowHeight = UITableViewAutomaticDimension
        
        allEvents = mockEvents()
        events.append(contentsOf: allEvents)
        
        setTitle(titleText: "SEARCH")
        addSearchIcon(searchBar: searchBar)
    }
    
    func addSearchIcon(searchBar: UITextField) {
        let imageView = UIImageView();
        let image = UIImage(named: "ic_search_36pt")
        imageView.image = image;
        imageView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        searchBar.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        searchBar.leftView = leftView;
        searchBar.leftViewMode = UITextFieldViewMode.always
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SharingManager.sharedInstance.selectedEvent = events[indexPath.row]
        print(SharingManager.sharedInstance.selectedEvent.title)
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

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
