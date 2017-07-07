//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class SettingWeeklyRegisterdHours: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .dark)
       // UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Setting weekly regisred hours."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
            <<< LabelRow("Target"){
                $0.title = "This feature allows you set registered hours only a weekly basis."
                $0.cell.textLabel?.numberOfLines = 5
        }
        
        
        form +++ Section("How does it work?")
            <<< LabelRow("test"){
                $0.title = "To get started, smimply select the appropriate dates for each day of the week. Next select your children before clicking the button at the bottom of the page."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        
                form +++ Section("Select the year")
                    
                    <<< PickerInlineRow<String>("YearPicker") {
                        $0.title = "Year"
                        $0.options = [String(year-1), String(year), String(year+1)]
                        $0.value = String(year)    // initially selected
                    }

        form +++ Section("Select the month")
            
                    <<< PickerInlineRow<String>("MonthPicker") {
                        $0.title = "Month"
                        $0.options = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
                        $0.value = "January"    // initially selected
                    }
                    
        
                
        
            form +++ Section("")
            <<< SwitchRow("mondaySwitchRowTag"){
                $0.title = "Monday"
                }.cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
                    
                }
                
            <<< TimeRow("MondayStart"){
                
                $0.hidden = Condition.function(["mondaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "mondaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
                $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
            }
            
            <<< TimeRow("MondayEnd"){
                
                $0.hidden = Condition.function(["mondaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "mondaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
                $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
        }
        
        form +++ Section("")
            <<< SwitchRow("tuesdaySwitchRowTag"){
                $0.title = "Tuesday"
                }.cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
            }
            
            <<< TimeRow("TuesdayStart"){
                
                $0.hidden = Condition.function(["tuesdaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "tuesdaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
                $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
            }
            
            <<< TimeRow("TuesdayEnd"){
                
                $0.hidden = Condition.function(["tuesdaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "tuesdaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
                $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
                
        }
        
        form +++ Section("")
            <<< SwitchRow("wednesdaySwitchRowTag"){
                $0.title = "Wednesday"
                }.cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
            }
            <<< TimeRow("WednesdayStart"){
                
                $0.hidden = Condition.function(["wednesdaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "wednesdaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
                $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
                
            }
            
            <<< TimeRow("WednesdayEnd"){
                
                $0.hidden = Condition.function(["wednesdaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "wednesdaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
                $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
                
        }
        
        form +++ Section("")
            <<< SwitchRow("thursdaySwitchRowTag"){
                $0.title = "Thursday"
            }
                .cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
            }
            
            <<< TimeRow("ThursdayStart"){
                
                $0.hidden = Condition.function(["thursdaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "thursdaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
                $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
                
            }
            
            <<< TimeRow("ThursdayEnd"){
                
                $0.hidden = Condition.function(["thursdaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "thursdaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
                $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
                
        }
        
        form +++ Section("")
            <<< SwitchRow("fridaySwitchRowTag"){
                $0.title = "Friday"
            }
                .cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
            }
            
            <<< TimeRow("FridayStart"){
                
                $0.hidden = Condition.function(["fridaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "fridaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
                $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
                
            }
            
            <<< TimeRow("FridayEnd"){
                
                $0.hidden = Condition.function(["fridaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "fridaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
               $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
                
        }
        
        form +++ Section("")
            <<< SwitchRow("saturdaySwwitchRowTag"){
                $0.title = "Saturday"
                }.cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
            }
            
            <<< TimeRow("SaturdayStart"){
                
                $0.hidden = Condition.function(["saturdaySwwitchRowTag"], { form in
                    return !((form.rowBy(tag: "saturdaySwwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
               $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
                
            }
            
            <<< TimeRow("SaturdayEnd"){
                
                $0.hidden = Condition.function(["saturdaySwwitchRowTag"], { form in
                    return !((form.rowBy(tag: "saturdaySwwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
                $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
                
        }
        
        
        form +++ Section("")
            <<< SwitchRow("sundaySwitchRowTag"){
                $0.title = "Sunday"
                }.cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
            }
            
            <<< TimeRow("SundayStart"){
                
                $0.hidden = Condition.function(["sundaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "sundaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "Start"
               $0.value = Date().setTime(hour: 08, min: 0, sec: 0)!
                
            }
            
            <<< TimeRow("SundayEnd"){
                
                $0.hidden = Condition.function(["sundaySwitchRowTag"], { form in
                    return !((form.rowBy(tag: "sundaySwitchRowTag") as? SwitchRow)?.value ?? false)
                })
                
                $0.title = "End"
                $0.value = Date().setTime(hour: 18, min: 0, sec: 0)!
        }
        
        //Retrieve all children
        ChildRequests.sharedInstance.GetAllEnrolledChilren(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let child = BrightStartChild()
                
                child.ChildFullName = JSON["ChildFullName"].stringValue as NSString
                child.ChildId = JSON["ChildId"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let dateOfBirth = JSON["ChildDOB"].stringValue
                
                var newDate = dateFormatter.date(from: dateOfBirth)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: dateOfBirth)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                child.ChildDOB = newDate!
                
                self.childrenArray.append(child)
            }
            
            DispatchQueue.main.async(execute: {
                
                let fullChildList = Dictionary(keyValuePairs: self.childrenArray.map{($0.ChildId, $0.ChildFullName)})
                self.form +++ Section("Selected Children")
                    <<< MultipleSelectorRow<String>("SelectedChildren") { row in
                        row.title = "Children"
                        row.options = self.childrenArray.map { ($0.ChildFullName as String) }
                        
                        }.onPresent { from, to in
                            to.selectableRowCellUpdate = { cell, row in
                                cell.backgroundColor = StyleManager.theme2()
                            }
                }
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Create Registerd Hours"
                        }.onCellSelection {  cell, row in
                            
                            let mulitpleRow: MultipleSelectorRow<String> = self.form.rowBy(tag: "SelectedChildren")!
                            
                            let ids = self._CommonHelper.GetKeysFromValues(dictionary: fullChildList as Dictionary<String, String>, selectedArray: mulitpleRow.value!)
                            
                            var switchRow: SwitchRow? = self.form.rowBy(tag: "mondaySwitchRowTag")
                            
                            var row: TimeRow? = self.form.rowBy(tag: "MondayStart")
                            
                            let mondaySelected = (switchRow?.value == nil) ? false : true
                            let mondayStartTime = row?.value
                            
                            let ModayStart = (mondaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: mondayStartTime!) : ""
                            
                            row = self.form.rowBy(tag: "MondayEnd")
                            let ModayEnd = (mondaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            switchRow = self.form.rowBy(tag: "tuesdaySwitchRowTag")
                            let tuesdaySelected = (switchRow?.value == nil) ? false : true
                            
                            row = self.form.rowBy(tag: "TuesdayStart")
                            let TuesdayStart = (tuesdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            row = self.form.rowBy(tag: "TuesdayEnd")
                            let TuesdayEnd = (tuesdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            switchRow = self.form.rowBy(tag: "wednesdaySwitchRowTag")
                            let wednesdaySelected = (switchRow?.value == nil) ? false : true
                            
                            row = self.form.rowBy(tag: "WednesdayStart")
                            let WednesdayStart = (wednesdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            row = self.form.rowBy(tag: "WednesdayEnd")
                            let WednesdayEnd = (wednesdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            switchRow = self.form.rowBy(tag: "thursdaySwitchRowTag")
                            let thurdaySelected = (switchRow?.value == nil) ? false : true
                            
                            row = self.form.rowBy(tag: "ThursdayStart")
                            let ThursdayStart = (thurdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            row = self.form.rowBy(tag: "ThursdayEnd")
                            let ThursdayEnd = (thurdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            switchRow = self.form.rowBy(tag: "fridaySwitchRowTag")
                            let fridaySelected = (switchRow?.value == nil) ? false : true
                            
                            row = self.form.rowBy(tag: "FridayStart")
                            let FridayStart = (fridaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            row = self.form.rowBy(tag: "FridayEnd")
                            let FridayEnd = (fridaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            switchRow = self.form.rowBy(tag: "saturrdaySwitchRowTag")
                            let saturdaySelected = (switchRow?.value == nil) ? false : true

                            row = self.form.rowBy(tag: "SaturdayStart")
                            let SaturdayStart = (saturdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            row = self.form.rowBy(tag: "SaturdayEnd")
                            let SaturdayEnd = (saturdaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            switchRow = self.form.rowBy(tag: "sundaySwitchRowTag")
                            let sundaySelected = (switchRow?.value == nil) ? false : true

                            row = self.form.rowBy(tag: "SundayStart")
                            let SundayStart = (sundaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                            
                            row = self.form.rowBy(tag: "SundayEnd")
                            let SundayEnd = (sundaySelected) ? self._CommonHelper.GetTimeAsStringFromDate(targetDate: (row?.value)! as Date) : ""
                           
                            let year: PickerInlineRow<String>? = self.form.rowBy(tag: "YearPicker")
                            let month: PickerInlineRow<String>? = self.form.rowBy(tag: "MonthPicker")
                           
                            let monthAsInt = self._CommonHelper.GetMonthAsInt(monthAsString: (month?.value)!)
                            
                            self.SetWeeklyRegisterdHours(targetChildren: ids, chosenYear: (year?.value)!, chosenMonth: String(monthAsInt), mondayStartTime: ModayStart, mondayEndTime: ModayEnd, tuesdayStartTime: TuesdayStart, tuesdayEndTime: TuesdayEnd, wednesdayStartTime: WednesdayStart, wednesdayEndTime: WednesdayEnd, thursdayStartTime: ThursdayStart, thursdayEndTime: ThursdayEnd, fridayStartTime: FridayStart, fridayEndTime: FridayEnd, saturdayStartTime: SaturdayStart, saturdayEndTime: SaturdayEnd, sundayStartTime: SundayStart, sundayEndTime: SundayEnd)
                            
                        }.cellUpdate
                        {
                    cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 70 }
                }
                
            })
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .RegisteredHours
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        SetNavigationBarDetails()
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
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
        
        self.navigationItem.title = "Weekly Registered Hours"
        
    }
    
    
    func SetWeeklyRegisterdHours(targetChildren: [String], chosenYear: String, chosenMonth: String,mondayStartTime : String, mondayEndTime : String,tuesdayStartTime : String, tuesdayEndTime : String,wednesdayStartTime : String, wednesdayEndTime : String, thursdayStartTime : String, thursdayEndTime : String,fridayStartTime : String, fridayEndTime : String, saturdayStartTime : String, saturdayEndTime : String, sundayStartTime : String, sundayEndTime : String)
    {
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        PerformSetWeeklyRegisteredHoursRecursively(targetChildren: targetChildren, chosenYear: chosenYear, chosenMonth: chosenMonth, mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime, onCompletion: { json in
            
            DispatchQueue.main.async(execute: {
                
                SVProgressHUD.dismiss(withDelay: 1, completion: {
                    self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                    
                } )
                
                
            })
        })
        
    }
    
    func PerformSetWeeklyRegisteredHoursRecursively(targetChildren: [String], chosenYear: String, chosenMonth: String,mondayStartTime : String, mondayEndTime : String,tuesdayStartTime : String, tuesdayEndTime : String,wednesdayStartTime : String, wednesdayEndTime : String, thursdayStartTime : String, thursdayEndTime : String,fridayStartTime : String, fridayEndTime : String, saturdayStartTime : String, saturdayEndTime : String, sundayStartTime : String, sundayEndTime : String, onCompletion: @escaping () -> Void)
    {
        
        var childrenList = targetChildren
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        RegistrationHoursRequests.sharedInstance.SetWeeklyRegisteredHours(targetChildren: lastItem as! [String], chosenYear: String(chosenYear)!, chosenMonth: String(chosenMonth)!, mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Remove the guy we just completed
                    childrenList.removeLast()
                    
                    //Check if we are all done!
                    if(childrenList.count == 0)
                    {
                        onCompletion()
                        
                        return
                    }
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: String(childrenList.count) + " more to go!")
                    
                    //Do the next
                    self.PerformSetWeeklyRegisteredHoursRecursively(targetChildren: childrenList, chosenYear: String(chosenYear), chosenMonth: String(chosenMonth), mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime, onCompletion: onCompletion)
                    
                })
        })
        
    }
    
    func RollOver(targetChildren: [String], targetYear: String, targetMonth: String, destinationYear: String, destinationMonth: String)
    {
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        PerformRollOverRecursively(targetChildren: targetChildren, targetYear: String(targetYear), targetMonth: String(targetMonth), destinationYear: String(destinationYear), destinationMonth: String(destinationMonth),  onCompletion: { json in
            
            DispatchQueue.main.async(execute: {
                
                SVProgressHUD.dismiss(withDelay: 1, completion: {
                    //self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                } )
            })
        })
    }
    
    func PerformRollOverRecursively(targetChildren: [String], targetYear: String, targetMonth: String, destinationYear: String, destinationMonth: String, onCompletion: @escaping () -> Void)
    {
        var childrenList = targetChildren
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        RegistrationHoursRequests.sharedInstance.RollOverRegisteredHours(targetChildren: lastItem as! [String], targetYear: String(targetYear)!, targetMonth: String(targetMonth)!, destinationYear: String(destinationYear)!, destinationMonth: String(destinationMonth)!, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Remove the guy we just completed
                    childrenList.removeLast()
                    
                    //Check if we are all done!
                    if(childrenList.count == 0)
                    {
                        onCompletion()
                        
                        return
                    }
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: String(childrenList.count) + " more to go!")
                    
                    //Do the next
                    self.PerformRollOverRecursively(targetChildren: childrenList, targetYear: targetYear, targetMonth: targetMonth, destinationYear: destinationYear, destinationMonth: destinationMonth, onCompletion: onCompletion)
                    
                })
        })
        
    }
    
    
}

