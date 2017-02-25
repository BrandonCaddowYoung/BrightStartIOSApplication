//
//  TimeStampsEditorViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

enum TimeStampEditerType: Int {
    case RegisteredHours_Create
    case RegisteredHours_Edit
    case TimeStamps_Create
    case TimeStamps_Edit
}

enum EditTargetType: Int {
    case Start
    case End
}

class TimeStampsEditorViewController: UIViewController {
    
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var goBackOnSuccess = false
    
    var Action:String!
    var PersonId:String!
    var Name:String!
    var Date:String!
    var DateAsObject:Date!
    var Time:String!
    
    //For Regisrted hours
    var existingStartDate: Date!
    var existingEndDate: Date!
    var registerdHoursId: String!
    var editType: EditTargetType!
    
    var EditorMode: TimeStampEditerType!
    
    @IBOutlet weak var TargetPersonName: UILabel!
    @IBOutlet weak var TargetDate: UILabel!
    
    @IBOutlet weak var TargetCurrentTime: UILabel!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var RemoveButton: UIButton!
    
    @IBOutlet weak var SaveTimeStamp: UIButton!
    @IBOutlet weak var RemoveTimeStamp: UIButton!
    
    @IBAction func SaveTimeStampTouched(_ sender: Any) {
        
        if(EditorMode == .TimeStamps_Edit){
        
        let alert = self._CommonHelper.showOverlayMessage("Updating...")
        self.present(alert, animated: true, completion: nil)
        
        CommonRequests.sharedInstance.updateTimeStamp(personId: PersonId!, action: Action!, stamp: DateTimePicker.date as NSDate, originalAction: Action!, originalTimeStamp: DateAsObject as NSDate,
                                                     
                                              onCompletion: {
                                                
                                                DispatchQueue.main.async(execute: {
                                                    self.dismiss(animated: false, completion: {
                                                    
                                                        if(self.goBackOnSuccess){
                                                        if let nav = self.navigationController {
                                                            nav.popViewController(animated: true)
                                                        } else {
                                                            self.dismiss(animated: true, completion: nil)
                                                        }
                                                        }
                                                        else{
                                                        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                                                        }
                                                    
                                                    })
                                                    
                                                })
        })
            
        }
        else if(EditorMode == .RegisteredHours_Edit){
            
            //Make API call to update time stamp and then return to the time stamps menu.
            
            let alert = self._CommonHelper.showOverlayMessage("Updating...")
            self.present(alert, animated: true, completion: nil)
            
            var originalDateValue = NSDate()
            var newStartValue = NSDate()
            var newEndValue = NSDate()
            
            if(editType == .Start)
            {
                originalDateValue = existingStartDate as NSDate
            }
            else if(editType == .End)
            {
                originalDateValue = existingEndDate as NSDate
            }
            
            if(editType == .Start)
            {
                newEndValue = existingEndDate as NSDate
                newStartValue = DateTimePicker.date as NSDate
            }
            else if(editType == .End)
            {
                newStartValue = existingStartDate as NSDate
                newEndValue = DateTimePicker.date as NSDate
            }
            
            RegistrationHoursRequests.sharedInstance.UpdateRegisteredHours(id: registerdHoursId, newStartDate: newStartValue, newEndDate: newEndValue, onCompletion: {_ in
                
                DispatchQueue.main.async(execute: {
                    self.dismiss(animated: false, completion: {
                        
                        
                        
                        
                        if(self.goBackOnSuccess){
                            if let nav = self.navigationController {
                                nav.popViewController(animated: true)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        else{
                            self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                        }
                        
                        
                    })
                    
                })
            })
            
        }else if(EditorMode == .RegisteredHours_Create){
         
            let alert = self._CommonHelper.showOverlayMessage("Updating...")
            self.present(alert, animated: true, completion: nil)
            
            //Change to to creating registered hours
            RegistrationHoursRequests.sharedInstance.CreateRegisteredHours(personId: PersonId!, startTime: DateTimePicker.date as NSDate, finishTime: DateTimePicker.date as NSDate, onCompletion: {_ in 
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                self.dismiss(animated: false, completion: {
                                                                    
                                                                    
                                                                    
                                                                    if(self.goBackOnSuccess){
                                                                        if let nav = self.navigationController {
                                                                            nav.popViewController(animated: true)
                                                                        } else {
                                                                            self.dismiss(animated: true, completion: nil)
                                                                        }
                                                                    }
                                                                    else{
                                                                        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                    
                                                                })
                                                                
                                                            })
            })
            
        }
        else if(EditorMode == .TimeStamps_Create){
         
            let alert = self._CommonHelper.showOverlayMessage("Updating...")
            self.present(alert, animated: true, completion: nil)
            
            
            //Change to to creating time stamps
            CommonRequests.sharedInstance.createTimeStamp(personId: PersonId!, action: Action!, stamp: DateTimePicker.date as NSDate,
                                                          onCompletion: {
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                self.dismiss(animated: false, completion: {
                                                                    
                                                                    
                                                                    
                                                                    
                                                                    if(self.goBackOnSuccess){
                                                                        if let nav = self.navigationController {
                                                                            nav.popViewController(animated: true)
                                                                        } else {
                                                                            self.dismiss(animated: true, completion: nil)
                                                                        }
                                                                    }
                                                                    else{
                                                                        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                })
                                                                
                                                            })
            })
            
            
            
            
            
        }
        
    }
    
