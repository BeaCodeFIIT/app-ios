//
//  ExhibitTableViewCell.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 07/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit

class ExhibitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exhibitPhoto: UIImageView!
    @IBOutlet weak var exhibitTitle: UILabel!
    @IBOutlet weak var exhibitDescription: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkboxTapped(_ sender: Any) {
        if checkbox.titleLabel?.text == "☑\u{0000FE0E}" {
            checkbox.setTitle("☐", for: .normal)
            checkbox.titleLabel?.font = UIFont(name: self.exhibitTitle.font.fontName, size: 24.0)
        } else {
            self.checkbox.setTitle("☑\u{0000FE0E}", for: .normal)
            checkbox.titleLabel?.font = UIFont(name: self.exhibitTitle.font.fontName, size: 32.0)
        }
    }
    

}
