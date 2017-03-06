//
//  EventDetailViewController+TableView.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import GSImageViewerController

extension EventDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lastExhibitSection = SharingManager.sharedInstance.selectedEvent.sections.count + 2 //Two sections are before the exhibits
        switch section {
        case 2..<lastExhibitSection:
            return SharingManager.sharedInstance.selectedEvent.sections[section-2].items.count
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
        return 3 + SharingManager.sharedInstance.selectedEvent.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastExhibitSection = SharingManager.sharedInstance.selectedEvent.sections.count + 2 //Two sections are before the exhibits
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
        case 2..<lastExhibitSection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExhibitCell_ID", for: indexPath) as! ExhibitTableViewCell
            let actSectionIndex = indexPath.section - 2
            let actSection = SharingManager.sharedInstance.selectedEvent.sections[actSectionIndex]
            print(actSection.items.count)
            let actExhibit = actSection.items[indexPath.row]
            
            cell.exhibitPhoto.image = actExhibit.photo
            cell.exhibitTitle.text = actExhibit.title
            cell.exhibitDescription.text = actExhibit.descrition
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventNavigationStarterTableViewCell_ID", for: indexPath)
            return cell
        }
    }
    
    func imageTapped() {
        let tappedPhoto = SharingManager.sharedInstance.selectedEvent.photos[SharingManager.sharedInstance.selectedExhibitPhotoIndex]
        let imageInfo      = GSImageInfo(image: tappedPhoto, imageMode: .aspectFit  , imageHD: nil)
        let transitionInfo = GSTransitionInfo(fromView: self.view)
        let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        present(imageViewer, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let lastExhibitSection = SharingManager.sharedInstance.selectedEvent.sections.count + 2 //Two sections are before the exhibits
        switch section {
        case 0:
            return "ABOUT"
        case 1:
            if SharingManager.sharedInstance.selectedEvent.photos.isEmpty {return String()}
            return "PHOTOS"
        case 2..<lastExhibitSection:
            if SharingManager.sharedInstance.selectedEvent.exhibits.isEmpty {return String()}
            return SharingManager.sharedInstance.selectedEvent.sections[section-2].name
        default:
            return String()
        }
    }
}
