//
//  AddRegisteredHoursViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 21/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AddRegisteredHoursViewController: UIViewController {

    var personName = "";
    var personId = "";
    var targetDate = NSDate()
    
    var targetDateAsText = "";
    
    var selectedStartTime = NSDate()
    var selectedEndTime = NSDate()
    
    @IBOutlet weak var StartLabel: UILabel!
    @IBOutlet weak var FinishLabel: UILabel!
    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var MiddleLeftContainer: UIView!
    @IBOutlet weak var StartDatePicker: UIDatePicker!
    @IBOutlet weak var EndDatePicker: UIDatePicker!
    @IBOutlet weak var MiddleRightContainer: UIView!
    
    @IBOutlet weak var BottomContainer: UIView!
    @IBOutlet weak var SaveButton: UIButton!
    
    var loadingSpiiner: ProgressHUD!
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateLabel.text = targetDateAsText
        NameLabel.text = personName
            
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        loadingSpiiner = ProgressHUD(text: "Loading")
        self.view.addSubview(loadingSpiiner)
        hideSpinner()
        
       // MiddleRightContainer.addSubview(EndDatePicker)
        
        //Stlying save button
        SaveButton.layer.cornerRadius = 5
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        SaveButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SaveButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)

        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleRightContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleLeftContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        setupConstraints()
        
       StartDatePicker.datePickerMode = UIDatePickerMode.time
        EndDatePicker.datePickerMode = UIDatePickerMode.time

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSpinner()
    {
        loadingSpiiner.show()
    }
    
    func hideSpinner()
    {
        //if(loadingSpiiner!=nil){
        loadingSpiiner.hide()
        //}
    }

     func setupConstraints() {
    
    //Top
    
    TopContainer.translatesAutoresizingMaskIntoConstraints = false
    
    //left
    TopContainer.leadingAnchor.constraint(
    equalTo: view.leadingAnchor).isActive = true
        
    //right
    TopContainer.trailingAnchor.constraint(
    equalTo: view.trailingAnchor).isActive = true
    
    //top
    TopContainer.topAnchor.constraint(
    equalTo: view.topAnchor).isActive = true
    
    TopContainer.heightAnchor.constraint(
    equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        
        
        //DateLabel
        
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        DateLabel.leadingAnchor.constraint(
            equalTo: TopContainer.leadingAnchor).isActive = true

        DateLabel.topAnchor.constraint(
            equalTo: TopContainer.topAnchor).isActive = true
        
        
        
        //NameLabel
        
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        NameLabel.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor).isActive = true
        
        NameLabel.topAnchor.constraint(
            equalTo: TopContainer.topAnchor).isActive = true
        
        
        //Middle left
        
        MiddleLeftContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        MiddleLeftContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //top
        MiddleLeftContainer.topAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        MiddleLeftContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        
        MiddleLeftContainer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        
        //START DATEPICKER
        
        StartDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        StartDatePicker.centerXAnchor.constraint(
            equalTo: MiddleLeftContainer.centerXAnchor).isActive = true
        
        //top
        StartDatePicker.centerYAnchor.constraint(
            equalTo: MiddleLeftContainer.centerYAnchor).isActive = true
        
        StartDatePicker.widthAnchor.constraint(
            equalTo: MiddleLeftContainer.widthAnchor).isActive = true

        StartDatePicker.heightAnchor.constraint(
            equalTo: MiddleLeftContainer.heightAnchor).isActive = true
        

        
        
        
        
        //StartLabel
        
        StartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        StartLabel.leadingAnchor.constraint(
            equalTo: TopContainer.leadingAnchor).isActive = true
        
        StartLabel.bottomAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        //FinishLabel
        
        FinishLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        FinishLabel.leadingAnchor.constraint(
            equalTo: MiddleLeftContainer.trailingAnchor).isActive = true
        
        FinishLabel.bottomAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        
        
        //Middle Right
        
        MiddleRightContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        MiddleRightContainer.leadingAnchor.constraint(
            equalTo: MiddleLeftContainer.trailingAnchor).isActive = true
        
        //right
        MiddleRightContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        MiddleRightContainer.topAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        MiddleRightContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        
       
        
        //END DATEPICKER
        
        EndDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        EndDatePicker.centerXAnchor.constraint(
            equalTo: MiddleRightContainer.centerXAnchor).isActive = true
        
        //top
        EndDatePicker.centerYAnchor.constraint(
           equalTo: MiddleRightContainer.centerYAnchor).isActive = true
        
       EndDatePicker.widthAnchor.constraint(
            equalTo: MiddleRightContainer.widthAnchor).isActive = true

        EndDatePicker.heightAnchor.constraint(
           equalTo: MiddleRightContainer.heightAnchor).isActive = true
        
        
         EndDatePicker.topAnchor.constraint(
           equalTo: MiddleRightContainer.topAnchor).isActive = true
        
        EndDatePicker.bottomAnchor.constraint(
            equalTo: MiddleRightContainer.bottomAnchor).isActive = true
        
        

        
        
        
        //Bottom
        
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        BottomContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        BottomContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        BottomContainer.topAnchor.constraint(
            equalTo: MiddleRightContainer.bottomAnchor).isActive = true
        
        //bottom
        BottomContainer.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        
        
        
        //SaveButton
        
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        //top
        SaveButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        //bottom
        SaveButton.bottomAnchor.constraint(
            equalTo: BottomContainer.bottomAnchor).isActive = true
        
        SaveButton.widthAnchor.constraint(
            equalTo: BottomContainer.widthAnchor, multiplier: 0.50).isActive = true

        
    
    }
   
    @IBAction func SaveButtonClicked(_ sender: Any) {
        
        selectedStartTime = StartDatePicker.date as NSDate
        selectedEndTime = EndDatePicker.date as NSDate

        self.showSpinner()
        
        RegistrationHoursRequests.sharedInstance.CreateRegisteredHours(personId: personId, startTime: selectedStartTime, finishTime: selectedEndTime, onCompletion: { (JSON) in
            
            self.hideSpinner()
            
        })
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
                
                vc.selectedMenu = .MainMenu
                
            }
            
        }
    }
}