    @IBAction func RemoveTimeStampTouched(_ sender: Any) {
        
        //Make API call to delete time stamp and then return to the time stamps menu.
        
        let alert = self._CommonHelper.showOverlayMessage("Removing...")
        self.present(alert, animated: true, completion: nil)
        
        CommonRequests.sharedInstance.deleteTimeStamp(personId: PersonId!, action: Action!, stamp: DateTimePicker.date as NSDate,
                                                      
                                                      onCompletion: {
                                                        
                                                        DispatchQueue.main.async(execute: {
                                                            self.dismiss(animated: false, completion: {
                                                                
                                                                if(self.goBackOnSuccess){
                                                                    if let nav = self.navigationController {
                                                                        nav.popViewController(animated: true)
                                                                    } else {
                                                                        self.dismiss(animated: true, completion: nil)
                                                                    }
                                                                }
                                                                else{
                                                                    self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                                                                }
                                                                
                                                            })
                                                            
                                                        })
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        setupConstraints()
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        SaveTimeStamp.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SaveTimeStamp.tintColor = _ApplicatoinColours.ButtonForeGroundColor
        
        TargetPersonName.text = Name
        TargetDate.text = Date
        TargetCurrentTime.text = Time
        DateTimePicker.date = DateAsObject
        
        DateTimePicker.datePickerMode = UIDatePickerMode.time
        
        //DateTimePicker.maximumDate = NSDate() as Date
        
        if(EditorMode == .RegisteredHours_Create || EditorMode == .TimeStamps_Create ){
            RemoveButton.isHidden = true
        }
        
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
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        //right
        TargetPersonName.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        //top
        TargetPersonName.topAnchor.constraint(
            equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        //height
        TargetPersonName.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.10).isActive = true
        
        //Positioning the current date
        
        TargetDate.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetDate.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        //top
        TargetDate.topAnchor.constraint(
            equalTo: TargetPersonName.bottomAnchor).isActive = true
        
        //height
        TargetDate.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        TargetDate.font.withSize(100)
        
        //Positioning the current time
        
        TargetCurrentTime.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetCurrentTime.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        //top
        TargetCurrentTime.topAnchor.constraint(
            equalTo: TargetPersonName.bottomAnchor).isActive = true
        
        //height
        TargetCurrentTime.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        TargetCurrentTime.font.withSize(100)
        
        
        //Positioning Date Time Picker
        
        DateTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //DateTimePicker.topAnchor.constraint(
          //  equalTo: TargetCurrentTime.bottomAnchor).isActive = true
        
        //Center x
        DateTimePicker.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //Center y
        DateTimePicker.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true

        
        //height
        //DateTimePicker.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        DateTimePicker.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.30).isActive = true
        
        
        //Positioning Delete Button
        
        RemoveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        RemoveButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        //right
        RemoveButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        //bottom
        RemoveButton.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        
        //Positioning Save Button
        
        //Stlying remove button
        RemoveButton.layer.cornerRadius = 5
        RemoveButton.layer.borderWidth = 1
        RemoveButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        RemoveButton.backgroundColor = _ApplicatoinColours.Red
        
        RemoveButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        RemoveButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.10).isActive = true
        
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        //SaveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        SaveButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.10).isActive = true
        
        //left
        SaveButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        //right
        SaveButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        //bottom
        SaveButton.bottomAnchor.constraint(
            equalTo: RemoveButton.topAnchor, constant: -10).isActive = true
        
        //Stlying save button
        SaveButton.layer.cornerRadius = 5
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        SaveButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SaveButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
    }
   
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .MainMenu
                
            }
            
        }
    }

}
