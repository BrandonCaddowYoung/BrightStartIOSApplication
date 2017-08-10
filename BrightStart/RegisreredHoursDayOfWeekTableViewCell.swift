//
//   Configure the view for the selected state     }  } RegisreredHoursDayOfWeekTableViewCell.swift
//  BrightStart
//
//  Created by Colleen Caddow on 10/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

protocol RegHoursWeeklyViewCellDelegate {
    
    func updateStartDate(newDate: Date, dayOfWeek: Int)
    
    func updateEndDate(newDate: Date, dayOfWeek: Int)
    
}

class RegisreredHoursDayOfWeekTableViewCell: UITableViewCell {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var tickButton: UIButton!
    
    
    @IBOutlet weak var StartTimePicker: UIDatePicker!
    
    @IBOutlet weak var EndTimePicker: UIDatePicker!
    
    @IBOutlet weak var DayOfWeekLabel: UILabel!
    
    
    @IBOutlet weak var StartLabel: UILabel!
    
    @IBOutlet weak var EndLabel: UILabel!
    
    var delegate: RegHoursWeeklyViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        StartTimePicker.datePickerMode = UIDatePickerMode.time
        StartTimePicker.addTarget(self, action: #selector(startDateChanged(_:)), for: .valueChanged)
        
        
        EndTimePicker.datePickerMode = UIDatePickerMode.time
        EndTimePicker.addTarget(self, action: #selector(endDatePickerChanged(_:)), for: .valueChanged)
        
        setupConstraints()
        
        self.contentView.backgroundColor = StyleManager.theme2()
        
    }
    
    func startDateChanged(_ sender: UIDatePicker) {
        
        delegate?.updateStartDate(newDate: sender.date, dayOfWeek: _CommonHelper.GetDayAsInt(monthAsString: DayOfWeekLabel.text ?? "?"))
        
    }
    
    func endDatePickerChanged(_ sender: UIDatePicker) {
        
        delegate?.updateEndDate(newDate: sender.date, dayOfWeek: _CommonHelper.GetDayAsInt(monthAsString: DayOfWeekLabel.text ?? "?"))
        
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
