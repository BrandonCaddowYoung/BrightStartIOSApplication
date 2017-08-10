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
        
        contentView.backgroundColor = StyleManager.TableBackGroundColour()
        
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
        
        self.backgroundColor = StyleManager.theme1()
        
        self.titleLabel.textColor = StyleManager.TableFontColor()
        self.timeLabel.textColor =  StyleManager.TableFontColor()
        
        //titleLabel?.text = nil
        
        if let log = self.log
        {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "HH mm ss"
            
            //dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
            dateFormatter.dateFormat = "h:mm a"
            
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            
            let convertedDateString = dateFormatter.string(from: log.TimeStamp)
            
            let dateField = convertedDateString as String
            
            titleLabel?.text = "\(log.Action)"
            timeLabel?.text = "\(dateField)"
            
            // UserDefaults.standard.set(child.RegisteredFinishTime, forKey: "finishTime")
            //UserDefaults.standard.set(child.RegisteredStartTime, forKey: "dateKey")
        }
    }
    
    
}


