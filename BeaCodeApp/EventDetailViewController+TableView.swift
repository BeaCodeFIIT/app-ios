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
            let count = SharingManager.sharedInstance.selectedEvent.categorizedExhibits.categories.values.count +
                SharingManager.sharedInstance.selectedEvent.categorizedExhibits.categories.keys.count
            return count-1
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
            let exhibits = SharingManager.sharedInstance.selectedEvent.categorizedExhibits
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExhibitCell_ID", for: indexPath) as! ExhibitTableViewCell
                
            if exhibits.categories.isEmpty {
                return cell
            }
            
            var keys = Array(exhibits.categories.keys).sorted(by: >)
            
            if SharingManager.sharedInstance.lastCategory.isEmpty {
                SharingManager.sharedInstance.lastCategory = keys[0]
                SharingManager.sharedInstance.lastIndexInCategory = 0
                cell.hideExhibitFeatures()
                cell.categoryLabel.text = SharingManager.sharedInstance.lastCategory
                print("New Category Cell \(cell.categoryLabel.text)")
                return cell
            }
            
            let exhibitsInCategory = exhibits.getExhibits(category: SharingManager.sharedInstance.lastCategory)
            
            if exhibitsInCategory.count == SharingManager.sharedInstance.lastIndexInCategory {
                let previousCategoryIndex = keys.index(of: SharingManager.sharedInstance.lastCategory)
                if previousCategoryIndex! + 1 >= keys.count {
                    return cell
                }
                print("Keys.endIndex \(keys.count)")
                print(previousCategoryIndex!)
                SharingManager.sharedInstance.lastCategory = keys[previousCategoryIndex! + 1]
                SharingManager.sharedInstance.lastIndexInCategory = 0
                cell.hideExhibitFeatures()
                cell.categoryLabel.text = SharingManager.sharedInstance.lastCategory
                print("New Category Cell \(cell.categoryLabel.text)")
                return cell
            }

            
            var currentExhibits = exhibits.getExhibits(category: SharingManager.sharedInstance.lastCategory)
            let currentExhibit = currentExhibits[SharingManager.sharedInstance.lastIndexInCategory]
            cell.exhibitDescription.text = currentExhibit.descrition
            cell.exhibitPhoto.image = currentExhibit.photo
            cell.exhibitTitle.text = currentExhibit.title
            cell.showExhibitFeatures()
            SharingManager.sharedInstance.lastIndexInCategory = SharingManager.sharedInstance.lastIndexInCategory + 1
        
            print("New Simple Cell \(cell.exhibitTitle.text)")
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
