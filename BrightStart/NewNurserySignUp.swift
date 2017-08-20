//
//  NewNurserySignUp.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class NewNurserySignUp: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
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
                view.text = "Welcome to Bright Start."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
        }
        
        form +++ Section()
            <<< LabelRow("Thanks for choosing Bright Start"){
                $0.title = "To get going, complete the form below before tapping the button found at the bottom of the page."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Credentials")
            
            <<< EmailRow("Email") {
                $0.title = "email"
                $0.placeholder = "enter an email address."
                $0.add(rule: RuleEmail())
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< PasswordRow("Password") {
                $0.title = "password"
                $0.placeholder = "enter a safe password"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< PasswordRow("ConfirmPassword") {
                $0.title = "confirm password"
                $0.placeholder = "confirm your password."
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
        }
        
        form +++ Section("Nursery Information")
            
            <<< NameRow("NurseryName") {
                $0.title = "nursery name"
                $0.placeholder = "enter nursery name."
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< NameRow("ManagerName") {
                $0.title = "manager name"
                $0.placeholder = "enter the managaers name."
            }
            
            <<< PhoneRow("NurseryPhoneNumber") {
                $0.title = "phone number"
                $0.placeholder = "enter the nursery phone number"
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Create new account"
                }.onCellSelection {  cell, row in
                    
                    let emailRow: EmailRow? = self.form.rowBy(tag: "Email")
                    let Email = emailRow?.value ?? ""
                    
                    var passsowrdRow: PasswordRow? = self.form.rowBy(tag: "Password")
                    let Password = passsowrdRow?.value ?? ""
                    
                    passsowrdRow = self.form.rowBy(tag: "ConfirmPassword")
                    _ = passsowrdRow?.value ?? ""
                    
                    var row: NameRow? = self.form.rowBy(tag: "NurseryName")
                    let NurseryName = row?.value ?? ""
                    
                    row = self.form.rowBy(tag: "ManagerName")
                    let ManagerName = row?.value ?? ""
                    
                    let phoneRow: PhoneRow? = self.form.rowBy(tag: "NurseryPhoneNumber")
                    let NurseryPhoneNumber = phoneRow?.value
                    
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    RegistrationRequests.sharedInstance.CreateNewNurserySchoolFromScratch(nurserySchoolName: NurseryName, managerName: ManagerName, nurserySchoolPhoneNumber: NurseryPhoneNumber!, username: Email, password: Password, onCompletion: { json in
                        
                        DispatchQueue.main.async(execute: {
                            
                            SVProgressHUD.dismiss(withDelay: 1, completion: {
                                
                                self._CommonHelper.ShowSuccessMessage(title: "Success", subsTtitle: "Your account is set up and ready to go." + " In order to continue, you will need to sign in with the credentials you just entered.")
                                
                                self.performSegue(withIdentifier: "GoToSignIn", sender: self)
                                
                            } )
                            
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

