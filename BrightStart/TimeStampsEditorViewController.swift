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
    
    @IBOutlet weak var TopThirdView: UIView!
    
    @IBOutlet weak var TargetPersonName: UILabel!
    @IBOutlet weak var TargetDate: UILabel!
    
    @IBOutlet weak var TargetCurrentTime: UILabel!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
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
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        TopThirdView.backgroundColor  = _ApplicatoinColours.BackGroundColour
        
        SaveTimeStamp.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SaveTimeStamp.tintColor = _ApplicatoinColours.ButtonForeGroundColor
        
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
        
        //Poisitioning the top third view
        TopThirdView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TopThirdView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 15).isActive = true
        //right
        TopThirdView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -15).isActive = true
        //top
        TopThirdView.topAnchor.constraint(
            equalTo: topLayoutGuide.bottomAnchor,  constant: 15).isActive = true
        
        TopThirdView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.30).isActive = true
        
       //Positioning the persons name
        
        TargetPersonName.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetPersonName.leadingAnchor.constraint(
            equalTo: TopThirdView.leadingAnchor).isActive = true
        //right
        TargetPersonName.trailingAnchor.constraint(
            equalTo: TopThirdView.trailingAnchor).isActive = true
        //top
        TargetPersonName.topAnchor.constraint(
            equalTo: TopThirdView.topAnchor).isActive = true
        
   
        
        
        
        //Positioning the current date
        
        TargetDate.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetDate.leadingAnchor.constraint(
            equalTo: TopThirdView.leadingAnchor).isActive = true
        
        //top
        TargetDate.topAnchor.constraint(
            equalTo: TargetPersonName.bottomAnchor).isActive = true
        
        //height
        TargetDate.heightAnchor.constraint(
            equalTo: TopThirdView.heightAnchor, multiplier: 0.20).isActive = true
        
        
        TargetDate.font.withSize(100)
        
        
        //Positioning the current time
        
        TargetCurrentTime.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetCurrentTime.trailingAnchor.constraint(
            equalTo: TopThirdView.trailingAnchor).isActive = true
        
        //top
        TargetCurrentTime.topAnchor.constraint(
            equalTo: TargetPersonName.bottomAnchor).isActive = true
        
        //height
        TargetCurrentTime.heightAnchor.constraint(
            equalTo: TopThirdView.heightAnchor, multiplier: 0.20).isActive = true

        
        TargetCurrentTime.font.withSize(100)
        
        
        
        
        
        //Positioning Date Time Picker
        
        DateTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        DateTimePicker.topAnchor.constraint(
            equalTo: TopThirdView.bottomAnchor).isActive = true
        
        //Center x
        DateTimePicker.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //height
        DateTimePicker.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        //Positioning Delete Button
        
        RemoveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        RemoveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
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
        
      
        
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        SaveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
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
        
        //Stlying remove button
        RemoveButton.layer.cornerRadius = 5
        RemoveButton.layer.borderWidth = 1
        RemoveButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        RemoveButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        RemoveButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        
        
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
                
                vc.images = [UIImage(named: "Search"), UIImage(named: "Edit"), UIImage(named: "Delete"), UIImage(named: "Home"), UIImage(named: "SignOut")]
                
                vc.segueIdList = ["GoToSearchPerson_Search", "GoToSearchPerson_Edit", "GoToSearchPerson_Delete", "GoToMainMenu", "GoToSignIn"]
                
                vc.DisplayTextList = ["Search",  "Edit", "Delete", "Home", "Sign Out"]
                
                vc.showNavigationBar = true
                
                vc.showNavigationBar = false
                
            }
            
        }
    }

}
