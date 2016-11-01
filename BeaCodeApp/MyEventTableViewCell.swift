//
//  MyEventTableViewCell.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit

class MyEventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initDefaults()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initDefaults() {
        eventImage.backgroundColor = UIColor.lightGray
        eventTitle.backgroundColor = UIColor.lightGray
        eventSubtitle.backgroundColor = UIColor.lightGray
    }

}
