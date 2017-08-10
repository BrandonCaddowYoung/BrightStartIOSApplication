//
//  Settings_Email.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Settings_Email: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var emailSettings = EmailSettings()
    
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
        
        SettingsRequests.sharedInstance.GetEmailBodyText(onCompletion: { json in
            
            DispatchQueue.main.async(execute: {
                self.form +++ Section("Message")
                    <<< TextAreaRow("EmailBody") {
                        $0.title = "invoice e-mail body"
                        $0.placeholder = "enter message."
                        $0.cell.textLabel?.numberOfLines = 5
                        $0.value = (json["Value"].stringValue as NSString) as String
                }
            })
        })
        
        SettingsRequests.sharedInstance.GetBreakDownText(onCompletion: { json in
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("Extra Time Message")
                    
                    <<< TextAreaRow("ExtraTimeMessage") {
                        $0.title = "extra time message"
                        $0.placeholder = "enter message."
                        $0.cell.textLabel?.numberOfLines = 5
                        $0.value = (json["Value"].stringValue as NSString) as String
                }
                
            })
        })
        
        SettingsRequests.sharedInstance.GetEmailSettings(onCompletion: { json in
            
            self.emailSettings.Id = (json["Id"].stringValue as NSString) as String
            self.emailSettings.SMTP = (json["SMTP"].stringValue as NSString) as String
            self.emailSettings.EmailAddress = (json["EmailAddress"].stringValue as NSString) as String
            self.emailSettings.Port = (json["Port"].stringValue as NSString) as String
            self.emailSettings.PassWord = (json["PassWord"].stringValue as NSString) as String
            self.emailSettings.Name = (json["Name"].stringValue as NSString) as String
            self.emailSettings.NurserySchoolId = (json["NurserySchoolId"].stringValue as NSString) as String
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("e-mail")
                    
                    <<< EmailRow("email") {
                        $0.title = "GMail e-mail address"
                        $0.placeholder = "enter e-mail."
                        $0.value = self.emailSettings.EmailAddress
                        $0.add(rule: RuleEmail())
                        $0.validationOptions = .validatesOnChange
                        }
                        .cellUpdate { cell, row in
                            if !row.isValid {
                                cell.titleLabel?.textColor = .red
                            }
                    }
                    
                    <<< PasswordRow("password") {
                        $0.title = "GMail password"
                        $0.placeholder = "enter password."
                        $0.value = self.emailSettings.PassWord
                }
                
                self.form +++ Section()
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
                            
                            SettingsRequests.sharedInstance.UpdateEmailSettings(Id: self.emailSettings.Id, SMTP: self.emailSettings.SMTP, EmailAddress: email!, Port: self.emailSettings.Port, PasssWord: password, Name: self.emailSettings.Name, onCompletion:
                                { json in
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        SettingsRequests.sharedInstance.UpdateSettings(Name: "EmailBodyText", Value: EmailBody!, onCompletion:
                                            { json in
                                                
                                                DispatchQueue.main.async(execute: {
                                                    
                                                    SettingsRequests.sharedInstance.UpdateSettings(Name: "ExtraTimeBreakDownEmailBodyText", Value: ExtraTimeMessage!, onCompletion:
                                                        { json in
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                
                                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                    self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                                                                })
                                                                
                                                            })
                                                    })
                                                    
                                                })
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

