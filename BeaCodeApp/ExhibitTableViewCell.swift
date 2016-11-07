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
        if checkbox.titleLabel?.text == "☑" {
            checkbox.setTitle("☐", for: .normal)
        } else {
            self.checkbox.setTitle("☑", for: .normal)
        }
    }
    

}
