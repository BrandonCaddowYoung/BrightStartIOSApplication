//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class CreateStaff: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var keyWorkerGroupsArray = Array<KeyWorkerGroup>()
    
    var ChildrenArray = Array<BrightStartStaff>()
    
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
                view.text = "Adding a new Staff to Bright Start."
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
//                $0.title = "This feature allows you to add a new staff member to Bright Start."
//                $0.cell.textLabel?.numberOfLines = 5
//        }
//        
//        form +++ Section("How does it work?")
//            <<< LabelRow(){
//                $0.title = "Once a staff member has been added to Bright Start, administrators will be able to take advantage of all the features that Bright Start has to offer. Simply fill out the form below before tapping the button found at the bottom of this page."
//                $0.cell.textLabel?.numberOfLines = 6
//        }
        
        
        self.form +++ Section("General")
            
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
        
        self.form +++ Section("Mdeical")
            
            <<< TextRow("MedicalConditions") {
                $0.title = "medical conditions"
                $0.placeholder = "enter the medical conditions."
            }
            
            <<< TextRow("GPsdetails") {
                $0.title = "GP's details"
                $0.placeholder = "enter the GP's details."
            }
            
            <<< TextRow("OtherNotes") {
                $0.title = "other notes"
                $0.placeholder = "enter any other notes."
        }
        
        self.form +++ Section("Contact")
            
            <<< PhoneRow("HomePhone") {
                $0.title = "Home Phone"
            }
            
            <<< PhoneRow("Mobile") {
                $0.title =  "mobile"
                $0.placeholder = "enter the mobile number."
            }
            
            <<< EmailRow("Email") {
                $0.title =  "email"
                $0.placeholder = "enter the email"
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< PasswordRow("Password") {
                $0.title =  "password"
                $0.placeholder = "enter the password"
        }
        
        self.form +++ Section("Emergency")
            
            <<< NameRow("EmergencyName") {
                $0.title = "name"
                $0.placeholder = "Enter the emergency name."
            }
            
            <<< PhoneRow("EmergencyMobile") {
                $0.title = "emergency mobile"
                $0.placeholder = "enter the emergency mobile number."
            }
            
            <<< PhoneRow("EmergencyWork") {
                $0.title = "emergency work"
                $0.placeholder = "enter the emergency mobile number."
            }
            
            <<< PhoneRow("EmergencyHome") {
                $0.title = "emergency home"
                $0.placeholder = "enter the emergency home number."
            }
            
            
            <<< TextRow("RelationToStaff") {
                $0.title = "relation to Staff"
                $0.placeholder = "enter the emergency relation."
        }
        
        self.form +++ Section("Status")
            
            <<< SwitchRow("Leaver") {
                $0.title = "leaver"
        }
        
        
        //Retrieve all key worker grops
        KeyWorkerGroupRequests.sharedInstance.GetAllKeyWorkerGroups(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let kwg = KeyWorkerGroup()
                
                kwg.Name = (JSON["Name"].stringValue as NSString) as String
                kwg.KeyWorkerGroupId = (JSON["KeyWorkerGroupId"].stringValue as NSString) as String
                
                self.keyWorkerGroupsArray.append(kwg)
            }
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("Key Worker Group")
                    
                    <<< PickerInlineRow<KeyWorkerGroup>("PickKeyWorkerGroup") {
                        $0.title = "key worker group"
                        $0.options = self.keyWorkerGroupsArray
                        
                        $0.displayValueFor = {
                            guard let pv = $0 else{
                                return nil
                            }
                            return "\(pv.Name)"
                        }
                }
                
                self.form +++ Section()
                    <<< ButtonRow(){
                        $0.title = "Add new staff member"
                        }.onCellSelection {  cell, row in
                            
                            let passwordRow: PasswordRow? = self.form.rowBy(tag: "Password")
                            let password = passwordRow?.value
                            
                            //Need to get the rest of the values here!
                            var emailRow: EmailRow? = self.form.rowBy(tag: "FirstName")
                            
                            var nameRow: NameRow? = self.form.rowBy(tag: "FirstName")
                            let FirstName = nameRow?.value ?? ""
                            
                            nameRow = self.form.rowBy(tag: "MiddleName")
                            let MiddleName = nameRow?.value ?? ""
                            
                            nameRow = self.form.rowBy(tag: "LastName")
                            let LastName = nameRow?.value ?? ""
                            
                            let dob: DateRow? = self.form.rowBy(tag: "DatOfBirth")
                            let DatOfBirth = dob?.value
                            
                            emailRow = self.form.rowBy(tag: "Email")
                            let email = emailRow?.value ?? ""
                            
                            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                            SVProgressHUD.show()
                            
                            //Account below
                            
                            var row: TextRow? = self.form.rowBy(tag: "FirstName")
                            var intRow: IntRow? = self.form.rowBy(tag: "FirstName")
                            
                            intRow = self.form.rowBy(tag: "HouseNumber")
                            let houseNumber = String(intRow?.value ?? 0)
                            
                            row = self.form.rowBy(tag: "Road")
                            let road = row?.value ?? ""
                            
                            row = self.form.rowBy(tag: "Town")
                            let town = row?.value ?? ""
                            
                            row = self.form.rowBy(tag: "County")
                            let county = row?.value ?? ""
                            
                            row = self.form.rowBy(tag: "PostCode")
                            let postCode = row?.value ?? ""
                            
                            var phoneRow: PhoneRow = self.form.rowBy(tag: "HomePhone")!
                            let homePhoneNumber = phoneRow.value ?? ""
                            
                            phoneRow = self.form.rowBy(tag: "Mobile")!
                            let mobile = phoneRow.value ?? ""
                            
                            row = self.form.rowBy(tag: "MedicalConditions")
                            let medicalConditions = row?.value ?? ""
                            
                            let tRow: TextRow? = self.form.rowBy(tag: "GPsdetails")
                            let gPsDetails = tRow?.value ?? ""
                            
                            nameRow = self.form.rowBy(tag: "EmergencyName")
                            let EmergencyName = nameRow?.value ?? ""
                            
                            row = self.form.rowBy(tag: "RelationToStaff")
                            let emergencyRelation = row?.value ?? ""
                            
                            phoneRow = self.form.rowBy(tag: "EmergencyHome")!
                            let emergencyHomeNumber = phoneRow.value ?? ""
                            
                            phoneRow = self.form.rowBy(tag: "EmergencyWork")!
                            let emergencyWork = phoneRow.value ?? ""
                            
                            phoneRow = self.form.rowBy(tag: "EmergencyMobile")!
                            let emergencyMobileNumber = phoneRow.value ?? ""
                            
                            row = self.form.rowBy(tag: "OtherNotes")
                            let otherNotes = row?.value ?? ""
                            
                            let pickerRow: PickerInlineRow<KeyWorkerGroup>? = self.form.rowBy(tag: "PickKeyWorkerGroup")
                            
                            let kwg = pickerRow?.value
                            
                            let chosenKeyWorkerGroupId = kwg?.KeyWorkerGroupId;
                            
                            StaffHelperRequests.sharedInstance.CreateStaff(staffMemberId: "", firstName: FirstName, middleName: MiddleName, lastName: LastName, dOB: DatOfBirth!, road: road, county: county, homePhoneNumber: homePhoneNumber, postcode: postCode, mobileNumber: mobile, emailAddress: email, houseNumber: houseNumber, town: town, medicalConditions: medicalConditions, gPsDetails: gPsDetails, otherNotes: otherNotes, emergencyName: EmergencyName, emergencyRelation: emergencyRelation, emergencyHomeNumber: emergencyHomeNumber, emergencyMobileNumber: emergencyMobileNumber, emergencyWorkNumber: emergencyWork, password: password, keyWorkerGroupId: chosenKeyWorkerGroupId, onCompletion:
                                { json in
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                                            self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                        })
                                        
                                    })
                            })
                        }
                        .cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 70 }
                }
                
            })
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Staff
            }
            
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
        
        self.navigationItem.title = "Create"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
}




