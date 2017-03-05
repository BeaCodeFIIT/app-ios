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
        switch section {
        case 2:
            return numberOfRowsInSection
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
//            let exhibits = SharingManager.sharedInstance.selectedEvent.categorizedExhibits
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ExhibitCell_ID", for: indexPath) as! ExhibitTableViewCell
//            cell.hideExhibitFeatures()
//            cell.categoryLabel.text = SharingManager.sharedInstance.selectedEvent.sections[indexPath.row].name
            
            let sectionCell = Bundle.main.loadNibNamed("SectionCell", owner: self, options: nil)?.first as! SectionCell
            sectionCell.titleButton.setTitle(SharingManager.sharedInstance.selectedEvent.sections[indexPath.row].name, for: .normal)
            sectionCell.exhibits = SharingManager.sharedInstance.selectedEvent.sections[indexPath.row].items
            sectionCell.titleButton.tag = indexPath.row
            sectionCell.titleButton.addTarget(self, action: #selector(addExhibit(_:)), for: .touchUpInside)
            return sectionCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventNavigationStarterTableViewCell_ID", for: indexPath)
            return cell
        }
    }
    
    func addExhibit(_ sender: UIButton) {
        print(sender.tag)
        let exhibits = SharingManager.sharedInstance.selectedEvent.sections[sender.tag].items
        
        let indexPath = IndexPath(row: 0, section: 2)
        eventDetailTable.beginUpdates()
        eventDetailTable.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        numberOfRowsInSection += 1
        eventDetailTable.endUpdates()

    }
    
    func imageTapped() {
        let tappedPhoto = SharingManager.sharedInstance.selectedEvent.photos[SharingManager.sharedInstance.selectedExhibitPhotoIndex]
        let imageInfo      = GSImageInfo(image: tappedPhoto, imageMode: .aspectFit  , imageHD: nil)
        let transitionInfo = GSTransitionInfo(fromView: self.view)
        let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        present(imageViewer, animated: true, completion: nil)
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
