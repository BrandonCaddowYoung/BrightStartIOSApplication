//
//  TimeStampsEditorViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit
import SVProgressHUD

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
    
    var GoToMenuType: MenuTypes!
    
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var successIdentifier = ""
    var goBackOnSuccess = false
    var showNavigationBar = true
    
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
  
    @IBOutlet weak var HorizontalDivider: UIView!
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var MiddleContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var CurrentTimeLabel: UILabel!
    @IBOutlet weak var CurrentDateLabel: UILabel!
    
    @IBOutlet weak var SetYourNewTimeStampLabel: UILabel!
    
    @IBOutlet weak var TargetPersonName: UILabel!
    @IBOutlet weak var TargetDate: UILabel!
    
    @IBOutlet weak var TargetCurrentTime: UILabel!
    
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var RemoveButton: UIButton!
   
    @IBAction func Save(_ sender: Any) {
        
        if(EditorMode == .TimeStamps_Edit){
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            CommonRequests.sharedInstance.updateTimeStamp(personId: PersonId!, action: Action!, stamp: (DateTimePicker.date as NSDate) as Date, originalAction: Action!, originalTimeStamp: DateAsObject as NSDate,
                                                          
                                                          onCompletion: {
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                
                                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                                                                    
                                                                    if(self.goBackOnSuccess){
                                                                        if let nav = self.navigationController {
                                                                            nav.popViewController(animated: true)
                                                                        } else {
                                                                            self.dismiss(animated: true, completion: nil)
                                                                        }
                                                                    }
                                                                    else{
                                                                        
                                                                        if(self.successIdentifier != "")
                                                                        {
                                                                            self.performSegue(withIdentifier: self.successIdentifier, sender: nil)
                                                                        }
                                                                        else{
                                                                        
                                                                        self.GoToMenuType = .MainMenu
                                                                        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                                                                        
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                } )
                                                            })
            })
            
        }
        else if(EditorMode == .RegisteredHours_Edit){
            
            //Make API call to update time stamp and then return to the time stamps menu.
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            //var originalDateValue = NSDate()
            var newStartValue = NSDate()
            var newEndValue = NSDate()
            
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
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                    
                    if(self.goBackOnSuccess){
                        if let nav = self.navigationController {
                            nav.popViewController(animated: true)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    else{
                        
                        self.GoToMenuType = .MainMenu
                        
                        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                    }
                    
                     } )
                   
                    
                })
            })
            
        }else if(EditorMode == .RegisteredHours_Create){
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            //Change to to creating registered hours
            RegistrationHoursRequests.sharedInstance.CreateRegisteredHours(personId: PersonId!, startTime: (DateTimePicker.date as NSDate) as Date, finishTime: (DateTimePicker.date as NSDate) as Date, onCompletion: {_ in
                
                DispatchQueue.main.async(execute: {
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        
                        self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                        
                        if(self.goBackOnSuccess){
                            if let nav = self.navigationController {
                                nav.popViewController(animated: true)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        else{
                            
                            self.GoToMenuType = .MainMenu
                            
                            self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                        }
                        
                        
                    } )
                })
            })
            
        }
        else if(EditorMode == .TimeStamps_Create){
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            //Change to to creating time stamps
            CommonRequests.sharedInstance.createTimeStamp(personId: PersonId!, action: Action!, stamp: (DateTimePicker.date as NSDate) as Date,
                                                          onCompletion: {
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                
                                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                    
                                                                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                                                                    
                                                                    if(self.goBackOnSuccess){
                                                                        
                                                                        if let nav = self.navigationController {
                                                                            nav.popViewController(animated: true)
                                                                        } else {
                                                                            self.dismiss(animated: true, completion: nil)
                                                                        }
                                                                        
                                                                    }
                                                                    else{
                                                                        self.GoToMenuType = .MainMenu
                                                                        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                                                                    }
                                                                    
                                                                } )
                                                            })
            })
        }

        
    }
   
    
    @IBAction func RemoveStamp(_ sender: Any) {
        
        //Make API call to delete time stamp and then return to the time stamps menu.
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        CommonRequests.sharedInstance.deleteTimeStamp(personId: PersonId!, action: Action!, stamp: (DateTimePicker.date as NSDate) as Date,
                                                      
                                                      onCompletion: {
                                                        
                                                        DispatchQueue.main.async(execute: {
                                                            
                                                            
                                                            
                                                            
                                                            SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                
                                                                self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                                                                
                                                                if(self.goBackOnSuccess){
                                                                    if let nav = self.navigationController {
                                                                        nav.popViewController(animated: true)
                                                                    } else {
                                                                        self.dismiss(animated: true, completion: nil)
                                                                    }
                                                                }
                                                                else{
                                                                    
                                                                    self.GoToMenuType = .MainMenu
                                                                    
                                                                    self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                                                                }
                                                                
                                                                
                                                            } )
                                                            
                                                            
                                                            
                                                        })
        })
        

        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        setupConstraints()
        
        view.backgroundColor = StyleManager.DarkBackground()
        
        TargetPersonName.text = Name
        TargetPersonName.font = _ApplicatoinColours.largeFont
        TargetPersonName.textColor = StyleManager.FontColour()
        
        TargetDate.text = Date
        TargetDate.font = _ApplicatoinColours.largeFont
        TargetDate.textColor = StyleManager.FontColour()
        
        TargetCurrentTime.text = Time
        TargetCurrentTime.font = _ApplicatoinColours.largeFont
        TargetCurrentTime.textColor = StyleManager.FontColour()
        
        CurrentTimeLabel.font = _ApplicatoinColours.mediumFont
        CurrentTimeLabel.textColor = StyleManager.theme4()
        
        CurrentDateLabel.font = _ApplicatoinColours.mediumFont
        CurrentDateLabel.textColor = StyleManager.theme4()
        
        SetYourNewTimeStampLabel.font = _ApplicatoinColours.mediumFont
        SetYourNewTimeStampLabel.textColor = StyleManager.theme1()
        
        DateTimePicker.date = DateAsObject
        DateTimePicker.datePickerMode = UIDatePickerMode.time
        
        HorizontalDivider.backgroundColor = StyleManager.theme4()
        
        TopContainer.backgroundColor = StyleManager.DarkBackground()
        MiddleContainer.backgroundColor = StyleManager.theme2()
        BottomContainer.backgroundColor = StyleManager.DarkBackground()
        
        if(EditorMode == .RegisteredHours_Create || EditorMode == .TimeStamps_Create ){
            RemoveButton.isHidden = true
            
            CurrentTimeLabel.isHidden = true;
            TargetCurrentTime.isHidden = true

        }
        else
        {
            CurrentTimeLabel.isHidden = false;
            TargetCurrentTime.isHidden = false
        }
        
        //Should check if child has reg hours for this date
        
        fetchRegisteredHours()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchRegisteredHours()
    {
        self.PersonId = self.PersonId.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        var noStartTime = false
        var noEndTime = false
        
        RegistrationHoursRequests.sharedInstance.GetRegisterdHoursyDateAndID(personId: self.PersonId as String, DateTime: DateAsObject as NSDate, onCompletion: { JSON in
            
            let regHours = RegistrationHours()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            //Start to stirng, then to date
            let StartTime = JSON["StartTime"].stringValue
            let newStartTime = dateFormatter.date(from: StartTime)
            
            if(newStartTime != nil){
                regHours.StartTime = newStartTime!
            }
            else{
                noStartTime = true
            }
            
            //End to stirng, then to date
            let endTime = JSON["FinishTime"].stringValue
            let newEndTime = dateFormatter.date(from: endTime)
            
            if(newEndTime != nil){
                regHours.FinishTime = newEndTime!
            }
            else{
                noEndTime = true
            }
            
            DispatchQueue.main.async(execute: {
                
                //If so default to that date.
                if(self.editType == .Start)
                {
                    if(noStartTime==false){
                     self.DateTimePicker.setDate(regHours.StartTime, animated: true)
                    }
                }
                else if(self.editType == .End)
                {
                    if(noEndTime==false){
                      self.DateTimePicker.setDate(regHours.FinishTime, animated: true)
                    }
                }
                
            })
            
        })
        
    }
    
    func setupConstraints() {
        
        self.edgesForExtendedLayout = []
        
        //Positioning the top container
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TopContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        //right
        TopContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        //top
        TopContainer.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //height
        TopContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.33).isActive = true
        
        //Positioning the persons name
        
        TargetPersonName.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetPersonName.leadingAnchor.constraint(
            equalTo: TopContainer.leadingAnchor, constant: 5).isActive = true
        
        //right
        TargetPersonName.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor, constant: -5).isActive = true
        
        //top
        TargetPersonName.topAnchor.constraint(
            equalTo: TopContainer.topAnchor, constant: 10).isActive = true
        
        //height
        TargetPersonName.heightAnchor.constraint(
            equalTo: TopContainer.heightAnchor,
            multiplier : 0.20).isActive = true
        
    //Positioning the divider
        
        HorizontalDivider.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        HorizontalDivider.leadingAnchor.constraint(
            equalTo: TopContainer.leadingAnchor, constant: 5).isActive = true
        
        //right
        HorizontalDivider.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor, constant: -5).isActive = true
        
        //top
        HorizontalDivider.topAnchor.constraint(
            equalTo: TargetPersonName.bottomAnchor, constant: 10).isActive = true
        
        //height
        HorizontalDivider.heightAnchor.constraint(
            equalToConstant: 1).isActive = true
        
        
        //CURRENT TIME LABEL
        
        CurrentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        CurrentTimeLabel.leadingAnchor.constraint(
            equalTo: TargetPersonName.leadingAnchor).isActive = true
        
        //top
        CurrentTimeLabel.topAnchor.constraint(
            equalTo: HorizontalDivider.bottomAnchor, constant: 10).isActive = true
        
        //height
        CurrentTimeLabel.heightAnchor.constraint(
            equalToConstant: 15).isActive = true
        
        
       
       
        
        
        
        
        
        
        
        
        //CURRENT DATE LABEL
        
        CurrentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        CurrentDateLabel.leadingAnchor.constraint(
            equalTo: CurrentTimeLabel.trailingAnchor).isActive = true
        
        //top
        CurrentDateLabel.topAnchor.constraint(
            equalTo: CurrentTimeLabel.topAnchor).isActive = true
        
        //height
        CurrentDateLabel.heightAnchor.constraint(
            equalToConstant: 15).isActive = true
        
        CurrentDateLabel.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor).isActive = true
        
        
        
        
        //CURRENT TIME
        
        
        TargetCurrentTime.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetCurrentTime.leadingAnchor.constraint(
            equalTo: CurrentTimeLabel.leadingAnchor).isActive = true
        //top
        TargetCurrentTime.topAnchor.constraint(
            equalTo: CurrentTimeLabel.bottomAnchor).isActive = true
        
        //height
        TargetCurrentTime.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        //Positioning the current time
        
        TargetDate.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        TargetDate.leadingAnchor.constraint(
            equalTo: CurrentDateLabel.leadingAnchor).isActive = true
        
        //top
        TargetDate.topAnchor.constraint(
            equalTo: CurrentDateLabel.bottomAnchor).isActive = true
        
        //height
        TargetDate.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        TargetDate.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor).isActive = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        MiddleContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        MiddleContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        //right
        MiddleContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        //top
        MiddleContainer.topAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        //height
        MiddleContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier : 0.33).isActive = true
        
        
        //Positioning Date Time Picker
        
        DateTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        //Center x
        DateTimePicker.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Center y
        DateTimePicker.centerYAnchor.constraint(
            equalTo: MiddleContainer.centerYAnchor).isActive = true
        
        DateTimePicker.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor, multiplier: 0.70).isActive = true
        
        DateTimePicker.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor, multiplier: 0.70).isActive = true
        
        //Positioning label above the date picker
        
        SetYourNewTimeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        
        SetYourNewTimeStampLabel.leadingAnchor.constraint(
            equalTo: MiddleContainer.leadingAnchor, constant: 5).isActive = true
        
        SetYourNewTimeStampLabel.trailingAnchor.constraint(
            equalTo: MiddleContainer.trailingAnchor).isActive = true
        
        SetYourNewTimeStampLabel.topAnchor.constraint(
            equalTo: MiddleContainer.topAnchor, constant: 5).isActive = true
        
        SetYourNewTimeStampLabel.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor,
            multiplier : 0.10).isActive = true
        
        
        
        
        
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        BottomContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        //right
        BottomContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -5).isActive = true
        
        //top
        BottomContainer.topAnchor.constraint(
            equalTo: MiddleContainer.bottomAnchor).isActive = true
        
        //Bottom
        BottomContainer.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //Positioning Delete Button
        
        RemoveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        RemoveButton.leadingAnchor.constraint(
            equalTo: BottomContainer.leadingAnchor, constant: 5).isActive = true
        
        //right
        RemoveButton.trailingAnchor.constraint(
            equalTo: BottomContainer.trailingAnchor, constant: -5).isActive = true
        
        //bottom
        RemoveButton.bottomAnchor.constraint(
            equalTo: BottomContainer.bottomAnchor, constant: -10).isActive = true
        
        //Positioning Save Button
        
        //Stlying remove button
        RemoveButton.layer.cornerRadius = 5
        RemoveButton.layer.borderWidth = 1
        RemoveButton.layer.borderColor = UIColor.red.cgColor
        RemoveButton.backgroundColor = StyleManager.theme2()
       
        RemoveButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        RemoveButton.setTitleColor(.red, for: .normal)
        
        RemoveButton.heightAnchor.constraint(
            equalTo: BottomContainer.heightAnchor,
            multiplier : 0.30).isActive = true
        
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //height
        //SaveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        SaveButton.heightAnchor.constraint(
            equalTo: BottomContainer.heightAnchor,
            multiplier : 0.30).isActive = true
        
        //left
        SaveButton.leadingAnchor.constraint(
            equalTo: BottomContainer.leadingAnchor, constant: 5).isActive = true
        
        //right
        SaveButton.trailingAnchor.constraint(
            equalTo: BottomContainer.trailingAnchor, constant: -5).isActive = true
        
        //bottom
        SaveButton.bottomAnchor.constraint(
            equalTo: RemoveButton.topAnchor, constant: -10).isActive = true
        
        //Stlying save button
        SaveButton.layer.cornerRadius = 5
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.borderColor = StyleManager.FontColour().cgColor
        SaveButton.backgroundColor = StyleManager.buttonBackGround()
        
        SaveButton.setTitleColor(StyleManager.buttonForeGround(), for: .normal)
        
        SaveButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        
        

        
        
        

    }
   
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                if(self.GoToMenuType == .RegisteredHours){
                    vc.selectedMenu = .RegisteredHours
                }
                else if(self.GoToMenuType == .TimeStamps)
                {
                    vc.selectedMenu = .TimeStamps
                }
                
            }
            
        }
        
        else if (segue.identifier == "GoToExtraMinutesFinder") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.targetDate = (DateAsObject as NSDate) as Date!
                
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                vc.successSegueIdentifier = "GoToTimeStampSearch"
                
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
        
        if(EditorMode == .TimeStamps_Edit){
        self.GoToMenuType = .TimeStamps
        }
        else if(EditorMode == .RegisteredHours_Edit){
            self.GoToMenuType = .RegisteredHours
        }
        
                 self.performSegue(withIdentifier: "GoToMenu", sender: nil)
        
    }

    
    func SetNavigationBarDetails()
    {
        self.navigationController?.navigationBar.topItem?.title = " "
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.NavigationBarBackButton()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
        self.navigationItem.title="Time Stamps Editor"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            
           SetNavigationBarDetails()
            
        }
        
    }
    
}
