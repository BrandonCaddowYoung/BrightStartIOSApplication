//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class EditChild: FormViewController {
    
    var staffArray = Array<BrightStartStaff>()
    
    var _CommonHelper: CommonHelper!
   
    var targetChildId: String!
    
    var child = BrightStartChild()
     var account = Account()
     var perstonStatus = PersonStatus()
    
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
                view.text = "Editing a childs details."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
        
            ChildRequests.sharedInstance.GetChild(childId: targetChildId, onCompletion: { json in
            
            self.child.ChildId = (json["ChildId"].stringValue as NSString)
            self.child.AccountId = (json["AccountId"].stringValue as NSString)
            self.child.ChildFirstName = (json["ChildFirstName"].stringValue as NSString)
            self.child.ChildMiddleName = (json["ChildMiddleName"].stringValue as NSString)
            self.child.ChildLastName = (json["ChildLastName"].stringValue as NSString)
            self.child.ChildDOB = self._CommonHelper.GetDateObjectFromString(dateAsString: json["ChildDOB"].stringValue)
            self.child.ChildFullName = (json["ChildFullName"].stringValue as NSString)
            self.child.MedicalConditions = (json["MedicalConditions"].stringValue as NSString)
            self.child.GPsDetails = (json["GPsDetails"].stringValue as NSString)
            self.child.OtherNotes = (json["OtherNotes"].stringValue as NSString)
            self.child.EmergencyName = (json["EmergencyName"].stringValue as NSString)
            self.child.EmergencyRelation = (json["EmergencyRelation"].stringValue as NSString)
            self.child.EmergencyHomeNumber = (json["EmergencyHomeNumber"].stringValue as NSString)
            self.child.EmergencyMobileNumber = (json["EmergencyMobileNumber"].stringValue as NSString)
            self.child.EmergencyWorkNumber = (json["EmergencyWorkNumber"].stringValue as NSString)
            self.child.KeyWorkerId = (json["KeyWorkerId"].stringValue as NSString)
            self.child.EverNoteAccessToken = (json["EverNoteAccessToken"].stringValue as NSString)
           
            DispatchQueue.main.async(execute: {
     
                self.form +++ Section("Childs information")
                    
                    <<< NameRow("FirstName") {
                        $0.title = "first name"
                        $0.placeholder = "enter first name."
                        $0.value = self.child.ChildFirstName as String
                    }
                    
                    <<< NameRow("MiddleName") {
                        $0.title = "middle name"
                        $0.placeholder = "enter middle name."
                        $0.value = self.child.ChildMiddleName as String
                    }
                    
                    <<< NameRow("LastName") {
                        $0.title = "last name"
                        $0.placeholder = "enter last name."
                        $0.value = self.child.ChildLastName as String

                    }
                    
                    <<< DateRow("DatOfBirth"){
                        $0.title = "date of birth"
                        $0.value = Date(timeIntervalSinceReferenceDate: 0)
                        $0.value = self.child.ChildDOB
                }
                
                self.form +++ Section("Mdeical")
                    
                    <<< TextRow("MedicalConditions") {
                        $0.title = "medical conditions"
                        $0.placeholder = "enter the medical conditions."
                        $0.value = self.child.MedicalConditions as String
                    }
                    
                    <<< TextRow("GPsdetails") {
                        $0.title = "GP's details"
                        $0.placeholder = "enter the GP's details."
                        $0.value = self.child.GPsDetails as String
                    }
                    
                    <<< TextRow("OtherNotes") {
                        $0.title = "other notes"
                        $0.placeholder = "enter any other notes."
                        $0.value = self.child.OtherNotes as String

                }
                
                self.form +++ Section("Emergency")
                    
                    <<< NameRow("EmergencyName") {
                        $0.title = "name"
                        $0.placeholder = "Enter the emergency name."
                        $0.value = self.child.EmergencyName as String
                    }
                    
                    <<< PhoneRow("EmergencyMobile") {
                        $0.title = "emergency mobile"
                        $0.placeholder = "enter the emergency mobile number."
                        $0.value = self.child.EmergencyMobileNumber as String
                    }
                    
                    <<< PhoneRow("EmergencyWork") {
                        $0.title = "emergency work"
                        $0.placeholder = "enter the emergency work number."
                        $0.value = self.child.EmergencyWorkNumber as String
                    }
                    
                    <<< PhoneRow("EmergencyHome") {
                        $0.title = "emergency home"
                        $0.placeholder = "enter the emergency home number."
                        $0.value = self.child.EmergencyHomeNumber as String
                    }
                    
                    
                    <<< TextRow("RelationToChild") {
                        $0.title = "relation to child"
                        $0.placeholder = "enter the emergency relation."
                        $0.value = self.child.EmergencyRelation as String
                }
                
                
                
                
                KeyWorkerGroupRequests.sharedInstance.GetkeyWorkerGroupById(keyWorkerId: self.child.KeyWorkerId as String, onCompletion: { json in
                    
                    //let keyWorkerGroupId = (json["KeyWorkerGroupId"].stringValue)
                    let keyWorkerName = (json["Name"].stringValue)
                    
                    DispatchQueue.main.async(execute: {
                        
                        
                        PersonStatusRequests.sharedInstance.GetStatusById(personStatusId: self.child.ChildId as String, onCompletion: { json in
                            
                             let personStatusId = (json["PersonStatusId"].stringValue)
                            let leaver = (json["Leaver"].stringValue)
                            let currentlySignedIn = (json["CurrentlySignedIn"].stringValue)
                            
                            self.perstonStatus.PersonStatusId = personStatusId
                             self.perstonStatus.Leaver = leaver
                             self.perstonStatus.CurrentlySignedIn = currentlySignedIn
                            
                            DispatchQueue.main.async(execute: {
                                
                                self.form +++ Section("Status")
                                    
                                    <<< SwitchRow("Leaver") {
                                        $0.title = "leaver"
                                        $0.value = Bool(leaver)
                                }
                                
                                
                                AccountRequests.sharedInstance.GetAccount(accountId: self.child.AccountId as String, onCompletion: { json in
                                    
                                    self.account.AccountId = (json["AccountId"].stringValue)
                                    self.account.AccountName = (json["AccountName"].stringValue)
                                    self.account.AccountDetails = (json["AccountDetails"].stringValue)
                                    self.account.HouseNumber = (json["HouseNumber"].stringValue)
                                    self.account.Road = (json["Road"].stringValue)
                                    
                                    self.account.DateOpened = self._CommonHelper.GetDateObjectFromString(dateAsString: json["DateOpened"].stringValue)
                                    
                                    self.account.Town = (json["Town"].stringValue)
                                    self.account.County = (json["County"].stringValue)
                                    self.account.PostCode = (json["PostCode"].stringValue)
                                    self.account.HomePhoneNumber = (json["HomePhoneNumber"].stringValue)
                                    self.account.MotherWorkPhoneNumber = (json["MotherWorkPhoneNumber"].stringValue)
                                    self.account.FatherWorkPhoneNumber = (json["FatherWorkPhoneNumber"].stringValue )
                                    self.account.MotherBillingEmailAddress = (json["MotherBillingEmailAddress"].stringValue)
                                    self.account.FatherBillingEmailAddress = (json["FatherBillingEmailAddress"].stringValue)
                                    self.account.PayPalEmailAddress = (json["PayPalEmailAddress"].stringValue)
                                    self.account.MotherMobile = (json["MotherMobile"].stringValue)
                                    self.account.FatherMobile = (json["FatherMobile"].stringValue)
                                    
                                    self.account.FatherPayPercentage = (json["FatherPayPercentage"].stringValue)
                                    self.account.MotherPayPercentage = (json["MotherPayPercentage"].stringValue)
                                    self.account.MotherOccupation = (json["MotherOccupation"].stringValue)
                                    self.account.FatherOccupation = (json["FatherOccupation"].stringValue)
                                    self.account.FatherName = (json["FatherName"].stringValue)
                                    self.account.MotherName = (json["MotherName"].stringValue)
                                    self.account.ExistingAccountBalance = (json["ExistingAccountBalance"].stringValue)
                                    
                                    DispatchQueue.main.async(execute: {
                                        
                                        self.form +++ Section("Parents information")
                                            
                                            <<< NameRow("MothersName") {
                                                $0.title = "mothers name"
                                                $0.placeholder = "enter mothers name."
                                                $0.value = self.account.MotherName
                                            }
                                            
                                            <<< EmailRow("MothersEmail") {
                                                $0.title = "mothers e-mail"
                                                $0.placeholder = "enter mothers e-amil."
                                                $0.value = self.account.MotherBillingEmailAddress
                                            }
                                            
                                            <<< PhoneRow("MothersMobile") {
                                                $0.title = "mothers mobile"
                                                $0.placeholder = "enter mothers mobile."
                                                $0.value = self.account.MotherMobile
                                            }
                                            
                                            <<< TextRow("MothersOccupation") {
                                                $0.title = "mothers occupation"
                                                $0.placeholder = "enter mothers occupation."
                                                $0.value = self.account.MotherOccupation
                                            }
                                            
                                            <<< PhoneRow("MothersWork") {
                                                $0.title = "mothers work"
                                                $0.placeholder = "enter mothers work phone number."
                                                $0.value = self.account.MotherWorkPhoneNumber
                                            }
                                            
                                            <<< NameRow("FathersName") {
                                                $0.title = "fathers name"
                                                $0.placeholder = "enter fathers name."
                                                $0.value = self.account.FatherName
                                            }
                                            
                                            <<< EmailRow("FathersEmail") {
                                                $0.title = "fathers e-mail"
                                                $0.placeholder = "enter fathers e-amil."
                                                $0.value = self.account.FatherBillingEmailAddress
                                                
                                            }
                                            
                                            <<< PhoneRow("FathersMobile") {
                                                $0.title = "fathers mobile"
                                                $0.placeholder = "enter fathers mobile."
                                                $0.value = self.account.FatherMobile
                                                
                                            }
                                            
                                            <<< TextRow("FathersOccupation") {
                                                $0.title = "fathers occupation"
                                                $0.placeholder = "enter fathers occupation."
                                                $0.value = self.account.FatherOccupation
                                            }
                                            
                                            <<< PhoneRow("FathersWork") {
                                                $0.title = "fathers work"
                                                $0.placeholder = "enter fathers work phone number."
                                                $0.value = self.account.FatherWorkPhoneNumber
                                        }
                                        
                                        self.form +++ Section("Address")
                                            
                                            <<< IntRow("HouseNumber") {
                                                $0.title = "house number"
                                                $0.placeholder = "enter the house number."
                                                $0.value = Int(self.account.FatherBillingEmailAddress)
                                            }
                                            
                                            <<< TextRow("Road") {
                                                $0.title = "road"
                                                $0.placeholder = "enter the road."
                                                $0.value = self.account.Road
                                            }
                                            
                                            <<< TextRow("Town") {
                                                $0.title = "town"
                                                $0.placeholder = "enter the town."
                                                $0.value = self.account.Town
                                            }
                                            
                                            <<< TextRow("PostCode") {
                                                $0.title = "post-code"
                                                $0.placeholder = "enter the post-code."
                                                $0.value = self.account.PostCode
                                            }
                                            
                                            <<< TextRow("County") {
                                                $0.title = "county"
                                                $0.placeholder = "enter the county."
                                                $0.value = self.account.County
                                            }
                                            
                                            <<< PhoneRow("HomePhone") {
                                                $0.title = "home phone"
                                                $0.placeholder = "enter the home phoe number."
                                                $0.value = self.account.HomePhoneNumber
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        //Retrieve all staff
                                        StaffRequests.sharedInstance.GetAllStaff(onCompletion: { json in
                                            
                                            for (index: _, subJson: JSON) in json {
                                                
                                                let staffMember = BrightStartStaff()
                                                
                                                staffMember.FullName = JSON["FullName"].stringValue as NSString
                                                staffMember.StaffMemberId = JSON["StaffMemberId"].stringValue as NSString
                                                
                                                self.staffArray.append(staffMember)
                                            }
                                            
                                            DispatchQueue.main.async(execute: {
                                                
                                                self.form +++ Section("Key Worker Group")

                                                    <<< PickerInlineRow<BrightStartStaff>("PickStaffMember") {
                                                        $0.title = "Key Worker Staff Member"
                                                        $0.options = self.staffArray
                                                        
                                                        $0.displayValueFor = {
                                                            guard let pv = $0 else{
                                                                return nil
                                                            }
                                                            return "\(pv.FullName)"
                                                        }
                                                        
                                                        $0.value = self.GetStaffById(Id: self.child.KeyWorkerId)
                                                }
                                                
                                                    
                                                
                                                self.form +++ Section("")
                                                    <<< ButtonRow(){
                                                        $0.title = "Save Changes"
                                                        }.onCellSelection {  cell, row in
                                                            
                                                            self.UpdateChild()
                                                            
                                                            
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
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                      
                                    })
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                })
                                
                                
                            }
                                
                            )})
                        
                    }
                    
                    )})
             
           }
                )
        })
    }
    
    func GetStaffById(Id: NSString) -> BrightStartStaff?{
        return self.staffArray.filter({ $0.StaffMemberId == Id }).first
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Children
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
    
    
    func UpdateChild()
    {
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        //Account below
        
         var nameRow: NameRow? = self.form.rowBy(tag: "FirstName")
        var row: TextRow? = self.form.rowBy(tag: "FirstName")
        var intRow: IntRow? = self.form.rowBy(tag: "FirstName")
        
        //Need to get the rest of the values here!
        var emailRow: EmailRow? = self.form.rowBy(tag: "FirstName")
        
        let FirstName = nameRow?.value ?? ""
        
        nameRow = self.form.rowBy(tag: "MiddleName")
        let MiddleName = nameRow?.value ?? ""
        
        nameRow = self.form.rowBy(tag: "LastName")
        let LastName = nameRow?.value ?? ""
        
        let dob: DateRow? = self.form.rowBy(tag: "DatOfBirth")
        let DatOfBirth = (dob?.value)! as Date

        
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
        
        phoneRow = self.form.rowBy(tag: "MothersWork")!
        let motherWorkPhoneNumber = phoneRow.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "FathersWork")!
        let fatherWorkPhoneNumber = phoneRow.value ?? ""
        
        //  row = self.form.rowBy(tag: "PayPalEmailAddress")
        //  let payPalEmailAddress = row?.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "MothersMobile")!
        let motherMobile = phoneRow.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "FathersMobile")!
        let fatherMobile = phoneRow.value ?? ""
        
        row = self.form.rowBy(tag: "MothersOccupation")
        let motherOccupation = row?.value ?? ""
        
        row = self.form.rowBy(tag: "FathersOccupation")
        let fatherOccupation = row?.value ?? ""
        
        //row = self.form.rowBy(tag: "existingAccountBalance")
        //let existingAccountBalance = row?.value ?? ""
        
        row = self.form.rowBy(tag: "Details")
        let accountDetails = row?.value ?? ""
        
         nameRow = self.form.rowBy(tag: "EmergencyName")
        let emergencyName = nameRow?.value ?? ""
        
        row = self.form.rowBy(tag: "RelationToChild")
        let emergencyRelation = row?.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "EmergencyHome")!
        let emergencyHomeNumber = phoneRow.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "EmergencyMobile")!
        let emergencyMobileNumber = phoneRow.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "EmergencyWork")!
        let emergencyWorkNumber = phoneRow.value ?? ""
        
        row = self.form.rowBy(tag: "OtherNotes")
        let otherNotes = row?.value ?? ""
        
        row = self.form.rowBy(tag: "MedicalConditions")
        let medicalConditions = row?.value ?? ""
        
        let tRow: TextRow? = self.form.rowBy(tag: "GPsdetails")
        let gPsDetails = tRow?.value ?? ""
      
        emailRow = self.form.rowBy(tag: "MothersEmail")
        let MothersEmail = emailRow?.value ?? ""
        
        emailRow = self.form.rowBy(tag: "FathersEmail")
        let FathersEmail = emailRow?.value ?? ""
        
        nameRow = self.form.rowBy(tag: "MothersName")
        let MothersName = nameRow?.value ?? ""
        
        nameRow = self.form.rowBy(tag: "FathersName")
        let FathersName = nameRow?.value ?? ""
        
        
        let pickerRow: PickerInlineRow<BrightStartStaff>? = self.form.rowBy(tag: "PickStaffMember")
        
        let staffMember = pickerRow?.value
        
        let chosenStaffMemberId = staffMember?.StaffMemberId;
        
        
        ChildHelperRequests.sharedInstance.UpdateChild(childId: child.ChildId as String, childFirstName: FirstName, childMiddleName: MiddleName, childLastName: LastName, dob: DatOfBirth as NSDate, accountId: child.AccountId as String, medicalConditions: medicalConditions, gPsDetails: gPsDetails, emergencyName: emergencyName, emergencyRelation: emergencyRelation, emergencyHomeNumber: emergencyHomeNumber, emergencyMobileNumber: emergencyMobileNumber, emergencyWorkNumber: emergencyWorkNumber, keyWorkerId: chosenStaffMemberId as String?, everNoteAccessToken: child.EverNoteAccessToken as String, otherNotes: otherNotes, onCompletion:
            { json in
                
               // let accountId = (json["AccountId"].stringValue as NSString) as String
                
                DispatchQueue.main.async(execute: {
                    
                    AccountRequests.sharedInstance.UpdateAccount(accountId: self.child.AccountId as String, mothersEmail: MothersEmail, fathersEmail: FathersEmail, mothersName: MothersName, fathersName: FathersName, houseNumber: houseNumber, road: road, town: town, county: county, postCode: postCode, homePhoneNumber: homePhoneNumber, motherWorkPhoneNumber: motherWorkPhoneNumber, fatherWorkPhoneNumber: fatherWorkPhoneNumber, payPalEmailAddress: self.account.PayPalEmailAddress, motherMobile: motherMobile, fatherMobile: fatherMobile, motherOccupation: motherOccupation, fatherOccupation: fatherOccupation, existingAccountBalance: self.account.ExistingAccountBalance, accountDetails: accountDetails, dateOpened: self.account.DateOpened.ToURLString2(), onCompletion:
                        { json in
                            
                            DispatchQueue.main.async(execute: {
                                
                                 let switchRow: SwitchRow? = self.form.rowBy(tag: "Leaver")
                                let leaver = switchRow?.value
                                
                                PersonStatusRequests.sharedInstance.UpdatePersonStatus(personStatusId: self.child.ChildId as String, leaver: String(describing: leaver!), CurrentlySignedIn: self.perstonStatus.CurrentlySignedIn, onCompletion:
                                    { json in
                                        
                                        DispatchQueue.main.async(execute: {
                                            SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                            })
                                            
                                        })
                                })
                                
                                
                            })
                    })
                    
                    
                })
        })
        
        
        
        
        
    }
    
}



