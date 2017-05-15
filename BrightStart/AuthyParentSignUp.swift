//
//  AuthyParentSignUp.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
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
                view.text = "Welcome!"
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
            <<< LabelRow("Target"){
                $0.title = "This feature allows you to quickly add a new child."
                $0.cell.textLabel?.numberOfLines = 5
                //$0.cell.height = { 300 }
        }
        
        form +++ Section("How does it work?")
            <<< LabelRow("test"){
                $0.title = "To get started, complete the form below before tapping the button at the bottom of the page."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Information")
            
            <<< NameRow("Name") {
                $0.title = "name"
                $0.placeholder = "enter the adults name"
            }
            
            <<< TextRow("Relationship") {
                $0.title = "relationship"
                $0.placeholder = "how is this adult related to the child?"
            }
            
            <<< PhoneRow("Mobile") {
                $0.title = "mobile"
                $0.placeholder = "enter the adults phone number"
            }
            
            <<< IntRow("CountryCode") {
                        $0.title = "country code"
                        $0.placeholder = "enter your code e.g 0044"
                        $0.value = 0044
            }
            
            <<< PhoneRow("Email") {
                                $0.title = "email"
                                $0.placeholder = "enter the adults email address"
        }
        
        self.form +++ Section("")
            <<< ButtonRow(){
                $0.title = "Create new Authy user"
                }.onCellSelection {  cell, row in
                    
                    var row: NameRow? = self.form.rowBy(tag: "Name")
                    let Name = row?.value ?? ""
                    
                    var textRow: TextRow? = self.form.rowBy(tag: "Relationship")
                    let Relationship = textRow?.value ?? ""
                    
                    let phoneRow: PhoneRow? = self.form.rowBy(tag: "Mobile")
                    let Mobile = phoneRow?.value
                    
                    var intRow: IntRow? = self.form.rowBy(tag: "CountryCode")
                    let CountryCode = intRow?.value
                    
                    let emailRow: EmailRow? = self.form.rowBy(tag: "Email")
                    let Email = emailRow?.value ?? ""
                    
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    //Retrieve all children
                    AuthyRequests.sharedInstance.RegisterUser(email: Email, phoneNumber: Mobile!, countryCode: String(describing: CountryCode), name: Name, relationship: Relationship, childId: self.selectedChildId, onCompletion:  { json in
                        
                        //self.createdAuthyId = json.rawString() as NSString!
                        
                        //Should get the authy id back from this create call.
                        //Pass authy id into the new view incase the user wants to do a test.
                        
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            
                            self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                            
                            self.performSegue(withIdentifier: "GoToNewUserComplete", sender: self)
                            
                        } )
                        
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

