//
//  Settings_Email.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Settings_NurseryDetails: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var emailSettings = NurseryDetails()
    
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
                view.text = "Nursery Details"
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
        }
        
        SettingsRequests.sharedInstance.GetNurserySettings(onCompletion: { json in
            
            self.emailSettings.NurseryName = (json["NurseryName"].stringValue as NSString) as String
            self.emailSettings.Street = (json["Street"].stringValue as NSString) as String
            self.emailSettings.County = (json["County"].stringValue as NSString) as String
            self.emailSettings.Town = (json["Town"].stringValue as NSString) as String
            self.emailSettings.PhoneNumber = (json["PhoneNumber"].stringValue as NSString) as String
            self.emailSettings.Website = (json["Website"].stringValue as NSString) as String
            self.emailSettings.EmailAddress = (json["EmailAddress"].stringValue as NSString) as String
            self.emailSettings.OwnerName = (json["OwnerName"].stringValue as NSString) as String
            self.emailSettings.OwnerPhoneNumber = (json["OwnerPhoneNumber"].stringValue as NSString) as String
            self.emailSettings.ManagerName = (json["ManagerName"].stringValue as NSString) as String
            self.emailSettings.ManagerPhoneNumber = (json["ManagerPhoneNumber"].stringValue as NSString) as String
            self.emailSettings.BankAccountName = (json["BankAccountName"].stringValue as NSString) as String
            self.emailSettings.BankAccountNumber = (json["BankAccountNumber"].stringValue as NSString) as String
            self.emailSettings.BankAccountSortCode = (json["BankAccountSortCode"].stringValue as NSString) as String
            self.emailSettings.ChequePayableTo = (json["ChequePayableTo"].stringValue as NSString) as String
            self.emailSettings.VATNumber = (json["VATNumber"].stringValue as NSString) as String
            self.emailSettings.PostCode = (json["PostCode"].stringValue as NSString) as String
            self.emailSettings.PrinterName = (json["PrinterName"].stringValue as NSString) as String
            self.emailSettings.BillingType = (json["BillingType"].stringValue as NSString) as String
            self.emailSettings.NurseryScholIdentification = (json["NurseryScholIdentification"].stringValue as NSString) as String
            self.emailSettings.IsNurserySchoolUsingOnlineVersion = (json["IsNurserySchoolUsingOnlineVersion"].stringValue as NSString) as String
            self.emailSettings.NurserySchoolId = (json["NurserySchoolId"].stringValue as NSString) as String
            
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("General Details")
                    
                    <<< NameRow("NurseryName") {
                        $0.title = "nursery school name"
                        $0.value = self.emailSettings.NurseryName
                        $0.add(rule: RuleRequired())
                        $0.validationOptions = .validatesOnChange
                        }
                        .cellUpdate { cell, row in
                            if !row.isValid {
                                cell.titleLabel?.textColor = .red
                            }
                }
                
                self.form +++ Section("Address")
                    
                    <<< TextRow("Street") {
                        $0.title = "street"
                        $0.value = self.emailSettings.Street
                    }
                    
                    <<< TextRow("Town") {
                        $0.title = "town"
                        $0.value = self.emailSettings.Town
                    }
                    
                    <<< TextRow("PostCode") {
                        $0.title = "post code"
                        $0.value = self.emailSettings.PostCode
                    }
                    
                    <<< PhoneRow("Phone") {
                        $0.title = "phone"
                        $0.value = self.emailSettings.PhoneNumber
                }
                
                self.form +++ Section("Contact")
                    
                    <<< URLRow("Website") {
                        $0.title = "website URL"
                        $0.value = URL(string: self.emailSettings.Website)
                    }
                    
                    <<< EmailRow("Email") {
                        $0.title = "e-mail"
                        $0.value = self.emailSettings.EmailAddress
                        $0.add(rule: RuleEmail())
                        $0.validationOptions = .validatesOnChange
                        }
                        .cellUpdate { cell, row in
                            if !row.isValid {
                                cell.titleLabel?.textColor = .red
                            }
                }
                
                self.form +++ Section("Personal")
                    
                    <<< NameRow("OwnerName") {
                        $0.title = "owner name"
                        $0.value = self.emailSettings.OwnerName
                    }
                    
                    <<< PhoneRow("OwnerPhone") {
                        $0.title = "owner phone number"
                        $0.value = self.emailSettings.OwnerPhoneNumber
                    }
                    
                    <<< NameRow("ManagerName") {
                        $0.title = "manager phone number"
                        $0.value = self.emailSettings.ManagerName
                    }
                    
                    <<< PhoneRow("ManagerPhone") {
                        $0.title = "manager phone number"
                        $0.value = self.emailSettings.ManagerPhoneNumber
                }
                
                self.form +++ Section("Banking Details")
                    
                    <<< IntRow("BankNumber") {
                        $0.title =  "bank account number"
                        $0.value = Int(self.emailSettings.BankAccountNumber)
                    }
                    
                    <<< IntRow("BankSortCode") {
                        $0.title = "bank account sort code"
                        $0.value = Int(self.emailSettings.BankAccountSortCode)
                    }
                    
                    <<< NameRow("ChequePayableTo") {
                        $0.title = "cheque payable to"
                        $0.value = self.emailSettings.ChequePayableTo
                    }
                    
                    <<< NameRow("BankName") {
                        $0.title = "bank name"
                        $0.value = self.emailSettings.BankAccountName
                }
                
                self.form +++ Section()
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
//                            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
//                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
//                            SVProgressHUD.show()
                            
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

