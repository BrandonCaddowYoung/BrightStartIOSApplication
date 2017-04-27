//
//  RegisteredHoursWeeklyViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/04/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class RegisteredHoursWeekly_Step2ViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var showNavigationBar = true
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var TopText: UILabel!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var SelectTheYearLabel: UILabel!
    
    @IBOutlet weak var UpperContent: UIView!
    
    @IBOutlet weak var YearLabel: UILabel!
    
    @IBOutlet weak var YearPicker: UIPickerView!
    
    @IBOutlet weak var Middle: UIView!
    
    @IBOutlet weak var LowerHeading: UIView!
    
    @IBOutlet weak var SelectTheMonthLabel: UILabel!
    
    @IBOutlet weak var LowerContent: UIView!
    
    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBOutlet weak var MonthPicker: UIPickerView!
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var NextButton: UIButton!
    
    var yearDataSource = [String]();
    var monothDataSource = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YearPicker.dataSource = self
        YearPicker.delegate = self
        
        MonthPicker.dataSource = self
        MonthPicker.delegate = self
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        
        yearDataSource = [String(year-1), String(year), String(year+1)]
        
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        //Fonts
        TopText.font = _ApplicatoinColours.XlargeFont
        YearLabel.font = _ApplicatoinColours.mediumFont
        MonthLabel.font = _ApplicatoinColours.mediumFont
        SelectTheYearLabel.font = _ApplicatoinColours.mediumFont
        SelectTheMonthLabel.font = _ApplicatoinColours.mediumFont
        
        TopText.textColor = StyleManager.theme4()
        YearLabel.textColor = StyleManager.theme5()
        MonthLabel.textColor = StyleManager.theme5()
        SelectTheYearLabel.textColor = StyleManager.theme5()
        SelectTheMonthLabel.textColor = StyleManager.theme5()

        TopText.text = "Dates"
        
        Top.backgroundColor = StyleManager.theme2()
        
        UpperHeading.backgroundColor = StyleManager.theme2()
        
        UpperContent.backgroundColor = StyleManager.theme2()
        
        Middle.backgroundColor = StyleManager.theme2()
        
        LowerHeading.backgroundColor = StyleManager.theme1()
        
         LowerContent.backgroundColor = StyleManager.theme2()
        
         Bottom.backgroundColor = StyleManager.theme1()
        
        //TopText.isHidden = true
        
        YearPicker.selectRow(1, inComponent: 0, animated: false)
        
      //  lastSelectedYear = 2017
        
        let month = calendar.component(.month, from: date)
        MonthPicker.selectRow(month, inComponent: 0, animated: false)
        
        lastSelectedMonth = String(monothDataSource[month])
        lastSelectedYear = String(yearDataSource[1])

    }
    
   
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if YearPicker == pickerView {
            return yearDataSource.count;
        }
        if MonthPicker == pickerView {
            return monothDataSource.count;
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
        
        if YearPicker == pickerView {
            return yearDataSource[row]
        }
        if MonthPicker == pickerView {
            return monothDataSource[row]
        }
        
        return ""
        
    }
    
    var lastSelectedMonth: String = "";
     var lastSelectedYear: String = "";
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if YearPicker == pickerView {
            lastSelectedYear = yearDataSource[row] as String

        }
        if MonthPicker == pickerView {
            lastSelectedMonth = monothDataSource[row] as String
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
        
        //Year
        
        YearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        YearLabel.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        YearLabel.leadingAnchor.constraint(
            equalTo: UpperContent.leadingAnchor, constant: 15).isActive = true
        
        YearLabel.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.30).isActive = true
        
        
        //Year Picker
        YearPicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        YearPicker.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true
        
        YearPicker.trailingAnchor.constraint(
            equalTo: UpperContent.trailingAnchor, constant: -15).isActive = true
        
        YearPicker.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.50).isActive = true
        
        
        
        
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
        
        MonthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        MonthLabel.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        MonthLabel.leadingAnchor.constraint(
            equalTo: LowerContent.leadingAnchor, constant: 15).isActive = true
        
        MonthLabel.widthAnchor.constraint(
            equalTo: LowerContent.widthAnchor, multiplier: 0.30).isActive = true
        
        
        //Month picker
        
        MonthPicker.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        MonthPicker.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        //right
        MonthPicker.trailingAnchor.constraint(
            equalTo: LowerContent.trailingAnchor, constant: -15).isActive = true
        
        //height
        MonthPicker.heightAnchor.constraint(
            equalTo: LowerContent.heightAnchor).isActive = true
        
        //width
        MonthPicker.widthAnchor.constraint(
            equalTo: LowerContent.widthAnchor, multiplier: 0.50).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
