//
//  ListItemCell.swift
//  BrightStart
//
//  Created by Brandon Young on 21/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var tickButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        //Top
        
        tickButton.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        tickButton.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        
        tickButton.widthAnchor.constraint(
            equalToConstant: 40).isActive = true
        
        tickButton.heightAnchor.constraint(
            equalToConstant: 40).isActive = true
        
        tickButton.centerYAnchor.constraint(
            equalTo: self.centerYAnchor).isActive = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
