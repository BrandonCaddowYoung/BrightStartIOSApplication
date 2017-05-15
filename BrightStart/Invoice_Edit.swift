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
    
    typealias Emoji = String
    let 👦🏼 = "👦🏼", 🍐 = "🍐", 💁🏻 = "💁🏻", 🐗 = "🐗", 🐼 = "🐼", 🐻 = "🐻", 🐖 = "🐖", 🐡 = "🐡"
    
    var invoiceId = String()
    
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
        
        SettingsRequests.sharedInstance.GetRates(onCompletion: { json in
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("General")
                    
                    <<< LabelRow("Name)") {
                        $0.title = "name"
                        $0.value = "Joe Bloggs"
                    }
                    
                    <<< LabelRow("InvoiceId)") {
                        $0.title = "invoice id"
                        $0.value = "1234"
                }
                
                self.form +++ Section("DueDate")
                    
                    <<< DateInlineRow("DateOfIssue)") {
                        $0.title = "issue date"
                        $0.value = Date()
                }
               
                    <<< DateInlineRow("DueDate)") {
                        $0.title = "due date"
                        $0.value = Date()
                }
                
                    <<< DateInlineRow("StartDate)") {
                        $0.title = "start date"
                        $0.value = Date()
                }
                
                    <<< DateInlineRow("EndDate)") {
                        $0.title = "end date"
                        $0.value = Date()
                }
                
                self.form +++ Section("Balance")
                    
                    <<< DecimalRow("OriginalInvouceBalance)") {
                        $0.title = "original invoice balance"
                        $0.value = 125.5
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                    
                    <<< DecimalRow("InvouceBalance)") {
                        $0.title = "invoice balance(after payments)"
                        $0.value = 125.5
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                    <<< DecimalRow("AccountBalance)") {
                        $0.title = "account balance"
                        $0.value = 125.5
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                }
                
                self.form +++ Section("Statistics")
                    
                    <<< IntRow("HalfDays)") {
                        $0.title = "number of half days"
                        $0.value = 1
                    }
                    
                    <<< IntRow("FulDays)") {
                        $0.title = "number of full days"
                        $0.value = 3
                    }
                    
                    self.form +++ Section("Registerd Time")
                        
                        <<< PickerInlineRow<String>("RegstdationHours") {
                            $0.title = "Hours"
                            $0.options = self.hours
                            $0.value = self.hours[0]
                            
                        }
                        <<< PickerInlineRow<String>("RegstdationMinutes") {
                            $0.title = "Minutes"
                            $0.options = self.minutes
                            $0.value = self.minutes[0]
                        }
                        
                        
                        
                self.form +++ Section("Non-Registerd Time")
                    
                    <<< PickerInlineRow<String>("NonRegstdationHours") {
                        $0.title = "Hours"
                        $0.options = self.hours
                        $0.value = self.hours[0]
                        
                    }
                    <<< PickerInlineRow<String>("NonRegstdationMinutes") {
                        $0.title = "Minutes"
                        $0.options = self.minutes
                        $0.value = self.minutes[0]
                    }
                    
                    
                    
                self.form +++ Section("Early Time")
                    
                    <<< PickerInlineRow<String>("EarlyHours") {
                        $0.title = "Hours"
                        $0.options = self.hours
                        $0.value = self.hours[0]
                        
                    }
                    <<< PickerInlineRow<String>("EarlyMinutes") {
                        $0.title = "Minutes"
                        $0.options = self.minutes
                        $0.value = self.minutes[0]
                    }
                    
                self.form +++ Section("Late Time")
                    
                    <<< PickerInlineRow<String>("LateHours") {
                        $0.title = "Hours"
                        $0.options = self.hours
                        $0.value = self.hours[0]
                        
                    }
                    <<< PickerInlineRow<String>("LateMinutes") {
                        $0.title = "Minutes"
                        $0.options = self.minutes
                        $0.value = self.minutes[0]
                    }

                    
                    
                     self.form +++ Section("Qualification")

                    <<< IntRow("BusinessDays)") {
                        $0.title = "number of business days"
                        $0.value = 1
                    }
                    
                    <<< IntRow("FullTimeQualificationPoint)") {
                        $0.title = "full time qualification point"
                        $0.value = 1
                    }
                    
                    <<< SwitchRow("QualifcationStatus)") {
                        $0.title = "Full Time"
                        $0.value = true
                }
                        
                        
                        
                        
                        
                        
                        
                
                        
                        
                        
                        
                
                       // <<< MultipleSelectorRow<Emoji>() {
                           // $0.title = "You selected 5 children."
                           //$0.options = [self.💁🏻, self.🍐, self.👦🏼, self.🐗, self.🐼, self.🐻]
                          //  $0.value = [self.👦🏼, self.🍐, self.🐗]
                          //  }
                          //  .onPresent { from, to in
                               // to.sectionKeyForValue = { option in
                                   // switch option {
                                   // case self.💁🏻, self.👦🏼: return "People"
                                   // case self.🐗, self.🐼, self.🐻: return "Animals"
                                  //  case self.🍐: return "Food"
                                //    default: return ""
                              //      }
                            //    }
                                //to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(RowsExampleViewController.multipleSelectorDone(_:)))
                //}
                
                
               
                
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
                            var row: NameRow? = self.form.rowBy(tag: "FirstName")
                            let FirstName = row?.value ?? ""
                            
                            //Call to save changes!
                            
                            
                        }.cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
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
