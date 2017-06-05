//
//  NewNurserySignUp.swift.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class NewNurserySignUp: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
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
                view.text = "Welcome!"
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            <<< LabelRow("test"){
                $0.title = "To get started, complete the form below before tapping the button at the bottom of the page."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Credentials")
            
            <<< EmailRow("Email") {
                $0.title = "email"
                $0.placeholder = "enter an email address."
            }
            
            <<< PasswordRow("Password") {
                $0.title = "password"
                $0.placeholder = "enter a safe password"
            }
            
            <<< PasswordRow("ConfirmPassword") {
                $0.title = "confirm password"
                $0.placeholder = "confirm your password."
            }
        
        form +++ Section("Nursery Information")
            
            <<< NameRow("NurseryName") {
                $0.title = "nursery name"
                $0.placeholder = "enter nursery name."
            }
            
            <<< NameRow("ManagerName") {
                $0.title = "manager name"
                $0.placeholder = "enter the managaers name."
            }
            
            <<< PhoneRow("NurseryPhoneNumber") {
                $0.title = "phone number"
                $0.placeholder = "enter the nursery phone number"
            }
        
        self.form +++ Section("")
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
                                
                                self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                                
                                self.performSegue(withIdentifier: "GoToSignIn", sender: self)
                                
                            } )
                            
                        })
                        
                    })
                    
                    
                    
                    
                    
                    
                }.cellUpdate
                {
                    cell, row in
                    cell.backgroundColor = StyleManager.theme1()
                    cell.textLabel?.textColor = StyleManager.theme2()
                    cell.height = { 100 }
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

