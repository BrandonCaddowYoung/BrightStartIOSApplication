//
//  SettingRegistrationHours.swift
//  BrightStart
//
//  Created by Colleen Caddow on 07/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class EditTimeStamp: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    enum TimeStampEditerType: Int {
        case RegisteredHours_Create
        case RegisteredHours_Edit
        case TimeStamps_Create
        case TimeStamps_Edit
        case Missing_TimeStamps_Edit
    }
    
    enum EditTargetType: Int {
        case Start
        case End
    }
    
    var GoToMenuType: MenuTypes!
    
    //var _CommonHelper: CommonHelper!
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
    
  //  var showNavigationBar = true
    
    var selectedStartTime = NSDate()
    var selectedEndTime = NSDate()
    
    var targetRegisteredHours:Date!
    var noRegisteredHours = false
    
    var dateToUse:Date!
    
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
                
                if(noStartTime == true && noEndTime == true)
                {
                self.noRegisteredHours = true
                }
                
                //If so default to that date.
                if(self.editType == .Start)
                {
                    if(noStartTime==false){
                        // self.DateTimePicker.setDate(regHours.StartTime, animated: true)
                        self.targetRegisteredHours = regHours.StartTime
                    }
                }
                else if(self.editType == .End)
                {
                    if(noEndTime==false){
                        // self.DateTimePicker.setDate(regHours.FinishTime, animated: true)
                         self.targetRegisteredHours = regHours.FinishTime
                    }
                }
                
                
            })
            
        })
        
    }
    
    func Save(selectedTime: Date)
    {
        if(EditorMode == .TimeStamps_Edit || EditorMode == .Missing_TimeStamps_Edit){
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            CommonRequests.sharedInstance.updateTimeStamp(personId: PersonId!, action: Action!, stamp: selectedTime, originalAction: Action!, originalTimeStamp: DateAsObject as NSDate,
                                                          
                                                          onCompletion: {
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                
                                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                                                                    
                                                                    if(self.goBackOnSuccess == true){
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
                newStartValue = selectedTime as NSDate
            }
            else if(editType == .End)
            {
                newStartValue = existingStartDate as NSDate
                newEndValue = selectedTime as NSDate
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
            RegistrationHoursRequests.sharedInstance.CreateRegisteredHours(personId: PersonId!, startTime: (selectedTime) as Date, finishTime: (selectedTime) as Date, onCompletion: {_ in
                
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
            CommonRequests.sharedInstance.createTimeStamp(personId: PersonId!, action: Action!, stamp: selectedTime,
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
    
    func Remove(selectedTime: Date)
    {
        
        //Make API call to delete time stamp and then return to the time stamps menu.
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        CommonRequests.sharedInstance.deleteTimeStamp(personId: PersonId!, action: Action!, stamp: selectedTime,
                                                      
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

    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .light)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        var heading = ""
        
        if(self.EditorMode == .TimeStamps_Create)
        {
            heading = "Creating a new time stamp"
        }
        else if(self.EditorMode == .TimeStamps_Edit){
            
            heading = "Editing an existing time stamp"
        }
        else if(self.EditorMode == .RegisteredHours_Edit){
            
            heading = "Editing Registered Hours"
        }
        else if(self.EditorMode == .Missing_TimeStamps_Edit){
           heading = "Editing an existing time stamp"
        }
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = heading
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        var desctiption = ""
        
         if(self.EditorMode == .TimeStamps_Create)
        {
            desctiption = "Easily create a new time stamp for " + Name + " by simply selecting a time below before pressing the button to confirm at the bottom of the screen."
        }
        else if(self.EditorMode == .TimeStamps_Edit){
            
            desctiption = "Easily edit this time stamp for " + Name + " by simply selecting a new time below before pressing the button to confirm at the bottom of the screen."
        }
         else if(self.EditorMode == .RegisteredHours_Edit){
            
            desctiption = "Easily edit this registered hour for " + Name + " by simply selecting a new time below before pressing the button to confirm at the bottom of the screen."
        }
         else if(self.EditorMode == .Missing_TimeStamps_Edit){
            desctiption = "Easily edit this time stamp for " + Name + " by simply selecting a new time below before pressing the button to confirm at the bottom of the screen."
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            <<< LabelRow("Target"){
                $0.title = desctiption
                $0.cell.textLabel?.numberOfLines = 5
        }
        
        form +++ Section("Date")
            <<< LabelRow("test1"){
                $0.title = "Date"
                $0.value = DateAsObject.ToString()
            }
            
            <<< LabelRow("test2"){
                $0.title = "Name"
                $0.value = Name
                
        }
        
        
        //if(EditorMode == .Missing_TimeStamps_Edit || EditorMode == .TimeStamps_Edit){
          // fetchRegisteredHours()
        //}
        
       // if(EditorMode == .Missing_TimeStamps_Edit || EditorMode == .TimeStamps_Edit && noRegisteredHours == false){
         //   dateToUse = targetRegisteredHours
        //}
        //else
        //{
        dateToUse = DateAsObject
        //}
        
        form +++ Section("Select new time stamp")
            
            <<< TimePickerRow("TimePicker") {
                $0.title = "Start"
                $0.value = dateToUse
        }
        
        self.form +++ Section("")
            <<< ButtonRow(){
                
                $0.title = (EditorMode == .Missing_TimeStamps_Edit || EditorMode == .RegisteredHours_Create || EditorMode == .RegisteredHours_Edit || EditorMode == .TimeStamps_Create || EditorMode == .TimeStamps_Edit) ? "Save" : "Remove"
                }.onCellSelection {  cell, row in
                    
                    let row: TimePickerRow? = self.form.rowBy(tag: "TimePicker")
                    let selectedTime = row?.value
                    
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    //Saving....
                    
                    if(self.EditorMode == .RegisteredHours_Create || self.EditorMode == .RegisteredHours_Edit || self.EditorMode == .TimeStamps_Create || self.EditorMode == .TimeStamps_Edit || self.EditorMode == .Missing_TimeStamps_Edit){
                        self.Save(selectedTime: selectedTime!)
                                           }
                    else
                    {
                        self.Remove(selectedTime: selectedTime!)

                       
                    }
                }.cellUpdate
                {
                    cell, row in
                    cell.backgroundColor = StyleManager.theme1()
                    cell.textLabel?.textColor = StyleManager.theme2()
                    cell.height = { 100 }
        }
    }
    
        override func viewWillAppear(_ animated: Bool) {
            
            super.viewWillAppear(animated)
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            
            SetNavigationBarDetails()
            
        }
        
        
        func SetNavigationBarDetails()
        {
            //Title color(Center)
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
            navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
            
            navigationController?.navigationBar.tintColor = StyleManager.theme4()
            
            //Back ground color
            navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
            
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            //Right button
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
            
            if(self.EditorMode == .TimeStamps_Create)
            {
                self.navigationItem.title = "Time Stamps"
            }
            else if(self.EditorMode == .TimeStamps_Edit){
                
                self.navigationItem.title = "Time Stamps"
            }
            else if(self.EditorMode == .RegisteredHours_Edit){
                
                self.navigationItem.title = "Registered Hours"
            }
            else if(self.EditorMode == .Missing_TimeStamps_Edit){
                
                self.navigationItem.title = "Time Stamps"
            }
            
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
            
            if (segue.identifier == "GoToExtraMinutesFinder")
            {
                if let vc = segue.destination as? TimeStampSearchTableViewController {
                    
                    vc.TargetDate = DateAsObject
                    vc.TargetPersonId = PersonId as NSString!
                    vc.SelectedPersonFullName = Name as NSString!
                    
                    vc.OptionText = ""
                }
                
            }
            else if (segue.identifier == "GoToMenu") {
                
                if let vc = segue.destination as? MainMenuViewController {
                    
                    //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
                    
                    vc.selectedMenu = .RegisteredHours
                    
                }
                
            }
        }
        
    }


