//
//  EventPhotoSliderTableViewCell.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit

class EventPhotoSliderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EventPhotoSliderTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\n\n\n \(SharingManager.sharedInstance.selectedEvent.photos.count) \n\n\n")
        return SharingManager.sharedInstance.selectedEvent.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo_cell", for: indexPath) as! PhotoCell
        cell.photo.image = SharingManager.sharedInstance.selectedEvent.photos[indexPath.row]
        return cell
    }
    
}
