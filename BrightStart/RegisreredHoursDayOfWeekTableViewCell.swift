//
//   Configure the view for the selected state     }  } RegisreredHoursDayOfWeekTableViewCell.swift
//  BrightStart
//
//  Created by Colleen Caddow on 10/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class RegisreredHoursDayOfWeekTableViewCell: UITableViewCell {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var tickButton: UIButton!
    
    
    @IBOutlet weak var StartTimePicker: UIDatePicker!
    
    @IBOutlet weak var EndTimePicker: UIDatePicker!
    
    @IBOutlet weak var DayOfWeekLabel: UILabel!
    
    
    @IBOutlet weak var StartLabel: UILabel!
    
    @IBOutlet weak var EndLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        StartTimePicker.datePickerMode = UIDatePickerMode.time
        
        EndTimePicker.datePickerMode = UIDatePickerMode.time
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        //Top
        
        tickButton.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        tickButton.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        
        tickButton.widthAnchor.constraint(
            equalToConstant: 25).isActive = true
        
        tickButton.heightAnchor.constraint(
            equalToConstant: 25).isActive = true
        
        
        
        
        DayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        DayOfWeekLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        
        DayOfWeekLabel.widthAnchor.constraint(
            equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        
        DayOfWeekLabel.centerYAnchor.constraint(
            equalTo: tickButton.centerYAnchor).isActive = true
        
        
        
        
        
        StartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        StartLabel.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        
        StartLabel.widthAnchor.constraint(
            equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        
        StartLabel.topAnchor.constraint(
            equalTo: DayOfWeekLabel.bottomAnchor).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        StartTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        StartTimePicker.leadingAnchor.constraint(
            equalTo: self.leadingAnchor).isActive = true
        
        StartTimePicker.widthAnchor.constraint(
            equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        
        StartTimePicker.heightAnchor.constraint(
            equalTo: self.heightAnchor, multiplier: 0.50).isActive = true
        
        StartTimePicker.topAnchor.constraint(
            equalTo: StartLabel.bottomAnchor).isActive = true

        
        
        
        EndTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        EndTimePicker.trailingAnchor.constraint(
            equalTo: self.trailingAnchor).isActive = true
        
        EndTimePicker.widthAnchor.constraint(
            equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        
        EndTimePicker.heightAnchor.constraint(
            equalTo: self.heightAnchor, multiplier: 0.50).isActive = true
        
        EndTimePicker.topAnchor.constraint(
            equalTo: StartLabel.bottomAnchor).isActive = true
        
    
        
        
        
        EndLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        EndLabel.leadingAnchor.constraint(
            equalTo: EndTimePicker.leadingAnchor).isActive = true
        
        EndLabel.widthAnchor.constraint(
            equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        
        EndLabel.topAnchor.constraint(
            equalTo: DayOfWeekLabel.bottomAnchor).isActive = true
        
        
        
        self.bottomAnchor.constraint(
            equalTo: EndTimePicker.bottomAnchor).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
