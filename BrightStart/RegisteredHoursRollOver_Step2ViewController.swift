//
//  RegisteredHoursWeeklyViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class RegisteredHoursRollOver_Step2ViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var showNavigationBar = true
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var TopText: UILabel!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var SelectTheYearLabel: UILabel!
    
    @IBOutlet weak var UpperContent: UIView!
    
    @IBOutlet weak var Middle: UIView!
    
    @IBOutlet weak var LowerHeading: UIView!
    
    @IBOutlet weak var SelectTheMonthLabel: UILabel!
    
    @IBOutlet weak var LowerContent: UIView!
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var NextButton: UIButton!
    
    
    @IBOutlet weak var TargetYearPicker: UIPickerView!
    @IBOutlet weak var TargetMonthPicker: UIPickerView!
    
    @IBOutlet weak var DestinationYearPicker: UIPickerView!
    @IBOutlet weak var DestinationMonthPicker: UIPickerView!
    
    var targetYearDataSource = [String]();
    var targetMonothDataSource = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    var destinationYearDataSource = [String]();
    var destinationMonothDataSource = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TargetYearPicker.dataSource = self
        TargetYearPicker.delegate = self
        
        TargetMonthPicker.dataSource = self
        TargetMonthPicker.delegate = self
        
        DestinationYearPicker.dataSource = self
        DestinationYearPicker.delegate = self
        
        DestinationMonthPicker.dataSource = self
        DestinationMonthPicker.delegate = self
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        targetYearDataSource = [String(year-1), String(year), String(year+1)]
        destinationYearDataSource = [String(year-1), String(year), String(year+1)]
        
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        //Fonts
        TopText.font = _ApplicatoinColours.XlargeFont
       
        SelectTheYearLabel.font = _ApplicatoinColours.mediumFont
        SelectTheMonthLabel.font = _ApplicatoinColours.mediumFont
        
        TopText.textColor = StyleManager.theme1()
        
        SelectTheYearLabel.textColor = StyleManager.theme2()
        SelectTheMonthLabel.textColor = StyleManager.theme2()
        
        TopText.text = "Dates"
        
        Top.backgroundColor = StyleManager.theme2()
        
        UpperHeading.backgroundColor = StyleManager.theme2()
        
        UpperContent.backgroundColor = StyleManager.theme2()
        
        Middle.backgroundColor = StyleManager.theme2()
        
        LowerHeading.backgroundColor = StyleManager.theme1()
        
        LowerContent.backgroundColor = StyleManager.theme2()
        
        Bottom.backgroundColor = StyleManager.theme1()
        
        TargetYearPicker.selectRow(1, inComponent: 0, animated: false)
        DestinationYearPicker.selectRow(1, inComponent: 0, animated: false)

        let month = calendar.component(.month, from: date)
        TargetMonthPicker.selectRow(month, inComponent: 0, animated: false)
        DestinationMonthPicker.selectRow(month, inComponent: 0, animated: false)
        
        lastSelectedTargetYear = String(targetYearDataSource[1])
        lastSelectedDestinationYear = String(targetYearDataSource[1])
        
        lastSelectedTargetMonth = String(destinationMonothDataSource[month])
        lastSelectedDestinationMonth = String(destinationMonothDataSource[month])

    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if TargetYearPicker == pickerView {
            return targetYearDataSource.count;
        }
        if TargetMonthPicker == pickerView {
            return targetMonothDataSource.count;
        }
        if DestinationYearPicker == pickerView {
            return destinationYearDataSource.count;
        }
        if DestinationMonthPicker == pickerView {
            return destinationMonothDataSource.count;
        }
        
        return 0
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if TargetYearPicker == pickerView {
            return targetYearDataSource[row]
        }
        if TargetMonthPicker == pickerView {
            return targetMonothDataSource[row]
        }
        if DestinationYearPicker == pickerView {
            return destinationYearDataSource[row]
        }
        if DestinationMonthPicker == pickerView {
           return destinationMonothDataSource[row]
        }
        
        return ""
    }
    
    var lastSelectedTargetYear: String = "";
    var lastSelectedTargetMonth: String = "";
    
    var lastSelectedDestinationYear: String = "";
    var lastSelectedDestinationMonth: String = "";
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if TargetYearPicker == pickerView {
           lastSelectedTargetYear = targetYearDataSource[row] as String
        }
        if TargetMonthPicker == pickerView {
              lastSelectedTargetMonth = targetMonothDataSource[row] as String
        }
        if DestinationYearPicker == pickerView {
              lastSelectedDestinationYear = destinationYearDataSource[row] as String
        }
        if DestinationMonthPicker == pickerView {
             lastSelectedDestinationMonth = destinationMonothDataSource[row] as String
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
        
        SelectTheYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        SelectTheYearLabel.centerYAnchor.constraint(
            equalTo: UpperHeading.centerYAnchor).isActive = true
        
        //left
        SelectTheYearLabel.leadingAnchor.constraint(
            equalTo: UpperHeading.leadingAnchor, constant: 15).isActive = true
        
        //width
        SelectTheYearLabel.widthAnchor.constraint(
            equalTo: UpperHeading.widthAnchor, multiplier: 0.40).isActive = true
        
        
        
        
        
        
        
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
        
        //TARGET YEAR PICKER
        
        TargetYearPicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        TargetYearPicker.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        TargetYearPicker.leadingAnchor.constraint(
            equalTo: UpperContent.leadingAnchor, constant: 15).isActive = true
        
        TargetYearPicker.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.45).isActive = true
        
        
        //TARGET MONTH Picker
        TargetMonthPicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        TargetMonthPicker.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        TargetMonthPicker.trailingAnchor.constraint(
            equalTo: UpperContent.trailingAnchor, constant: -15).isActive = true
        
        TargetMonthPicker.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.45).isActive = true
        
        
        
        
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
        
        SelectTheMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        SelectTheMonthLabel.centerYAnchor.constraint(
            equalTo: LowerHeading.centerYAnchor).isActive = true
        
        //left
        SelectTheMonthLabel.leadingAnchor.constraint(
            equalTo: LowerHeading.leadingAnchor, constant: 15).isActive = true
        
        //width
        SelectTheMonthLabel.widthAnchor.constraint(
            equalTo: LowerHeading.widthAnchor, multiplier: 0.40).isActive = true
        
        
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
        
        
        //Month
        
        DestinationYearPicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        DestinationYearPicker.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        //right
        DestinationYearPicker.leadingAnchor.constraint(
            equalTo: LowerContent.leadingAnchor, constant: 15).isActive = true
        
        //height
        DestinationYearPicker.heightAnchor.constraint(
            equalTo: LowerContent.heightAnchor).isActive = true
        
        //width
        DestinationYearPicker.widthAnchor.constraint(
            equalTo: LowerContent.widthAnchor, multiplier: 0.45).isActive = true
        
        
        //Month picker
        
        DestinationMonthPicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        DestinationMonthPicker.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        //right
        DestinationMonthPicker.trailingAnchor.constraint(
            equalTo: LowerContent.trailingAnchor, constant: -15).isActive = true
        
        //height
        DestinationMonthPicker.heightAnchor.constraint(
            equalTo: LowerContent.heightAnchor).isActive = true
        
        //width
        DestinationMonthPicker.widthAnchor.constraint(
            equalTo: LowerContent.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func NavBarMenuTapped(){
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    
}
