//
//  EventDetailViewController+TableView.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit

extension EventDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return SharingManager.sharedInstance.selectedEvent.exhibits.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 115
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
}

extension EventDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
        
    }
    
//    func getUniqueDates(dates: [Date]) {
//        
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell_ID", for: indexPath) as! EventDetailInfoTableViewCell
            let event = SharingManager.sharedInstance.selectedEvent
            cell.eventDescription.text = event.description
            cell.eventImage.image = event.thumbnail
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventPhotoSliderTableViewCell_ID", for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExhibitCell_ID", for: indexPath) as! ExhibitTableViewCell
            if SharingManager.sharedInstance.selectedEvent.exhibits.isEmpty {return cell}
            let exhibit = SharingManager.sharedInstance.selectedEvent.exhibits[indexPath.row]
            cell.exhibitTitle.text = exhibit.title
            cell.exhibitDescription.text = exhibit.descrition
            cell.exhibitPhoto.image = exhibit.photo
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventNavigationStarterTableViewCell_ID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ABOUT"
        case 1:
            if SharingManager.sharedInstance.selectedEvent.photos.isEmpty {return String()}
            return "PHOTOS"
        case 2:
            if SharingManager.sharedInstance.selectedEvent.exhibits.isEmpty {return String()}
            return "EXHIBITS"
        default:
            return String()
        }
    }
    
}
