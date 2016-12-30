//
//  CustomTableViewCell.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class TimeStampSearchTableViewCell: UITableViewCell
{
    var log: PersonLog? {
        didSet {
            updateUI()
        }
    }
    
    var _CommonHelper: CommonHelper!
    var _ApplicationColours: ApplicatoinColours!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        
        _CommonHelper = CommonHelper()
        _ApplicationColours = ApplicatoinColours()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        //Positioning the name label
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        titleLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        //top
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        //right
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        //Positioning the birthday label
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        timeLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        
        //right
        timeLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        //bottomAnchor
        timeLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor).isActive = true
        
        //bottomAnchor
        timeLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 170.0;//Choose your custom row height
    }
    
    func updateUI() {
        
        self.backgroundColor = _ApplicationColours.BackGroundColour
        
        self.titleLabel.textColor = .black
        self.timeLabel.textColor = .black
        
        //titleLabel?.text = nil
        
        if let log = self.log
        {
            titleLabel?.text = "\(log.Action)"
            
            timeLabel?.text = "\(log.TimeStamp)"
            
           // UserDefaults.standard.set(child.RegisteredFinishTime, forKey: "finishTime")
            //UserDefaults.standard.set(child.RegisteredStartTime, forKey: "dateKey")
        }
    }
    
    
}


