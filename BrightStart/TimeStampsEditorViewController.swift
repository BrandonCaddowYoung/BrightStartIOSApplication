//
//  TimeStampsEditorViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 29/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class TimeStampsEditorViewController: UIViewController {
    
    @IBOutlet weak var DateLabelText: UILabel!
    
    @IBOutlet weak var TimeLabelText: UILabel!
    
    @IBOutlet weak var TargetPersonName: UILabel!
    @IBOutlet weak var TargetDate: UILabel!
    
    @IBOutlet weak var TargetCurrentTime: UILabel!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var PickerTitle: UILabel!
    
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var RemoveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupConstraints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        
       //Positioning the persons name
        
        TargetPersonName.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetPersonName.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        TargetPersonName.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //top
        TargetPersonName.topAnchor.constraint(
            equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        //Positioning the date label
        
        DateLabelText.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        DateLabelText.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //top
        DateLabelText.topAnchor.constraint(
            equalTo: TargetPersonName.bottomAnchor).isActive = true
        
        //Positioning the current date
        
        TargetDate.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetDate.leadingAnchor.constraint(
            equalTo: DateLabelText.trailingAnchor).isActive = true
        //top
        TargetDate.topAnchor.constraint(
            equalTo: DateLabelText.topAnchor).isActive = true
        
        //Positioning the time label
        
        TimeLabelText.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TimeLabelText.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //top
        TimeLabelText.topAnchor.constraint(
            equalTo: DateLabelText.bottomAnchor).isActive = true
        
        //Positioning the current time
        
        TargetCurrentTime.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetCurrentTime.leadingAnchor.constraint(
            equalTo: TimeLabelText.trailingAnchor).isActive = true
        //top
        TargetCurrentTime.topAnchor.constraint(
            equalTo: TimeLabelText.topAnchor).isActive = true

        
        
        //Positioning Date Time Picker
        
        DateTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //Center y
        DateTimePicker.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        
        //Center x
        DateTimePicker.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //height
        DateTimePicker.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        
        //Positioning Date Time Picker title
        
        PickerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        PickerTitle.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //bottom
        PickerTitle.bottomAnchor.constraint(
            equalTo: DateTimePicker.topAnchor).isActive = true

        
        //Positioning Delete Button
        
        RemoveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        RemoveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        //left
        RemoveButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        RemoveButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //bottom
        RemoveButton.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        //Positioning Save Button
        
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        SaveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //left
        SaveButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        SaveButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //bottom
        SaveButton.bottomAnchor.constraint(
            equalTo: RemoveButton.topAnchor).isActive = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
