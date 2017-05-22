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
       
        //Retrieve invoice using invoice id.
        
       
                
                self.form +++ Section("General")
                    
                    <<< LabelRow("Name)") {
                        $0.title = "name"
                        $0.value = String(self.targetInvoice.ChildId)
                    }
                    
                    <<< LabelRow("InvoiceId)") {
                        $0.title = "invoice id"
                        $0.value = String(self.targetInvoice.InvoiceNumber)

                }
                
                self.form +++ Section("Dates")
                    
                    <<< DateInlineRow("DateOfIssue)") {
                        $0.title = "issue date"
                        $0.value = self.targetInvoice.IssueDate
                }
               
                    <<< DateInlineRow("DueDate)") {
                        $0.title = "due date"
                        $0.value =  Date() //?
                }
                
                    <<< DateInlineRow("StartDate)") {
                        $0.title = "start date"
                        $0.value = self.targetInvoice.Start_Date
                }
                
                    <<< DateInlineRow("EndDate)") {
                        $0.title = "end date"
                        $0.value = self.targetInvoice.End_Date
                }
                
                self.form +++ Section("Balance")
                    
                    <<< DecimalRow("OriginalInvouceBalance)") {
                        $0.title = "original invoice balance"
                        $0.value = Double(self.targetInvoice.InvoiceTotal)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("InvouceBalance)") {
                        $0.title = "invoice balance(after payments)"
                        $0.value = Double(self.targetInvoice.InvoiceBalance)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                self.form +++ Section("Statistics")
                    
                    <<< IntRow("HalfDays)") {
                        $0.title = "number of half days"
                        $0.value = self.targetInvoice.NumberOfFullHalfDays
                    }
                    
                    <<< IntRow("FulDays)") {
                        $0.title = "number of full days"
                        $0.value = self.targetInvoice.NumberOfFullHalfDays
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
                
                  let (lateHours,lateMins,_) = self._CommonHelper.secondsToHoursMinutesSeconds(seconds: Int(self.targetInvoice.Early_Time_Minutes * 60))
                
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

                    <<< IntRow("BusinessDays)") {
                        $0.title = "number of business days"
                        $0.value = self.targetInvoice.NumberOfBusinessDays
                    }
                    
                    <<< IntRow("FullTimeQualificationPoint)") {
                        $0.title = "full time qualification point"
                        $0.value = 1
                    }
                    
                    <<< SwitchRow("QualifcationStatus)") {
                        $0.title = "Full Time"
                        $0.value = true
                }
                
                        <<< SwitchRow("EnforceFullTime)") {
                            $0.title = "enforce full time"
                            $0.value = false
                }
                
                        <<< SwitchRow("EnforcePartTime)") {
                            $0.title = "enfore part time"
                            $0.value = false
                }
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
                            let formvalues = self.form.values()
                            _ = formvalues["StartDate"]
                            
                            
                            var pickerRow: PickerInlineRow<String>? = self.form.rowBy(tag: "NonRegistrationHours")
                            var intRow: IntRow? = self.form.rowBy(tag: "HalfDays")
                            var dateInlineRow: DateInlineRow? = self.form.rowBy(tag: "StartDate")
                            
                            dateInlineRow = self.form.rowBy(tag: "DateOfIssue")
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
                            
                            intRow = self.form.rowBy(tag: "BusinessDays")
                            let BusinessDays = intRow?.value
                            
                            pickerRow = self.form.rowBy(tag: "RegistrationHours")
                            let RegistrationHours = Int((pickerRow?.value)!)
                            pickerRow = self.form.rowBy(tag: "RegistrationMinutes")
                            let RegistrationMinutes = Int((pickerRow?.value)!)
                            let RegistrationMins = (RegistrationHours! / 60) + RegistrationMinutes!
                            
                            pickerRow = self.form.rowBy(tag: "NonRegistrationHours")
                            let NonRegistrationHours = Int((pickerRow?.value)!)
                            pickerRow = self.form.rowBy(tag: "NonRegistrationMinutes")
                            let NonRegistrationMinutes = Int((pickerRow?.value)!)
                            let NonRegistrationMins = (NonRegistrationHours! / 60) + NonRegistrationMinutes!

                            pickerRow = self.form.rowBy(tag: "EarlyHours")
                            let EarlyHours = Int((pickerRow?.value)!)
                            pickerRow = self.form.rowBy(tag: "EarlyMinutes")
                            let EarlyMinutes = Int((pickerRow?.value)!)
                            let EarlyMins = (EarlyHours! / 60) + EarlyMinutes!
                            
                            pickerRow = self.form.rowBy(tag: "LateHours")
                            let LateHours = Int((pickerRow?.value)!)
                            pickerRow = self.form.rowBy(tag: "LateMinutes")
                            let LateMinutes = Int((pickerRow?.value)!)
                            let LateMins = (LateHours! / 60) + LateMinutes!

                           InvoiceRequests.sharedInstance.UpdateInvoice(invoiceNumber: String(self.targetInvoice.InvoiceNumber), issueDate: DateOfIssue!.ToURLString(), startDate: StartDate!.ToURLString(), endDate: EndDate!.ToURLString(), dueDate: DueDate?.ToURLString(), notes: self.targetInvoice.Notes, childId: String(self.targetInvoice.ChildId), earlyTimeMinutes: String(EarlyMins), lateTimeMinutes: String(LateMins), registeredTimeMinutes: String(RegistrationMins), nonRegisteredTimeMinutes: String(NonRegistrationMins), invoiceTotal: String(self.targetInvoice.InvoiceTotal), enforcePartTime: String(false), enforceFullTime: String(false), registeredStartDate: self.targetInvoice.RegisteredStartDate.ToURLString(), registeredFinishDate: self.targetInvoice.RegisteredFinishDate.ToURLString(), nonRegisteredStartDate: self.targetInvoice.NonRegisteredStartDate.ToURLString(), nonRegisteredFinishDate: self.targetInvoice.NonRegisteredFinishDate.ToURLString(), extraStartDate: self.targetInvoice.ExtraStartDate.ToURLString(), extraFinishDate: self.targetInvoice.ExtraFinishDate.ToURLString(),  numberOfFullDays: String(describing: FullDays), numberOfFullHalfDays: String(describing: HalfDays), usingPartTime: String(describing: self.targetInvoice.UsingPartTime), usingFullTime: String(describing: self.targetInvoice.UsingFullTime), numberOfBusinessDays: String(describing: BusinessDays), onCompletion:
                                { json in
                                    
                                DispatchQueue.main.async(execute: {
                                        
                                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                                            self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                        })
                                        
                                    })
                            })
                            
                            
                        }.cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
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
        
        self.navigationItem.title = "Quick Create"
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
}
