//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class QuickCreateChild: FormViewController {
    
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
                view.text = "Adding a child to Bright Start."
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
//                $0.title = "This feature allows you to quickly add a new child to Bright Start."
//                $0.cell.textLabel?.numberOfLines = 5
//                //$0.cell.height = { 300 }
//        }
//        
//        form +++ Section("How does it work?")
//            <<< LabelRow(){
//                $0.title = "Simply complete the form below before tapping the button at the bottom of the page."
//                $0.cell.textLabel?.numberOfLines = 6
//        }
        
        form +++ Section("Childs information")
            
            <<< NameRow("FirstName") {
                $0.title = "first name"
                $0.placeholder = "enter first name."
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< NameRow("MiddleName") {
                $0.title = "middle name"
                $0.placeholder = "enter middle name."
            }
            
            <<< NameRow("LastName") {
                $0.title = "last name"
                $0.placeholder = "enter last name."
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< DateRow("DatOfBirth"){
                $0.title = "date of birth"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
        
        form +++ Section("Parents information")
            
            <<< NameRow("MothersName") {
                $0.title = "mothers name"
                $0.placeholder = "enter mothers name."
            }
            
            <<< EmailRow("MothersEmail") {
                $0.title = "mothers e-mail"
                $0.placeholder = "enter mothers e-amil."
                
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< NameRow("FathersName") {
                $0.title = "fathers name"
                $0.placeholder = "enter fathers name."
            }
            
            <<< EmailRow("FathersEmail") {
                $0.title = "fathers e-mail"
                $0.placeholder = "enter fathers e-amil."
                
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Add new child"
                }.onCellSelection {  cell, row in
                    
                    var row: NameRow? = self.form.rowBy(tag: "FirstName")
                    let FirstName = row?.value ?? ""
                    
                    row = self.form.rowBy(tag: "MiddleName")
                    let MiddleName = row?.value ?? ""
                    
                    row = self.form.rowBy(tag: "LastName")
                    let LastName = row?.value ?? ""
                    
                    let dob: DateRow? = self.form.rowBy(tag: "DatOfBirth")
                    let DatOfBirth = dob?.value
                    
                    row = self.form.rowBy(tag: "MothersName")
                    let MothersName = row?.value ?? ""
                    
                    row = self.form.rowBy(tag: "FathersName")
                    let FathersName = row?.value ?? ""
                    
                    var emailRow: EmailRow? = self.form.rowBy(tag: "MothersEmail")
                    let MothersEmail = emailRow?.value ?? ""
                    
                    emailRow = self.form.rowBy(tag: "FathersEmail")
                    let FathersEmail = emailRow?.value ?? ""
                    
                    
                    if  row?.section?.form?.validate().count != 0 {
                        
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            
                            self._CommonHelper.ShowErrorMessage(title: "You missed out an important filed.", subsTtitle: "In order to make your changes you will need to ammend the appropriate corrections.");
                            
                        } )
                        
                        
                    }
                    else {
                        self.CreateChild(mothersEmail: MothersEmail, fathersEmail: FathersEmail, mothersName: MothersName, fathersName: FathersName, childFirstName: FirstName, childMiddleName: MiddleName, childLastName: LastName, dob: DatOfBirth!)
                    }
                    
                }
                .cellUpdate
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Children
            }
        }
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    func CreateChild(mothersEmail: String, fathersEmail: String, mothersName: String, fathersName: String,
                     childFirstName: String, childMiddleName: String, childLastName: String, dob: Date)
    {
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        AccountRequests.sharedInstance.CreateAccount(mothersEmail: mothersEmail, fathersEmail: fathersEmail, mothersName: mothersName, fathersName: fathersName, onCompletion:
            { json in
                
                let accountId = (json["AccountId"].stringValue as NSString) as String
                
                DispatchQueue.main.async(execute: {
                    
                    ChildHelperRequests.sharedInstance.CreateChild(childFirstName: childFirstName, childMiddleName: childMiddleName, childLastName: childLastName, dob: dob as NSDate, accountId:accountId, onCompletion:
                        { json in
                            
                            DispatchQueue.main.async(execute: {
                                
                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                    self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                } )
                            })
                    })
                })
        })
    }
    
}

