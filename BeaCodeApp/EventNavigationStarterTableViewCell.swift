//
//  EventNavigationStarterTableViewCell.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit

class EventNavigationStarterTableViewCell: UITableViewCell {
    let beacodeBlue: UIColor = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1)
    
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
        navigationStartButton.backgroundColor = UIColor.clear
        navigationStartButton.layer.cornerRadius = 5
        navigationStartButton.layer.borderWidth = 1
        navigationStartButton.layer.borderColor = beacodeBlue.cgColor
    }

}
