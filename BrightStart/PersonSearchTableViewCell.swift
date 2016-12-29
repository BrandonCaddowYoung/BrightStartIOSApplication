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
    var child: Child? {
        didSet {
            updateUI()
        }
    }
    
    var _CommonHelper: CommonHelper!
    var _ApplicationColours: ApplicatoinColours!
    
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var birthdayText: UILabel!
    
    override func awakeFromNib() {
        
        _CommonHelper = CommonHelper()
        _ApplicationColours = ApplicatoinColours()
        
        setupConstraints()
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
        
        //right
        childNameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        //Positioning the birthday label
        
         birthdayText.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        birthdayText.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        //right
        birthdayText.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        //bottomAnchor
        birthdayText.topAnchor.constraint(
            equalTo: childNameLabel.bottomAnchor).isActive = true
        
        //bottomAnchor
        birthdayText.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 170.0;//Choose your custom row height
    }
    
    func updateUI() {
        
        self.backgroundColor = _ApplicationColours.BackGroundColour
        
        self.childNameLabel.textColor = .black
        self.birthdayText.textColor = .black
        
        childNameLabel?.text = nil
        
        if let child = self.child
        {
            childNameLabel?.text = "\(child.Name)"
            
            UserDefaults.standard.set(child.RegisteredFinishTime, forKey: "finishTime")
            UserDefaults.standard.set(child.RegisteredStartTime, forKey: "dateKey")
        }
    }
}


