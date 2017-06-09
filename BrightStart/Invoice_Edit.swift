//
//  Invoice_Edit.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Invoice_Edit: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var minutes = [String]()
    var hours = [String]()
   
    var targetChildName = String()
    var targetInvoiceId = String()
    var targetInvoice = Invoice()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for i in 0...60{
            minutes.append("\(i)")
        }
        
        for i in 0...1000{
            hours.append("\(i)")
        }
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .light)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Rates"
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
        }
      
        self.form +++ Section("General")
                    
                    <<< LabelRow("Name)") {
                        $0.title = "name"
                        $0.value = String(targetChildName)
                    }
                    
                    <<< LabelRow("InvoiceId)") {
                        $0.title = "invoice id"
                        $0.value = String(self.targetInvoice.InvoiceNumber)
                }
      
                +++ Section("Dates")
                    <<< DateInlineRow("DateOfIssue") {
                        $0.title = "issue date"
                        $0.value = Date(timeIntervalSinceReferenceDate: 0)
                }
               
                    <<< DateInlineRow("DueDate") {
                        $0.title = "due date"
                        $0.value =  Date() //?
                }
                
                    <<< DateInlineRow("StartDate") {
                        $0.title = "start date"
                        $0.value = self.targetInvoice.Start_Date
                }
                
                    <<< DateInlineRow("EndDate") {
                        $0.title = "end date"
                        $0.value = self.targetInvoice.End_Date
                }
                
                self.form +++ Section("Balance")
                    
                    <<< DecimalRow("OriginalInvouceBalance") {
                        $0.title = "original invoice balance"
                        $0.value = Double(self.targetInvoice.InvoiceTotal)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                        $0.disabled = true
                    }
                    
                    <<< DecimalRow("InvouceBalance") {
                        $0.title = "invoice balance(after payments)"
                        $0.value = Double(self.targetInvoice.InvoiceBalance)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                        $0.disabled = true
                }
        
                self.form +++ Section("Statistics")
                    
                    <<< IntRow("HalfDays") {
                        $0.title = "number of half days"
                        $0.value = self.targetInvoice.NumberOfFullHalfDays
                    }
                    
                    <<< IntRow("FullDays") {
                        $0.title = "number of full days"
                        $0.value = self.targetInvoice.NumberOfFullDays
                    }
        
                let (regHours,regMins,_) = self._CommonHelper.secondsToHoursMinutesSeconds(seconds: Int(self.targetInvoice.Registered_Time_Minutes * 60))
                
                    self.form +++ Section("Registerd Time")
                        
                        <<< PickerInlineRow<String>("RegistrationHours") {
                            $0.title = "Hours"
                            $0.options = self.hours
                            $0.value = self.hours[regHours]
                            
                        }
                        <<< PickerInlineRow<String>("RegistrationMinutes") {
                            $0.title = "Minutes"
                            $0.options = self.minutes
                            $0.value = self.minutes[regMins]
                        }
        
                 let (nonRegHours,nonRegMins,_) = self._CommonHelper.secondsToHoursMinutesSeconds(seconds: Int(self.targetInvoice.NonRegistered_Time_Minutes * 60))
                
                self.form +++ Section("Non-Registerd Time")
                    
                    <<< PickerInlineRow<String>("NonRegistrationHours") {
                        $0.title = "Hours"
                        $0.options = self.hours
                        $0.value = self.hours[nonRegHours]
                        
                    }
                    <<< PickerInlineRow<String>("NonRegistrationMinutes") {
                        $0.title = "Minutes"
                        $0.options = self.minutes
                         $0.value = self.minutes[nonRegMins]
                    }
                    
                    let (earlyHours,earlyMins,_) = self._CommonHelper.secondsToHoursMinutesSeconds(seconds: Int(self.targetInvoice.Early_Time_Minutes * 60))
                    
                self.form +++ Section("Early Time")
                    
                    <<< PickerInlineRow<String>("EarlyHours") {
                        $0.title = "Hours"
                        $0.options = self.hours
                         $0.value = self.hours[earlyHours]
                        
                    }
                    <<< PickerInlineRow<String>("EarlyMinutes") {
                        $0.title = "Minutes"
                        $0.options = self.minutes
                       $0.value = self.minutes[earlyMins]
                    }

                  let (lateHours,lateMins,_) = self._CommonHelper.secondsToHoursMinutesSeconds(seconds: Int(self.targetInvoice.Late_Time_Minutes * 60))
                
                self.form +++ Section("Late Time")
                    
                    <<< PickerInlineRow<String>("LateHours") {
                        $0.title = "Hours"
                        $0.options = self.hours
                        $0.value = self.hours[lateHours]
                    }
                    
                    <<< PickerInlineRow<String>("LateMinutes") {
                        $0.title = "Minutes"
                        $0.options = self.minutes
                         $0.value = self.minutes[lateMins]
                    }
        
                     self.form +++ Section("Qualification")
                        
                        <<< LabelRow("BusinessDays)") {
                            $0.title = "number of business days"
                            $0.value = String(self.targetInvoice.NumberOfBusinessDays)
                        }

                        
                        <<< LabelRow("FullTimeQualificationPoint)") {
                            $0.title = "full time qualification point"
                            $0.value = String(self.targetInvoice.NumberOfBusinessDays)
                        }
                        
        
                        <<< LabelRow("QualifcationStatus)") {
                            $0.title = "Qualificaiton Status"
                            
                            if(self.targetInvoice.IsFullTime){
                            $0.value = "Full Time"
                            }
                            else
                            {
                             $0.value = "Part Time"
                            }
                        }
                        
                        <<< SwitchRow("EnforceFullTime") {
                            $0.title = "enforce full time"
                            $0.value = self.targetInvoice.EnforceFullTime
                            }.cellSetup
                            {
                                cell,
                                row in cell.switchControl.onTintColor = StyleManager.theme1()
                                
                            }.onChange { row in
                                
                                if(row.value == true){
                                
                                let sRow: SwitchRow? = self.form.rowBy(tag: "EnforcePartTime")
                                sRow?.value = (row.value ?? false) ? false : true
                                sRow?.updateCell()
                                    
                                }
                            }
                
                        <<< SwitchRow("EnforcePartTime") {
                            $0.title = "enforce part time"
                            $0.value = self.targetInvoice.EnforcePartTime
                            }.cellSetup
                            {
                                cell,
                                row in cell.switchControl.onTintColor = StyleManager.theme1()
                                
                            }.onChange { row in
                                
                                if(row.value == true){
                                
                                let sRow: SwitchRow? = self.form.rowBy(tag: "EnforceFullTime")
                                sRow?.value = (row.value ?? false) ? false : true
                                sRow?.updateCell()
                                    
                                }
                           }
        
        
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
                            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                            SVProgressHUD.show()
                            
                            var pickerRow: PickerInlineRow<String>? = self.form.rowBy(tag: "NonRegistrationHours")
                            var intRow: IntRow? = self.form.rowBy(tag: "HalfDays")
                            
                            var dateInlineRow: DateInlineRow? = self.form.rowBy(tag: "DateOfIssue")
                            let DateOfIssue = dateInlineRow?.value
                          
                            dateInlineRow = self.form.rowBy(tag: "DueDate")
                            let DueDate = dateInlineRow?.value
                            
                            dateInlineRow = self.form.rowBy(tag: "StartDate")
                            let StartDate = dateInlineRow?.value
                            
                            dateInlineRow = self.form.rowBy(tag: "EndDate")
                            let EndDate = dateInlineRow?.value
  
                            intRow = self.form.rowBy(tag: "HalfDays")
                            let HalfDays = intRow?.value
                            
                            intRow = self.form.rowBy(tag: "FullDays")
                            let FullDays = intRow?.value
                         
                            let BusinessDays = String(self.targetInvoice.NumberOfBusinessDays)
                            
                            pickerRow = self.form.rowBy(tag: "RegistrationHours")
                            let RegistrationHours = Int((pickerRow?.value)!)
                            
                            pickerRow = self.form.rowBy(tag: "RegistrationMinutes")
                            let RegistrationMinutes = Int((pickerRow?.value)!)
                            let RegistrationMins = (RegistrationHours! * 60) + RegistrationMinutes!
                            
                            pickerRow = self.form.rowBy(tag: "NonRegistrationHours")
                            let NonRegistrationHours = Int((pickerRow?.value)!)
                            
                            pickerRow = self.form.rowBy(tag: "NonRegistrationMinutes")
                            let NonRegistrationMinutes = Int((pickerRow?.value)!)
                            let NonRegistrationMins = (NonRegistrationHours! * 60) + NonRegistrationMinutes!

                            pickerRow = self.form.rowBy(tag: "EarlyHours")
                            let EarlyHours = Int((pickerRow?.value)!)
                            
                            pickerRow = self.form.rowBy(tag: "EarlyMinutes")
                            let EarlyMinutes = Int((pickerRow?.value)!)
                            let EarlyMins = (EarlyHours! * 60) + EarlyMinutes!
                            
                            pickerRow = self.form.rowBy(tag: "LateHours")
                            let LateHours = Int((pickerRow?.value)!)
                            pickerRow = self.form.rowBy(tag: "LateMinutes")
                            let LateMinutes = Int((pickerRow?.value)!)
                            let LateMins = (LateHours! * 60) + LateMinutes!
  
                            var switchRow: SwitchRow? = self.form.rowBy(tag: "EnforceFullTime")
                            let enforceFullTime = String((switchRow?.value)!)
                            
                            switchRow = self.form.rowBy(tag: "EnforcePartTime")
                            let enforcePartTime = String((switchRow?.value)!)
                            
                            let invoiceNumber = String(self.targetInvoice.InvoiceNumber)
                            let issueDate = (DateOfIssue?.ToURLString2())!
                            let startDate = (StartDate?.ToURLString2())!
                            let endDate = (EndDate?.ToURLString2())!
                            let dueDate = (DueDate?.ToURLString2())!
                            let noptes = self.targetInvoice.Notes
                            let childId = String(self.targetInvoice.ChildId)
                            let earlyTimeMinutes = String(EarlyMins)
                            let lateTimeMinutes = String(LateMins)
                            let registeredTimeMinutes = String(RegistrationMins)
                            let nonRegisteredTimeMinutes = String(NonRegistrationMins)
                            let invoiceTotal = String(self.targetInvoice.InvoiceTotal)
                            
                            let registeredStartDate = self.targetInvoice.RegisteredStartDate.ToURLString2()
                            let registeredFinishDate = self.targetInvoice.RegisteredStartDate.ToURLString2()
                            
                            let nonRegisteredStartDate = self.targetInvoice.NonRegisteredStartDate.ToURLString2()
                            let nonRegisteredFinishDate = self.targetInvoice.RegisteredFinishDate.ToURLString2()
                            
                            let extraStartDate = self.targetInvoice.ExtraStartDate.ToURLString2()
                            let extraFinishDate = self.targetInvoice.ExtraFinishDate.ToURLString2()
                            
                            let numberOfFullDays = "\(FullDays!)"
                            let numberOfFullHalfDays = "\(HalfDays!)"
                            
                            let usingPartTime = "\(self.targetInvoice.UsingPartTime)"
                            let usingFullTime = "\(self.targetInvoice.UsingFullTime)"
                            
                            let numberOfBusinessDays = "\(BusinessDays)"
                            
                            InvoiceRequests.sharedInstance.UpdateInvoice(invoiceNumber: invoiceNumber, issueDate: issueDate, startDate: startDate, endDate: endDate, dueDate: dueDate, notes: noptes, childId: childId, earlyTimeMinutes: earlyTimeMinutes, lateTimeMinutes: lateTimeMinutes, registeredTimeMinutes: registeredTimeMinutes, nonRegisteredTimeMinutes: nonRegisteredTimeMinutes, invoiceTotal: invoiceTotal, enforcePartTime: enforcePartTime, enforceFullTime: enforceFullTime, registeredStartDate: registeredStartDate, registeredFinishDate: registeredFinishDate, nonRegisteredStartDate: nonRegisteredStartDate, nonRegisteredFinishDate: nonRegisteredFinishDate, extraStartDate: extraStartDate, extraFinishDate: extraFinishDate,  numberOfFullDays: numberOfFullDays, numberOfFullHalfDays: numberOfFullHalfDays, usingPartTime: usingPartTime, usingFullTime: usingFullTime, numberOfBusinessDays: numberOfBusinessDays, onCompletion:
                                { json in
                                    
                                DispatchQueue.main.async(execute: {
                                        
                                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                                            self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                                        })
                                        
                                    })
                            })
                            
                            
                        }.cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 70 }
                }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        SetNavigationBarDetails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Billing
            }
        }
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
        
        self.navigationItem.title = "Edit Invoice"
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
}
