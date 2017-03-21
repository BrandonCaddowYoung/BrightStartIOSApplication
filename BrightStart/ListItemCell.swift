//
//  ListItemCell.swift
//  BrightStart
//
//  Created by Colleen Caddow on 21/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {

    @IBOutlet weak var tickButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
