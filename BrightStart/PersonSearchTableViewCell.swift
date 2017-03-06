//
//  CustomTableViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class PersonSearchTableViewCell: UITableViewCell
{
    var child: BrightStartChild? {
        didSet {
            updateUI()
        }
    }
    
    var _CommonHelper: CommonHelper!
    var _ApplicationColours: ApplicatoinColours!
    
    @IBOutlet weak var childNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        _CommonHelper = CommonHelper()
        _ApplicationColours = ApplicatoinColours()
        
        setupConstraints()
        
        contentView.backgroundColor = _ApplicationColours.BackGroundColour
        
        childNameLabel.font = _ApplicationColours.largeFont
        childNameLabel.textColor = _ApplicationColours.FontColour

    }
    
    func setupConstraints() {
        
        //Positioning the name label
        
        childNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        childNameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        //top
        childNameLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        //bottom
        childNameLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        //right
        childNameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 170.0;//Choose your custom row height
    }
    
    func updateUI() {
        
        self.backgroundColor = _ApplicationColours.BackGroundColour
        
        childNameLabel?.text = nil
        
        if let child = self.child
        {
            childNameLabel?.text = "\(child.ChildFullName)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
           // birthdayText?.text = dateFormatter.string(from: child.ChildDOB) as String
           
        }
    }
}


