//
//  TimeStampsEditorViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 29/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class TimeStampsEditorViewController: UIViewController {
    
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var Action:String!
    var PersonId:String!
    var Name:String!
    var Date:String!
    var DateAsObject:Date!
    var Time:String!
    
    @IBOutlet weak var DateLabelText: UILabel!
    
    @IBOutlet weak var TimeLabelText: UILabel!
    
    @IBOutlet weak var TargetPersonName: UILabel!
    @IBOutlet weak var TargetDate: UILabel!
    
    @IBOutlet weak var TargetCurrentTime: UILabel!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var PickerTitle: UILabel!
    
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var RemoveButton: UIButton!
    
    @IBOutlet weak var SaveTimeStamp: UIButton!
    @IBOutlet weak var RemoveTimeStamp: UIButton!
    
    @IBAction func SaveTimeStampTouched(_ sender: Any) {
    
        //Make API call to update time stamp and then return to the time stamps menu.
        
        let alert = self._CommonHelper.showOverlayMessage("Updating...")
        self.present(alert, animated: true, completion: nil)
        
        CommonRequests.sharedInstance.updateTimeStamp(personId: PersonId!, action: Action!, stamp: DateTimePicker.date as NSDate, originalAction: Action!, originalTimeStamp: DateAsObject as NSDate,
                                                     
                                              onCompletion: {
                                                
                                                DispatchQueue.main.async(execute: {
                                                    self.dismiss(animated: false, completion: {
                                                    
                                                        self.performSegue(withIdentifier: "GoToTimeStampList", sender: nil)
                                                    
                                                    })
                                                    
                                                })
        })
    }
    
    @IBAction func RemoveTimeStampTouched(_ sender: Any) {
        
        //Make API call to delete time stamp and then return to the time stamps menu.
        
        let alert = self._CommonHelper.showOverlayMessage("Removing...")
        self.present(alert, animated: true, completion: nil)
        
        CommonRequests.sharedInstance.deleteTimeStamp(personId: PersonId!, action: Action!, stamp: DateTimePicker.date as NSDate,
                                                      
                                                      onCompletion: {
                                                        
                                                        DispatchQueue.main.async(execute: {
                                                            self.dismiss(animated: false, completion: {
                                                                
                                                                self.performSegue(withIdentifier: "GoToTimeStampList", sender: nil)
                                                                
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
        
        TargetPersonName.text = Name
        TargetDate.text = Date
        TargetCurrentTime.text = Time
        DateTimePicker.date = DateAsObject
        
        DateTimePicker.datePickerMode = UIDatePickerMode.time
        
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
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToTimeStampList") {
            
            if let vc = segue.destination as? TimeStampsMenuController {
                
                vc.images = [UIImage(named: "Search"), UIImage(named: "Edit"), UIImage(named: "Delete"), UIImage(named: "Question"), UIImage(named: "SignOut")]
                
                vc.segueIdList = ["GoToSearchPerson_Search", "GoToSearchPerson_Edit", "GoToSearchPerson_Delete", "GoToSearchPerson_Missing", "GoToSignIn"]
                
                vc.DisplayTextList = ["Search",  "Edit", "Delete", "Missing Time Stamps", "Sign Out"]
                
                vc.showNavigationBar = true
                
            }
            
        }
    }

}
