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
    
    var showNavigationBar = true
    
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
        
       StartDatePicker.date = targetDate as Date
        StartDatePicker.date = StartDatePicker.date.setTime(hour: 08, min: 0, sec: 0)!
        
      EndDatePicker.date = targetDate as Date
       EndDatePicker.date = EndDatePicker.date.setTime(hour: 18, min: 0, sec: 0)!
        
        EndDatePicker.addTarget(self, action: #selector(endDatePickerChanged(sender:)), for: .valueChanged)
        StartDatePicker.addTarget(self, action: #selector(startDatePickerChanged(sender:)), for: .valueChanged)
        
        DateLabel.text = targetDateAsText
        NameLabel.text = personName
        
        NameLabel.adjustsFontSizeToFitWidth = true
        NameLabel.minimumScaleFactor = 0.2
        NameLabel.textAlignment = .left
        
        DateLabel.adjustsFontSizeToFitWidth = true
        DateLabel.minimumScaleFactor = 0.2
        DateLabel.textAlignment = .right
        
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

        SaveButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleRightContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleLeftContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        setupConstraints()
        
       StartDatePicker.datePickerMode = UIDatePickerMode.time
        EndDatePicker.datePickerMode = UIDatePickerMode.time

        
        // Do any additional setup after loading the view.
    }

    func startDatePickerChanged(sender: UIDatePicker) {
        
        if(sender.date >= EndDatePicker.date)
        {
            var components = DateComponents()
            components.minute = 1
            let startTimePLusAMinute = Calendar.current.date(byAdding: components, to: sender.date)
            EndDatePicker.date = startTimePLusAMinute!
        }
        
    }
    
    func endDatePickerChanged(sender: UIDatePicker) {
        
        if(sender.date <= StartDatePicker.date)
        {
            var components = DateComponents()
            components.minute = -1
            let endTimeMinusAMinute = Calendar.current.date(byAdding: components, to: sender.date)
            StartDatePicker.date = endTimeMinusAMinute!
        }
        
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
        
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        NameLabel.leadingAnchor.constraint(
            equalTo: TopContainer.leadingAnchor, constant: 5).isActive = true

        //top
        NameLabel.topAnchor.constraint(
            equalTo: TopContainer.topAnchor, constant: 5).isActive = true
        
        NameLabel.widthAnchor.constraint(
            equalTo: TopContainer.widthAnchor, multiplier: 0.60).isActive = true
        
        //NameLabel
        
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        DateLabel.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor, constant: -5).isActive = true
        
        DateLabel.topAnchor.constraint(
            equalTo: TopContainer.topAnchor, constant: 5).isActive = true
        
        DateLabel.widthAnchor.constraint(
            equalTo: TopContainer.widthAnchor, multiplier: 0.30).isActive = true
        
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
            equalTo: TopContainer.leadingAnchor, constant: 10).isActive = true
        
        StartLabel.bottomAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        //FinishLabel
        
        FinishLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        FinishLabel.leadingAnchor.constraint(
            equalTo: MiddleLeftContainer.trailingAnchor, constant: 10).isActive = true
        
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
            equalTo: BottomContainer.bottomAnchor, constant: -10).isActive = true
        
       // SaveButton.widthAnchor.constraint(
         //   equalTo: BottomContainer.widthAnchor, multiplier: 0.50).isActive = true
        
        
       // SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        //SaveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        SaveButton.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.10).isActive = true
        
        //left
        SaveButton.leadingAnchor.constraint(
            equalTo: BottomContainer.leadingAnchor, constant: 5).isActive = true
        
        //right
        SaveButton.trailingAnchor.constraint(
            equalTo: BottomContainer.trailingAnchor, constant: -5).isActive = true
        
        //bottom
        //SaveButton.bottomAnchor.constraint(
          //  equalTo: RemoveButton.topAnchor, constant: -10).isActive = true
        
        //Stlying save button
        SaveButton.layer.cornerRadius = 5
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        SaveButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SaveButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        SaveButton.titleLabel?.font = _ApplicatoinColours.buttonFont
    }
   
    @IBAction func SaveButtonClicked(_ sender: Any) {
        
        selectedStartTime = StartDatePicker.date as NSDate
        selectedEndTime = EndDatePicker.date as NSDate

        self.showSpinner()
        
        RegistrationHoursRequests.sharedInstance.CreateRegisteredHours(personId: personId, startTime: selectedStartTime, finishTime: selectedEndTime, onCompletion: { (JSON) in
            
            self.hideSpinner()
            
            //self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
            
            //Always goes back when done but this could be optional?
            
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
                
                vc.selectedMenu = .MainMenu
                
            }
            
        }
    }
    
    //Removes the navigation bar from the top
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(false, animated: animated);
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(true, animated: animated);
        }
        
    }
    
    func NavBarMenuTapped(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {   
            //Changes the color of the backgorund within the nav bar.
            navigationController?.navigationBar.barStyle = UIBarStyle.black
            navigationController?.navigationBar.barTintColor = _ApplicatoinColours.Black
            
            //Title color
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.Black]
            navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
            
            //Back color
            navigationController?.navigationBar.tintColor = _ApplicatoinColours.NavigationBarBackBackButtonColor //Orange
            
            //Back ground color
            navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor // Grey
            
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            
            self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black
            
            navigationController?.navigationBar.backItem?.title = "Created Registered Hours."
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        
    }
    
}

extension Date {
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)
        
        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = min
        components.second = sec
        
        return cal.date(from: components)
    }
}


