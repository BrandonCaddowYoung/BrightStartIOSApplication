//
//  AuthyParentSignUp.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class AuthyParentSignUp: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var selectedChildId: String!
    
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
                view.text = "Authy"
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
//            <<< LabelRow(){
//                $0.title = "This feature allows you to assgin a child to a parent for the purpose of 'Second Factor(Authy) Authentication'."
//                $0.cell.textLabel?.numberOfLines = 5
//                //$0.cell.height = { 300 }
//        }
//        
//        form +++ Section("What is Second Factor Authentication?")
//            <<< LabelRow(){
//                $0.title = "Second Factor Authentication is a means of verifying a person is who she/he says he/she is. For instance by us sending a message to a persons mobile device who are then able to respond to the prompt allows us to confirm that the person is who she/he says she/he is."
//                $0.cell.textLabel?.numberOfLines = 6
//        }
//        
//        form +++ Section("How does it work?")
//            <<< LabelRow(){
//                $0.title = "Once a child has been assigned to a parent. The parent will receive a notification on their mobile device each and every time a their child is signed in and out. Once the given parent clicks the button on the notification to accept that they are infact the person signing our their child, we will proceed to sign their child in or out. Please note that this feature must be turned from within Settings."
//                $0.cell.textLabel?.numberOfLines = 6
//        }
        
        form +++ Section("Information")
            
            <<< NameRow("Name") {
                $0.title = "name"
                $0.placeholder = "enter the adults name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< TextRow("Relationship") {
                $0.title = "relationship"
                $0.placeholder = "how is this adult related to the child?"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< PhoneRow("Mobile") {
                $0.title = "mobile"
                $0.placeholder = "enter the adults phone number"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< IntRow("CountryCode") {
                $0.title = "country code"
                $0.placeholder = "enter your code e.g 0044"
                $0.value = 0044
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< EmailRow("Email") {
                $0.title = "email"
                $0.placeholder = "enter the adults e-mail address"
                $0.add(rule: RuleEmail())
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Create new Authy user"
                }.onCellSelection {  cell, row in
                    
                    let row: NameRow? = self.form.rowBy(tag: "Name")
                    let Name = row?.value ?? ""
                    
                    let textRow: TextRow? = self.form.rowBy(tag: "Relationship")
                    let Relationship = textRow?.value ?? ""
                    
                    let phoneRow: PhoneRow? = self.form.rowBy(tag: "Mobile")
                    let Mobile = phoneRow?.value
                    
                    let intRow: IntRow? = self.form.rowBy(tag: "CountryCode")
                    let CountryCode = intRow?.value
                    
                    let emailRow: EmailRow? = self.form.rowBy(tag: "Email")
                    let Email = emailRow?.value ?? ""
                    
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    
                    AuthyRequests.sharedInstance.RegisterUser(email: Email, phoneNumber: Mobile!, countryCode: String(describing: CountryCode!), name: Name, relationship: Relationship, childId: self.selectedChildId, onCompletion:  { json in
                        
                        //self.createdAuthyId = json.rawString() as NSString!
                        
                        //Should get the authy id back from this create call.
                        //Pass authy id into the new view incase the user wants to do a test.
                        
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            
                            self._CommonHelper.ShowSuccessMessage(title: "Success", subsTtitle: "New Authy user successfully added.")
                            
                            self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                            
                        } )
                        
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
        
        self.navigationItem.title = "Authy Sign Up"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                vc.selectedMenu = .Authy
                
            }
            
        }
    }
    
}

