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
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 360
        case 1:
            return 120
        default:
            return 60
        }
    }
}

extension EventDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailInfoTableViewCell_ID", for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventPhotoSliderTableViewCell_ID", for: indexPath)
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
            return "PHOTOS"
        default:
            return String()
        }
    }
    
}
