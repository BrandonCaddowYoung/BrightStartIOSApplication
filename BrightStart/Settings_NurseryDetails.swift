//
//  Settings_Email.swift.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
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
                        $0.title = "Nursery School Name"
                        $0.value = self.emailSettings.NurseryName
                    }
                    
                       self.form +++ Section("Address")
                    
                    <<< TextRow("Street") {
                        $0.title = "Street"
                        $0.value = self.emailSettings.Street
                }
                
                    <<< TextRow("Town") {
                        $0.title = "Town"
                        $0.value = self.emailSettings.Town
                }
                
                    <<< TextRow("PostCode") {
                        $0.title = "Post Code"
                        $0.value = self.emailSettings.PostCode
                }
                
                    <<< PhoneRow("Phone") {
                        $0.title = "Phone"
                        $0.value = self.emailSettings.PhoneNumber
                }

                        self.form +++ Section("Contact")
                        
                    <<< URLRow("Website") {
                        $0.title = "Website URL"
                        $0.value = URL(string: self.emailSettings.Website)
                }
                
                    <<< EmailRow("Email") {
                        $0.title = "e-mail"
                        $0.value = self.emailSettings.EmailAddress
                }
                
                            self.form +++ Section("Personal")
                            
                    <<< NameRow("OwnerName") {
                        $0.title = "Owner Name"
                        $0.value = self.emailSettings.OwnerName
                }
                    
                    <<< PhoneRow("OwnerPhone") {
                        $0.title = "Owner Phone Number"
                        $0.value = self.emailSettings.OwnerPhoneNumber
                }
                
                    <<< NameRow("ManagerName") {
                        $0.title = "Manager Phone Number"
                        $0.value = self.emailSettings.ManagerName
                }
                
                    <<< PhoneRow("ManagerPhone") {
                        $0.title = "Manager Phone Number"
                        $0.value = self.emailSettings.ManagerPhoneNumber
                }
                
                     self.form +++ Section("Banking Details")
                    
                    <<< IntRow("BankNumber") {
                        $0.title =  "Bank Account Number"
                        $0.value = Int(self.emailSettings.BankAccountNumber)
                }
                
                    <<< IntRow("BankSortCode") {
                        $0.title = "Bank Account Sort Code"
                        $0.value = Int(self.emailSettings.BankAccountSortCode)
                }
                
                    <<< NameRow("ChequePayableTo") {
                        $0.title = "Cheque Payable To"
                        $0.value = self.emailSettings.ChequePayableTo
                }
                
                    <<< NameRow("BankName") {
                        $0.title = "Bank Name"
                        $0.value = self.emailSettings.BankAccountName
                }
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Save changes"
                        }.onCellSelection {  cell, row in
                            
                            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                            SVProgressHUD.show()
                            
                            let emailRow: EmailRow? = self.form.rowBy(tag: "email")
                            let email = emailRow?.value
                            
                            let passwordRow: PasswordRow? = self.form.rowBy(tag: "password")
                            let password = passwordRow?.value
                            
                            var textAreaRow: TextAreaRow? = self.form.rowBy(tag: "EmailBody")
                            let EmailBody = textAreaRow?.value
                            
                            
                            textAreaRow = self.form.rowBy(tag: "ExtraTimeMessage")
                            let ExtraTimeMessage = textAreaRow?.value
                            
//                            SettingsRequests.sharedInstance.UpdateNurserySettings(Id: self.emailSettings.Id, SMTP: self.emailSettings.SMTP, EmailAddress: email!, Port: self.emailSettings.Port, PasssWord: password, Name: self.emailSettings.Name, onCompletion:
//                                { json in
//                                    
//                                    DispatchQueue.main.async(execute: {
//                                        
//                                        SettingsRequests.sharedInstance.UpdateSettings(Name: "EmailBodyText", Value: EmailBody!, onCompletion:
//                                            { json in
//                                                
//                                                DispatchQueue.main.async(execute: {
//                                                    
//                                                    SettingsRequests.sharedInstance.UpdateSettings(Name: "ExtraTimeBreakDownEmailBodyText", Value: ExtraTimeMessage!, onCompletion:
//                                                        { json in
//                                                            
//                                                            DispatchQueue.main.async(execute: {
//                                                                
//                                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
//                                                                    self.performSegue(withIdentifier: "GoToMenu", sender: nil)
//                                                                })
//                                                                
//                                                            })
//                                                    })
//                                                    
//                                                })
//                                        })
//                                        
//                                    })
//                            })
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

