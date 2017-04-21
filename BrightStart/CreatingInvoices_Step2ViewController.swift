//
//  RegisteredHoursWeeklyViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class CreatingInvoices_Step2ViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var showNavigationBar = true
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var TopText: UILabel!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var TopLabel: UILabel!
    
    @IBOutlet weak var UpperContent: UIView!
    
    
    @IBOutlet weak var Middle: UIView!
    
    @IBOutlet weak var LowerHeading: UIView!
    
    @IBOutlet weak var BottomLabel: UILabel!
    
    @IBOutlet weak var LowerContent: UIView!
    
    
    @IBOutlet weak var RegistredHoursStartDate: UIDatePicker!
    
    @IBOutlet weak var RegisteredHoursEndDate: UIDatePicker!
    
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var NextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        //Fonts
        TopText.font = _ApplicatoinColours.XlargeFont
        TopLabel.font = _ApplicatoinColours.mediumFont
        BottomLabel.font = _ApplicatoinColours.mediumFont
        
        TopText.textColor = _ApplicatoinColours.Orange
        TopLabel.textColor = _ApplicatoinColours.White
        BottomLabel.textColor = _ApplicatoinColours.White
        
        TopText.text = "Dates"
        
        Top.backgroundColor = _ApplicatoinColours.Blue
        
        UpperHeading.backgroundColor = _ApplicatoinColours.Blue
        
        UpperContent.backgroundColor = _ApplicatoinColours.White
        
        Middle.backgroundColor = _ApplicatoinColours.White
        
        LowerHeading.backgroundColor = _ApplicatoinColours.Blue
        
        LowerContent.backgroundColor = _ApplicatoinColours.White
        
        Bottom.backgroundColor = _ApplicatoinColours.Blue
        
    }
    
    var lastSelectedRegisteredHoursStartDate = Date()
    var lastSelectedRegisteredHoursEndDate = Date()
    
    func datePickerChanged(datePicker:UIDatePicker) {
        
        if(datePicker == RegistredHoursStartDate)
        {
            lastSelectedRegisteredHoursStartDate = datePicker.date
        }
        else if(datePicker == RegisteredHoursEndDate)
        {
            lastSelectedRegisteredHoursStartDate = datePicker.date
        }
        
    }
    
    func setupConstraints() {
        
        //Middle
        
        Middle.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Middle.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        
        Middle.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //height
        Middle.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.01).isActive = true
        
        
        //Top
        
        Top.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Top.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Top.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        Top.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //height
        Top.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        
        TopText.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        TopText.centerYAnchor.constraint(
            equalTo: Top.centerYAnchor).isActive = true
        
        TopText.widthAnchor.constraint(
            equalTo: Top.widthAnchor, multiplier: 0.80).isActive = true
        
        TopText.trailingAnchor.constraint(
            equalTo: Top.trailingAnchor, constant: -10).isActive = true
        
        TopText.textAlignment = .right
        
        
        //Upper Heading
        
        UpperHeading.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperHeading.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperHeading.topAnchor.constraint(
            equalTo: Top.bottomAnchor).isActive = true
        
        //height
        UpperHeading.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        //SelectTheYearLabel
        
        TopLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        TopLabel.centerYAnchor.constraint(
            equalTo: UpperHeading.centerYAnchor).isActive = true
        
        //left
        TopLabel.leadingAnchor.constraint(
            equalTo: UpperHeading.leadingAnchor, constant: 15).isActive = true
        
        //width
        TopLabel.widthAnchor.constraint(
            equalTo: UpperHeading.widthAnchor).isActive = true
        
        
        
        
        
        
        
        //Upper Content
        
        UpperContent.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperContent.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperContent.topAnchor.constraint(
            equalTo: UpperHeading.bottomAnchor).isActive = true
        
        //height
        UpperContent.bottomAnchor.constraint(
            equalTo: Middle.topAnchor).isActive = true
        
        //Year Picker
        RegistredHoursStartDate.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        RegistredHoursStartDate.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        //center
        RegistredHoursStartDate.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        //Bottom
        
        Bottom.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Bottom.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Bottom.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        Bottom.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //height
        Bottom.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //NextButon
        NextButton.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        NextButton.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        NextButton.leadingAnchor.constraint(
            equalTo: LowerContent.leadingAnchor).isActive = true
        
        //Lower Heading
        
        LowerHeading.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LowerHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        LowerHeading.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        LowerHeading.topAnchor.constraint(
            equalTo: Middle.bottomAnchor).isActive = true
        
        //height
        LowerHeading.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        //SelectTheYearLabel
        
        BottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        BottomLabel.centerYAnchor.constraint(
            equalTo: LowerHeading.centerYAnchor).isActive = true
        
        //left
        BottomLabel.leadingAnchor.constraint(
            equalTo: LowerHeading.leadingAnchor, constant: 15).isActive = true
        
        //width
        BottomLabel.widthAnchor.constraint(
            equalTo: LowerHeading.widthAnchor).isActive = true
        
        
        //Lower Content
        
        LowerContent.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LowerContent.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        LowerContent.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        LowerContent.bottomAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        //top
        LowerContent.topAnchor.constraint(
            equalTo: LowerHeading.bottomAnchor).isActive = true
        
        //Month picker
        
        RegisteredHoursEndDate.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        RegisteredHoursEndDate.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        //center
        RegisteredHoursEndDate.centerXAnchor.constraint(
            equalTo: LowerContent.centerXAnchor).isActive = true
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
