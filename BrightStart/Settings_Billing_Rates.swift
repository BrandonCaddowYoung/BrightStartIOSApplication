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
       
        
        
        
        //Retrieve all children
        SettingsRequests.sharedInstance.GetRates(onCompletion: { json in
            
            
            
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
                    
                    <<< DecimalRow("FTEarlyRate)") {
                        $0.title = "extra time rate (full time)"
                        $0.placeholder = "enter the early rate."
                        $0.value = Double(self.rates.Early_Rate_FT
                        )
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTEarlyRate)") {
                        $0.title = "extra time rate (part time)"
                        $0.placeholder = "enter the late rate."
                        $0.value = Double(self.rates.Early_Rate_PT)
                        
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
                    
                    <<< DecimalRow("FTRegisteredHoursRate)") {
                        $0.title = "registered hours rate (full time)"
                        $0.placeholder = "enter the registerd hours rate."
                        $0.value = Double(self.rates.Registered_Hours_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTRegisteredHoursRate)") {
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
                    
                    <<< DecimalRow("FTNonRegisteredHoursRate)") {
                        $0.title = "non-registered hours rate (full time)"
                        $0.placeholder = "enter the non-registerd hours rate."
                        $0.value = Double(self.rates.Non_Registered_Hours_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("PTNonRegisteredHoursRate)") {
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
                    
                    <<< DecimalRow("FullDayFullTime)") {
                        $0.title = "full day rate (full time)"
                        $0.placeholder = "enter the full day rate."
                        $0.value = Double(self.rates.HalfDayRate_FT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("FullDayPartTime)") {
                        $0.title = "full date rate (part time)"
                        $0.placeholder = "enter the full day rate."
                        $0.value = Double(self.rates.HalfDayRate_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("HalfDayPartTime)") {
                        $0.title = "half day rate (full time)"
                        $0.placeholder = "enter the half day rate."
                        $0.value = Double(self.rates.HalfDayRate_PT)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("HalfDayFullTime)") {
                        $0.title = "half day rate (part time)"
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
                
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
                            let row: NameRow? = self.form.rowBy(tag: "FirstName")
                            let FirstName = row?.value ?? ""
                            
                            //Call to save changes!
                            
                            
                        }.cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 100 }
                }

                
                
                
                
                
                
                
            })
            
        })
        
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
