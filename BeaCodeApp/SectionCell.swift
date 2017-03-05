//
//  SectionCell.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 06/03/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import UIKit

class SectionCell: UITableViewCell {

    @IBOutlet weak var titleButton: UIButton!
    var exhibits = Array<Exhibit>()
    
    @IBAction func titleButtonPressed(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
