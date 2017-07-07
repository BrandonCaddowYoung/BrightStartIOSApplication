//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class EditStaff: FormViewController {
    
    var keyWorkerGroupsArray = Array<KeyWorkerGroup>()
    
    var _CommonHelper: CommonHelper!
    
    var targetStaffId: String!
    
    var Staff = BrightStartStaff()
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
                view.text = "Editing a Staffs details."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
        }
        
        StaffRequests.sharedInstance.GetStaff(StaffId: targetStaffId, onCompletion: { json in
            
            self.Staff.StaffMemberId = (json["StaffMemberId"].stringValue as NSString)
            self.Staff.FirstName = (json["FirstName"].stringValue as NSString)
            self.Staff.MiddleName = (json["MiddleName"].stringValue as NSString)
            self.Staff.LastName = (json["LastName"].stringValue as NSString)
            self.Staff.FullName = (json["FullName"].stringValue as NSString)
            self.Staff.DOB = self._CommonHelper.GetDateObjectFromString(dateAsString: json["DOB"].stringValue)
            self.Staff.Road = (json["Road"].stringValue as NSString)
            self.Staff.County = (json["County"].stringValue as NSString)
            self.Staff.Postcode = (json["Postcode"].stringValue as NSString)
            self.Staff.HomePhoneNumber = (json["HomePhoneNumber"].stringValue as NSString)
            self.Staff.MobileNumber = (json["MobileNumber"].stringValue as NSString)
            self.Staff.EmailAddress = (json["EmailAddress"].stringValue as NSString)
            self.Staff.HouseNumber = (json["HouseNumber"].stringValue as NSString)
            self.Staff.Town = (json["Town"].stringValue as NSString)
            self.Staff.MedicalConditions = (json["MedicalConditions"].stringValue as NSString)
            self.Staff.GPsDetails = (json["GPsDetails"].stringValue as NSString)
            self.Staff.OtherNotes = (json["OtherNotes"].stringValue as NSString)
            self.Staff.EmergencyName = (json["EmergencyName"].stringValue as NSString)
            self.Staff.EmergencyRelation = (json["EmergencyRelation"].stringValue as NSString)
            self.Staff.EmergencyHomeNumber = (json["EmergencyHomeNumber"].stringValue as NSString)
            self.Staff.EmergencyMobileNumber = (json["EmergencyMobileNumber"].stringValue as NSString)
            self.Staff.EmergencyWorkNumber = (json["EmergencyWorkNumber"].stringValue as NSString)
            self.Staff.Password = (json["Password"].stringValue as NSString)
            self.Staff.KeyWorkerGroupId = (json["KeyWorkerGroupId"].stringValue as NSString)
            self.Staff.NurserySchoolId = (json["NurserySchoolId"].stringValue as NSString)

            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("Genearl")
                    
                    <<< NameRow("FirstName") {
                        $0.title = "first name"
                        $0.placeholder = "enter first name."
                        $0.value = self.Staff.FirstName as String
                    }
                    
                    <<< NameRow("MiddleName") {
                        $0.title = "middle name"
                        $0.placeholder = "enter middle name."
                        $0.value = self.Staff.MiddleName as String
                    }
                    
                    <<< NameRow("LastName") {
                        $0.title = "last name"
                        $0.placeholder = "enter last name."
                        $0.value = self.Staff.LastName as String
                        
                    }
                    
                    <<< DateRow("DatOfBirth"){
                        $0.title = "date of birth"
                        $0.value = Date(timeIntervalSinceReferenceDate: 0)
                        $0.value = self.Staff.DOB
                }
                
                self.form +++ Section("Mdeical")
                    
                    <<< TextRow("MedicalConditions") {
                        $0.title = "medical conditions"
                        $0.placeholder = "enter the medical conditions."
                        $0.value = self.Staff.MedicalConditions as String
                    }
                    
                    <<< TextRow("GPsdetails") {
                        $0.title = "GP's details"
                        $0.placeholder = "enter the GP's details."
                        $0.value = self.Staff.GPsDetails as String
                    }
                    
                    <<< TextRow("OtherNotes") {
                        $0.title = "other notes"
                        $0.placeholder = "enter any other notes."
                        $0.value = self.Staff.OtherNotes as String
                        
                }
                
                self.form +++ Section("Contact")
                    
                    <<< PhoneRow("HomePhone") {
                        $0.title = "Home Phone"
                        $0.value = self.Staff.HomePhoneNumber as String
                    }
                    
                    
                    <<< PhoneRow("Mobile") {
                        $0.title =  "mobile"
                        $0.placeholder = "enter the mobile number."
                        $0.value = self.Staff.MobileNumber as String
                }
                
                    <<< EmailRow("Email") {
                        $0.title =  "email"
                        $0.placeholder = "enter the email"
                        $0.value = self.Staff.EmailAddress as String
                }
                
                    <<< PasswordRow("Password") {
                        $0.title =  "password"
                        $0.placeholder = "enter the password"
                        $0.value = self.Staff.Password as String
                }
                
                
                
                
                
                
                self.form +++ Section("Emergency")
                    
                    <<< NameRow("EmergencyName") {
                        $0.title = "name"
                        $0.placeholder = "Enter the emergency name."
                        $0.value = self.Staff.EmergencyName as String
                    }
                    
                    <<< PhoneRow("EmergencyMobile") {
                        $0.title = "emergency mobile"
                        $0.placeholder = "enter the emergency mobile number."
                        $0.value = self.Staff.EmergencyMobileNumber as String
                    }
                    
                    <<< PhoneRow("EmergencyWork") {
                        $0.title = "emergency mobile"
                        $0.placeholder = "enter the emergency mobile number."
                        $0.value = self.Staff.EmergencyWorkNumber as String
                    }
                    
                    <<< PhoneRow("EmergencyHome") {
                        $0.title = "emergency home"
                        $0.placeholder = "enter the emergency home number."
                        $0.value = self.Staff.EmergencyHomeNumber as String
                    }
                    
                    
                    <<< TextRow("RelationToStaff") {
                        $0.title = "relation to Staff"
                        $0.placeholder = "enter the emergency relation."
                        $0.value = self.Staff.EmergencyRelation as String
                }                
                
                PersonStatusRequests.sharedInstance.GetStatusById(personStatusId: self.Staff.StaffMemberId as String, onCompletion: { json in
                    
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
                                        $0.title = "Key Worker Group"
                                        $0.options = self.keyWorkerGroupsArray
                                        
                                        $0.displayValueFor = {
                                            guard let pv = $0 else{
                                                return nil
                                            }
                                            return "\(pv.Name)"
                                        }
                                        
                                        $0.value = self.GetKeyWorkerGroupById(Id: self.Staff.KeyWorkerGroupId)
                                }
                                
                                
                                
                                self.form +++ Section("")
                                    <<< ButtonRow(){
                                        $0.title = "Save Changes"
                                        }.onCellSelection {  cell, row in
                                            
                                            self.UpdateStaff()
                                            
                                            
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
                        
                    )})
                
            }
            )
        })
    }
    
    func GetKeyWorkerGroupById(Id: NSString) -> KeyWorkerGroup?{
        return self.keyWorkerGroupsArray.filter({ $0.KeyWorkerGroupId == Id as String }).first
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
    
    
    func UpdateStaff()
    {
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        //Account below
        
        var nameRow: NameRow? = self.form.rowBy(tag: "FirstName")
        var row: TextRow? = self.form.rowBy(tag: "FirstName")
        var intRow: IntRow? = self.form.rowBy(tag: "FirstName")
         var passwordRow: PasswordRow? = self.form.rowBy(tag: "Password")
        
        let password = passwordRow?.value ?? ""
        
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
        
        nameRow = self.form.rowBy(tag: "EmergencyName")
        let emergencyName = nameRow?.value ?? ""
        
        row = self.form.rowBy(tag: "RelationToStaff")
        let emergencyRelation = row?.value ?? ""
        
        phoneRow = self.form.rowBy(tag: "EmergencyHome")!
        let emergencyHomeNumber = phoneRow.value ?? ""
        
        
        phoneRow = self.form.rowBy(tag: "EmergencyWork")!
        let emergencyWork = phoneRow.value ?? ""
        
        
        phoneRow = self.form.rowBy(tag: "Mobile")!
        let mobile = phoneRow.value ?? ""
        
        
        emailRow = self.form.rowBy(tag: "Email")
        let email = emailRow?.value ?? ""
        
        
        
        
        phoneRow = self.form.rowBy(tag: "EmergencyMobile")!
        let emergencyMobile = phoneRow.value ?? ""
        
        row = self.form.rowBy(tag: "OtherNotes")
        let otherNotes = row?.value ?? ""
        
        row = self.form.rowBy(tag: "MedicalConditions")
        let medicalConditions = row?.value ?? ""
        
        let tRow: TextRow? = self.form.rowBy(tag: "GPsdetails")
        let gPsDetails = tRow?.value ?? ""
        
        let pickerRow: PickerInlineRow<KeyWorkerGroup>? = self.form.rowBy(tag: "PickKeyWorkerGroup")
        
        let kwg = pickerRow?.value
        
        let chosenKeyWorkerGroupId = kwg?.KeyWorkerGroupId;
        
        StaffHelperRequests.sharedInstance.UpdateStaff(staffMemberId: Staff.StaffMemberId as String, firstName: FirstName, middleName: MiddleName, lastName: LastName, dOB: DatOfBirth, road: road, county: county, homePhoneNumber: homePhoneNumber, postcode: postCode, mobileNumber: mobile, emailAddress: email, houseNumber: houseNumber, town: town, medicalConditions: medicalConditions, gPsDetails: gPsDetails, otherNotes: otherNotes, emergencyName: emergencyName, emergencyRelation: emergencyRelation, emergencyHomeNumber: emergencyHomeNumber, emergencyMobileNumber: emergencyMobile, emergencyWorkNumber: emergencyWork, password: password, keyWorkerGroupId: chosenKeyWorkerGroupId, onCompletion:
            { json in
                
                // let accountId = (json["AccountId"].stringValue as NSString) as String
                
                DispatchQueue.main.async(execute: {
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                    })
                    
                })
        })
        
        
    }
    
}



