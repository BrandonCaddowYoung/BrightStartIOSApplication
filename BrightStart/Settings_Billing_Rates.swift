//
//  Settings_Billing.swift.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Settings_Billing_Rates: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var rates = Rates()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        //Go fetcth the rates!
       
        SettingsRequests.sharedInstance.GetRates(onCompletion: { json in
            
            self.rates.RateId = (json["RateId"].stringValue as NSString).floatValue
            self.rates.Early_Rate_PT = (json["Early_Rate_PT"].stringValue as NSString).floatValue
            self.rates.Early_Rate_FT = (json["Early_Rate_FT"].stringValue as NSString).floatValue
            self.rates.Late_Rate_PT = (json["Late_Rate_PT"].stringValue as NSString).floatValue
            self.rates.Late_Rate_FT = (json["Late_Rate_FT"].stringValue as NSString).floatValue
            self.rates.Registered_Hours_FT = (json["Registered_Hours_FT"].stringValue as NSString).floatValue
            self.rates.Registered_Hours_PT = (json["Registered_Hours_PT"].stringValue as NSString).floatValue
            self.rates.Non_Registered_Hours_FT = (json["Non_Registered_Hours_FT"].stringValue as NSString).floatValue
            self.rates.Non_Registered_Hours_PT = (json["Non_Registered_Hours_PT"].stringValue as NSString).floatValue
            self.rates.Early_Grace_Minutes = (json["Early_Grace_Minutes"].stringValue as NSString).floatValue
            self.rates.Late_Grace_Minutes = (json["Late_Grace_Minutes"].stringValue as NSString).floatValue
            self.rates.Full_Time_Qualifying_Point_Hours = (json["Full_Time_Qualifying_Point_Hours"].stringValue as NSString).floatValue
            self.rates.HalfDayQualificationLower = (json["HalfDayQualificationLower"].stringValue as NSString).floatValue
            self.rates.HalfDayQualificationUpper = (json["HalfDayQualificationUpper"].stringValue as NSString).floatValue
            self.rates.FullDayQualificationLower = (json["FullDayQualificationLower"].stringValue as NSString).floatValue
            self.rates.FullDayQualificationUpper = (json["FullDayQualificationUpper"].stringValue as NSString).floatValue
            self.rates.HalfDayRate_PT = (json["HalfDayRate_PT"].stringValue as NSString).floatValue
            self.rates.HalfDayRate_FT = (json["HalfDayRate_FT"].stringValue as NSString).floatValue
            self.rates.FullDayRate_PT = (json["FullDayRate_PT"].stringValue as NSString).floatValue
            self.rates.FullDayRate_FT = (json["FullDayRate_FT"].stringValue as NSString).floatValue
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("Extra Time Rates")
                    
               //3 self.form +++ Section("Statistics")
                    
                    <<< DecimalRow("FTEarlyRate") {
                        $0.title = "early (ful time)"
                        $0.placeholder = "enter the early rate."
                        $0.value = Double(self.rates.Early_Rate_FT)
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTEarlyRate") {
                        $0.title = "early (part time)"
                        $0.placeholder = "enter the late rate."
                        $0.value = Double(self.rates.Early_Rate_PT)
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                    <<< DecimalRow("FTLateRate") {
                        $0.title = "late (full time)"
                        $0.placeholder = "enter the late rate."
                        $0.value = Double(self.rates.Late_Rate_FT
                        )
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTLateRate") {
                        $0.title = "late (part time)"
                        $0.placeholder = "enter the late rate."
                        $0.value = Double(self.rates.Late_Rate_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                self.form +++ Section("What is 'Extra Time?")
                    
                    <<< LabelRow() {
                        $0.title = "'Extra Time' refers to accumulated time that occurs when a child is signed out early or late of their 'Registerd Hours'."
                        $0.cell.textLabel?.numberOfLines = 5
                }
                
                self.form +++ Section("Registerd Hours Rates")
                    
                    <<< DecimalRow("FTRegisteredHoursRate") {
                        $0.title = "registered hours rate (full time)"
                        $0.placeholder = "enter the registerd hours rate."
                        $0.value = Double(self.rates.Registered_Hours_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTRegisteredHoursRate") {
                        $0.title = "registered hours rate (part time)"
                        $0.placeholder = "enter the registered hours rate."
                        $0.value = Double(self.rates.Registered_Hours_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter        }
                
                
                self.form +++ Section("What are 'Registed Hours'?")
                    
                    <<< LabelRow() {
                        $0.title = "'Registered hours refer to accumulated time that has been previously booked. Registered Hours are generally set ahead of time."
                        $0.cell.textLabel?.numberOfLines = 5
                        
                }
                
                self.form +++ Section("Non Registerd Hours Rates")
                    
                    <<< DecimalRow("FTNonRegisteredHoursRate") {
                        $0.title = "non-registered hours rate (full time)"
                        $0.placeholder = "enter the non-registerd hours rate."
                        $0.value = Double(self.rates.Non_Registered_Hours_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTNonRegisteredHoursRate") {
                        $0.title = "non-registered hours rate (part time)"
                        $0.placeholder = "enter the non-registered hours rate."
                        $0.value = Double(self.rates.Non_Registered_Hours_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                self.form +++ Section("What are 'Non-Registerd Hours'?")
                    
                    <<< LabelRow() {
                        $0.title = "'Non-Registered Hours' refer to time that is accumulated when a child spends time in nursery with out being assigned specific 'Registered Hours'. For example, if a child has not been given 'Registered Hours' for a specific day and signs in, the time will be recorded as 'Non-Registerd' time."
                        $0.cell.textLabel?.numberOfLines = 5
                }
                
                self.form +++ Section("Daily Rates")
                    
                    <<< DecimalRow("FullDayFullTime") {
                        $0.title = "full day (full time)"
                        $0.placeholder = "enter the full day rate."
                        $0.value = Double(self.rates.HalfDayRate_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("FullDayPartTime") {
                        $0.title = "full date (part time)"
                        $0.placeholder = "enter the full day rate."
                        $0.value = Double(self.rates.HalfDayRate_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("HalfDayFullTime") {
                        $0.title = "half day (full time)"
                        $0.placeholder = "enter the half day rate."
                        $0.value = Double(self.rates.HalfDayRate_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("HalfDayPartTime") {
                        $0.title = "half day (part time)"
                        $0.placeholder = "enter the half day rate."
                        $0.value = Double(self.rates.HalfDayRate_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                self.form +++ Section("What are 'Day Rates'?")
                    
                    <<< LabelRow() {
                        $0.title = "Half and Full daily rates can be applied to accumulated time at the end of a billig period."
                        $0.cell.textLabel?.numberOfLines = 5
                }
                
                 self.form +++ Section("Qualification")
                
                    <<< DecimalRow("QualificationPoint") {
                        $0.title = "full time qualification point(hours)"
                        $0.placeholder = "enter the full time qualification point."
                        $0.value = Double(self.rates.Full_Time_Qualifying_Point_Hours)
                       
                }
                
                self.form +++ Section("What is the qualification point?")
                    
                    <<< LabelRow() {
                        $0.title = "The qualificaiotn marks the number of hours the classifes whther a child is full time or part time."
                        $0.cell.textLabel?.numberOfLines = 5
                }
                
                self.form +++ Section("Grace")
                    
                    <<< DecimalRow("EarlyGraceMinutes") {
                        $0.title = "early grace time(minutes)"
                        $0.placeholder = "enter the early grace time in minutes."
                        $0.value = Double(self.rates.Early_Grace_Minutes)
                       
                }
                
                    <<< DecimalRow("LateGraceMinutes") {
                        $0.title = "late grace time(minutes)"
                        $0.placeholder = "enter the late grace time in minutes."
                        $0.value = Double(self.rates.Late_Grace_Minutes)
                        
                }
                
                self.form +++ Section("What is Grace time")
                    
                    <<< LabelRow() {
                        $0.title = "Grace time is period in which a child can be early or late before penalties apply."
                        $0.cell.textLabel?.numberOfLines = 5
                }
                     self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
                            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                            SVProgressHUD.show()
                            
                            var decRow: DecimalRow? = self.form.rowBy(tag: "FTEarlyRate")
                            let FTEarlyRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "PTEarlyRate")
                            let PTEarlyRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "FTLateRate")
                            let FTLateRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "PTLateRate")
                            let PTLateRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "FTRegisteredHoursRate")
                            let FTRegisteredHoursRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "PTRegisteredHoursRate")
                            let PTRegisteredHoursRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "FTNonRegisteredHoursRate")
                            let FTNonRegisteredHoursRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "PTNonRegisteredHoursRate")
                            let PTNonRegisteredHoursRate = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "FullDayFullTime")
                            let FullDayFullTime = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "FullDayPartTime")
                            let FullDayPartTime = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "HalfDayFullTime")
                            let HalfDayFullTime = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "HalfDayPartTime")
                            let HalfDayPartTime = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "QualificationPoint")
                            let QualificationPoint = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "EarlyGraceMinutes")
                            let EarlyGraceMinutes = decRow?.value
                            
                            decRow = self.form.rowBy(tag: "LateGraceMinutes")
                            let LateGraceMinutes = decRow?.value
                            
                            let earlyGraceMinutes = EarlyGraceMinutes?.description
                            let lateGraceMinutes = LateGraceMinutes?.description
                            
                            let qualificationPoint = QualificationPoint?.description
                            
                            let fTEarlyRate = FTEarlyRate?.description
                            let pTEarlyRate = PTEarlyRate?.description
                            
                            let ftLateRate = FTLateRate?.description
                            let ptLateRate = PTLateRate?.description
                            
                            let fTRegisteredHoursRate = FTRegisteredHoursRate?.description
                            let pTRegisteredHoursRate = PTRegisteredHoursRate?.description
                            let fTNonRegisteredHoursRate = FTNonRegisteredHoursRate?.description
                            let pTNonRegisteredHoursRate = PTNonRegisteredHoursRate?.description
                            
                            let fullDayFullTime = FullDayFullTime?.description
                            let fullDayPartTime = FullDayPartTime?.description
                            let halfDayFullTime = HalfDayFullTime?.description
                            let halfDayPartTime = HalfDayPartTime?.description
                            
                            SettingsRequests.sharedInstance.UpdateRates(RateId: String(self.rates.RateId), Early_Rate_PT: pTEarlyRate!, Early_Rate_FT: fTEarlyRate!, Late_Rate_PT: ptLateRate!, Late_Rate_FT: ftLateRate, Registered_Hours_FT: fTRegisteredHoursRate, Registered_Hours_PT: pTRegisteredHoursRate, Non_Registered_Hours_FT: fTNonRegisteredHoursRate, Non_Registered_Hours_PT: pTNonRegisteredHoursRate, Early_Grace_Minutes: earlyGraceMinutes, Late_Grace_Minutes:lateGraceMinutes, Full_Time_Qualifying_Point_Hours: qualificationPoint, HalfDayQualificationLower: String(self.rates.HalfDayQualificationLower), HalfDayQualificationUpper: String(self.rates.HalfDayQualificationUpper), FullDayQualificationLower: String(self.rates.FullDayQualificationLower), FullDayQualificationUpper: String(self.rates.FullDayQualificationUpper), HalfDayRate_PT: halfDayPartTime, HalfDayRate_FT: halfDayFullTime, FullDayRate_PT: fullDayPartTime, FullDayRate_FT: fullDayFullTime, onCompletion:
                                { json in
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                                            self.performSegue(withIdentifier: "GoToMenu", sender: nil)
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
                
            })
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        SetNavigationBarDetails()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Settings
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
        
        self.navigationItem.title = "Setting Rates"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
}

class CurrencyFormatter : NumberFormatter, FormatterProtocol {
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, range rangep: UnsafeMutablePointer<NSRange>?) throws {
        guard obj != nil else { return }
        let str = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        obj?.pointee = NSNumber(value: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
    }
    
    func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
        return textInput.position(from: position, offset:((newValue?.characters.count ?? 0) - (oldValue?.characters.count ?? 0))) ?? position
    }
}
