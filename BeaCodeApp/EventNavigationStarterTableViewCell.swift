//
//  EventNavigationStarterTableViewCell.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit

class EventNavigationStarterTableViewCell: UITableViewCell {
    @IBOutlet weak var navigationStartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initDefaults()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initDefaults() {
        navigationStartButton.backgroundColor = UIColor.lightGray
    }

}
