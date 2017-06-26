//
//  MainMenuViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit
import SVProgressHUD

enum MenuTypes: Int {
    case MainMenu
    case Children
    case TimeStamps
    case Authy
    case AuthyUsers
    case RegisteredHours
    case Billing
    case Settings
}

enum EditTimeStampVCPurpose: Int {
    case edit
    case delete
    case view
}

enum PurposeTypes: Int {
    
    case None
    
    case Children
    case Register
    case information
    case SignOut
   
    case Child_QuickCreate
    case Child_Create
    case Child_Edit
    case Child_Delete
    
    case RegisterdHours_Set
    case RegisterdHours_SetWeekly
    case RegisterdHours_RollOver
    case RegisterdHours_Edit
    case RegisteredHours_Delete
    case RegisteredHours_Search
    
    case TimeStamps_Set
    case TimeStamps_Edit
    case TimeStamps_Delete
    case TimeStamps_Search
    case TimeStamps_MissingTimeStampsFinder
    case TimeStamps_ExtraMinutesFinder
    case TimeStamps_Menu
    
     case Settings_Menu
    case Settings_Rates
    case Email_Settings
    case NurseryDetails_Settings
    
    case Billing_Menu
    case Billing_CreateInvoice
    case Billing_ViewInvoice
    
    case Authy_NewUser
    case Authy_Test
    case Authy_Settings
}

class MainMenuViewController: UIViewController {
    
    var shouldHideBackButton = true
    
   var targetPurpose: PurposeTypes!
    
    var selectedAuhtyId: NSString!
    
    var childId: NSString!
    
    var authyUsersOnly: Bool! = false
    
    var authyUserList = [AuthyUser]()
   
    var _CommonHelper: CommonHelper!
    
    var collectionView: UICollectionView!
    var topThirdView: UIView!
    
    var topThirdViewTopSpacer: UIView!
    var topThirdViewMiddleSpacer: UIView!
    
    var leftSpacer: UIView!
    var rightSpacer: UIView!
    
    var selectedMenu = MenuTypes.MainMenu
    
    var selectedAuthyAction = AuhtyActions.ShouldDoNothing
    
    var images = [UIImage]()
    
    var DisplayTextList = ["",  "", "", ""]

    var PurposeList = [PurposeTypes]()
    
    var segueIdList = ["", "", "", ""]
    
    var authyIdList = ["", "", "", ""]
    
    var showNavigationBar = false
    
    func setTargetPurpose(type: PurposeTypes)
    {
        targetPurpose = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .light)
        
        self.edgesForExtendedLayout = []
        
        _CommonHelper = CommonHelper()
        
        setupCollectionView()
        
        SetNavigationBarDetails()
        
        loadMenuAssets()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func fetchAuthyUsersBelongingToChild()
    {
        
    }
    
    func setSelectedAuthyId(authyID: NSString)
    {
        self.selectedAuhtyId = authyID
    }
    
    func loadMenuAssets()
    {
        self.images = []
        self.segueIdList = []
        self.DisplayTextList = []
        self.authyIdList = []
        
        switch selectedMenu {
            
        case .MainMenu:
            
            images = [UIImage(named: "Register")!,UIImage(named: "Children")!, UIImage(named: "WatchesFrontView100")!, UIImage(named: "TimeCard")!, UIImage(named: "Fingerprint")!, UIImage(named: "Billing")!, UIImage(named: "Settings")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToRegister", "GoToChildrenMenu", "GoToRegisteredHoursMenu", "GoToTimeStampsMenu", "GoToAuthyMenu", "GoToBillingMenu","GoToSettingsMenu", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Register, PurposeTypes.Children, PurposeTypes.RegisterdHours_Edit, PurposeTypes.TimeStamps_Edit, PurposeTypes.TimeStamps_Menu,PurposeTypes.Billing_Menu, PurposeTypes.Settings_Menu, PurposeTypes.SignOut]
            
            DisplayTextList = ["Register",  "Children", "Registered Hours", "Time Stamps", "Auhty", "Billing", "Settings", "Sign Out"]
            
            authyIdList = ["", "", "", "",  "", "", "", ""]
            
            showNavigationBar = true
            ShowNavBar()
            
        case .Billing:
            
            images = [UIImage(named: "Fantasy100")!, UIImage(named: "Bill")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToCreateInvoice", "GoToSearchPerson", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Billing_CreateInvoice, PurposeTypes.Billing_ViewInvoice, PurposeTypes.SignOut]
            
            DisplayTextList = ["Create Invoices", "View Invoices", "Sign Out"]
            
            authyIdList = ["", "","", ""]
            
            showNavigationBar = true
            ShowNavBar()
            
        case .Settings:
            
            images = [UIImage(named: "Rates")!, UIImage(named: "email-100")!, UIImage(named: "Details-100")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToRates", "GoToEmailSettings", "GoToNurseryDetails", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Settings_Rates, PurposeTypes.Email_Settings, PurposeTypes.NurseryDetails_Settings, PurposeTypes.SignOut]
            
            DisplayTextList = ["Rates"," Email", "Details", "Sign Out"]
            
            authyIdList = ["", "", "", "", ""]
            
            showNavigationBar = true
            ShowNavBar()
            
        case .TimeStamps:
            
            //uncomment for missing timestamps, also fill in the rest. The end result actually just returns current timestamps for the day, not missing time stamps!
            
            images = [UIImage(named: "Calendar")!, UIImage(named: "Search")!, UIImage(named: "Search")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToSearchPerson", "GoToExtraTimeFinder", "GoToMissingTimeStamps", "GoToSignIn"]
            
             PurposeList = [PurposeTypes.TimeStamps_Edit, PurposeTypes.TimeStamps_ExtraMinutesFinder,PurposeTypes.TimeStamps_MissingTimeStampsFinder, PurposeTypes.SignOut]
            
            DisplayTextList = ["Calendar", "Extra Minutes Finder", "Missing Time Stamps", "Sign Out"]
            
            authyIdList = ["", "", "", "", ""]
                
            showNavigationBar = true
            ShowNavBar()
            
            
        case .RegisteredHours:
            
            images = [UIImage(named: "Calendar")!, UIImage(named: "WeekView")!, UIImage(named: "Overtime")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToSearchPerson", "GoToSettingWeeklyRegisterdHours", "GoToRollOver", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.RegisterdHours_Edit, PurposeTypes.RegisterdHours_SetWeekly, PurposeTypes.RegisterdHours_RollOver, PurposeTypes.SignOut]
            
            DisplayTextList = ["Calendar", "Set Weekly", "Roll Over", "Sign Out"]
            
            authyIdList = ["", "", "", ""]
            
            showNavigationBar = true
            ShowNavBar()
            
        case .Children:
            
            images = [UIImage(named: "AddUserMale")!, UIImage(named: "AddUserMale")!, UIImage(named: "Search")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToQuickCreateChild", "GoToCreateChild", "GoToSearchPerson", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Child_QuickCreate, PurposeTypes.Child_Create,  PurposeTypes.Child_Edit,  PurposeTypes.SignOut]
            
            DisplayTextList = ["Quick Create", "Create", "View", "Sign Out"]
            
            authyIdList = ["", "", "", ""]
            
            showNavigationBar = true
            ShowNavBar()
            
        case .Authy:
            
            images = [UIImage(named: "AddUserMale")!, UIImage(named: "TestTube")!,  UIImage(named: "Settings")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToNewAuthyUser", "GoToTestAuthyUser", "GoToAuthySettings", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Authy_NewUser, PurposeTypes.Authy_Test, PurposeTypes.Authy_Settings, PurposeTypes.SignOut]
            
            DisplayTextList = ["New User",  "Test User", "Settings", "Sign Out"]
            
            authyIdList = ["", "", "", ""]
            
            showNavigationBar = true
            ShowNavBar()
            
        case .AuthyUsers:
            
            showNavigationBar = true
            ShowNavBar()
            
            //Retrieve all children
            AuthyRequests.sharedInstance.GetAllAuthyUsersForChild(childId: childId as String, onCompletion:
                { json in
                    
                    for (index: _, subJson: JSON) in json {
                        
                        let targetAuthyUser = AuthyUser()
                        
                        targetAuthyUser.CountryCode = JSON["CountryCode"].stringValue as NSString
                        targetAuthyUser.PhoneNumber = JSON["PhoneNumber"].stringValue as NSString
                        targetAuthyUser.Relationship = JSON["Relationship"].stringValue as NSString
                        targetAuthyUser.ChildId = JSON["ChildId"].stringValue as NSString
                        targetAuthyUser.Email = JSON["Email"].stringValue as NSString
                        targetAuthyUser.Name = JSON["Name"].stringValue as NSString
                        targetAuthyUser.AuhtyId = JSON["AuthyId"].stringValue as NSString
                        
                        self.authyUserList.insert(targetAuthyUser, at: 0)
                    }
                    
                    DispatchQueue.main.async(execute: {
                        
                        if(self.authyUserList.count == 0)
                        {
                            if(self.selectedAuthyAction == .ShouldSignIn || self.selectedAuthyAction == .ShouldSignOut)
                            {
                                if(self.selectedAuthyAction == .ShouldSignOut){
                                    
                                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                                    SVProgressHUD.show()
                                    
                                            CommonRequests.sharedInstance.signOut(personId: self.childId as String, timeOfSignOut: Date() as NSDate,
                                                                                  
                                                                                  onCompletion: {
                                                                                    
                                                                                    DispatchQueue.main.async(execute: {
                                                                                        
                                                                                        
                                                                                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                                            
                                                                                             self.performSegue(withIdentifier: "GoToRegister", sender: self)
                                                                                            
                                                                                            
                                                                                        } )
                                                                                        
                                                                                       
                                                                                        
                                                                                    })
                                                                                    
                                            })
                                
                                }
                                else if(self.selectedAuthyAction == AuhtyActions.ShouldSignIn){
                                    
                                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                                    SVProgressHUD.show()
                                    
                                    CommonRequests.sharedInstance.signIn(personId: self.childId as String, timeOfSignIn: Date() as NSDate,
                                                                         onCompletion: {
                                                                            DispatchQueue.main.async(execute: {
                                                                                
                                                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                                    self.performSegue(withIdentifier: "GoToRegister", sender: nil)
                                                                                } )
                                                                                
                                                                                
                                                                                
                                                                            })
                                    }
                                    )
                                    
                                    
                                }
                            }
                            else{
                            
                            self.images.append(UIImage(named: "Standing Man")!) //Replace with Plus100
                            self.segueIdList.append("GoToNewAuthyUser")
                            self.DisplayTextList.append("New User")
                            self.authyIdList.append("")
                            self.PurposeList.append(PurposeTypes.None)
                                
                            }
                        }
                        else{
                            
                            //Add all the users
                            
                        for person in self.authyUserList {
                            self.images.append(UIImage(named: "UserMale100")!)
                            self.segueIdList.append("GoToAuthyAuthenticate")
                            self.DisplayTextList.append(person.Name as String)
                            self.authyIdList.append(person.AuhtyId as String)
                            self.PurposeList.append(PurposeTypes.None)

                        }
                        }
                        
                        
                        if(self.authyUsersOnly==false){
                            
                            self.images.append(UIImage(named: "QuestionMark100")!)
                            self.images.append(UIImage(named: "PasswordCheck100")!)
                            
                            self.segueIdList.append("GoToAuthyHelp")
                            self.segueIdList.append("GoToAuhtyPassword")
                            
                            self.DisplayTextList.append("help")
                            self.DisplayTextList.append("Password")
                            
                            self.authyIdList.append("")
                            self.authyIdList.append("")
                            
                           self.PurposeList.append(PurposeTypes.None)
                            
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.collectionView.reloadData()
                           
                        }
                        
                    })
                    
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    //Initialising a collection view and addit it to the view controllers current view
    func setupCollectionView()
    {
        leftSpacer = UIView()
        view.addSubview(leftSpacer)
        
        rightSpacer = UIView()
        view.addSubview(rightSpacer)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 30
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(MainMenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: "mainMenuButtonCell")
        
        collectionView.contentInset  = UIEdgeInsets();
        collectionView.contentInset.left = 25
        collectionView.contentInset.right = 25
       
        collectionView.backgroundColor = StyleManager.theme2()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = layout
        
        view.addSubview(collectionView)
        
        topThirdView = UIView()
        view.addSubview(topThirdView)
        
        topThirdViewTopSpacer = UIView()
        view.addSubview(topThirdViewTopSpacer)
        
        topThirdViewMiddleSpacer = UIView()
        view.addSubview(topThirdViewMiddleSpacer)
        
        view.backgroundColor = StyleManager.DarkBackground()
        
        setupConstraints()
    }
    
    func setupConstraints()
    {
       
        //The first view takes up a third of the screen.
        
        leftSpacer.backgroundColor = StyleManager.theme2()
        leftSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        leftSpacer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //top
        leftSpacer.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        //bottom
        leftSpacer.bottomAnchor .constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        leftSpacer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        
        //leftSpacer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        rightSpacer.backgroundColor = StyleManager.theme2()
        rightSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        rightSpacer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //top
        rightSpacer.topAnchor .constraint(
            equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        //bottom
        rightSpacer.bottomAnchor .constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        rightSpacer.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        
        
        //rightSpacer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        topThirdView.translatesAutoresizingMaskIntoConstraints = false
        topThirdView.backgroundColor = StyleManager.theme2()

        //left
        topThirdView.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdView.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //top
        topThirdView.topAnchor .constraint(
            equalTo: topLayoutGuide.bottomAnchor).isActive = true
        //height
        topThirdView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.10).isActive = true
        
        
       //topThirdView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        topThirdViewTopSpacer.translatesAutoresizingMaskIntoConstraints = false
        topThirdViewTopSpacer.backgroundColor = StyleManager.theme2()
        
        //left
        topThirdViewTopSpacer.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdViewTopSpacer.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
       
        //top
        topThirdViewTopSpacer.topAnchor .constraint(
            equalTo: topThirdView.topAnchor).isActive = true
        
        //height
        topThirdViewTopSpacer.heightAnchor.constraint(
            equalTo: topThirdView.heightAnchor,
            multiplier: 0.25).isActive = true
        
        //topThirdViewTopSpacer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        //Now addin the menu label the top left
        
        
        topThirdViewMiddleSpacer.translatesAutoresizingMaskIntoConstraints = false
        topThirdViewMiddleSpacer.backgroundColor = StyleManager.theme2()
        
        //left
        topThirdViewMiddleSpacer.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdViewMiddleSpacer.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //top
        topThirdViewMiddleSpacer.topAnchor .constraint(
            equalTo: topThirdViewTopSpacer.bottomAnchor).isActive = true
        
        //height
        topThirdViewMiddleSpacer.heightAnchor.constraint(
            equalTo: topThirdView.heightAnchor,
            multiplier: 0.15).isActive = true
        
        //The second view takes up the remining 66% of the screen
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                //left
        collectionView.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        collectionView.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //bottom
        collectionView.bottomAnchor .constraint(
            equalTo: view.bottomAnchor).isActive = true
        //top
        collectionView.topAnchor.constraint(
            equalTo: topThirdView.bottomAnchor).isActive = true
        
        //Adding the heading label to the top left
        
        // collectionView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToRates") {
            if segue.destination is Settings_Billing_Rates {
            }
        }
        
        else if (segue.identifier == "GoToDateSelect") {
            
            if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                
                vc.Purpose = "TimeStamps_ExtraMinutesFinder"
                vc.selectCalendarPurpose = .ExtraMinutesFinder_Date
                
                vc.showNavigationBar = true
            }
        }
            
        else if (segue.identifier == "GoToDateSelect") {
            
            if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                
                vc.Purpose = "TimeStamps_MissingTimeStampsFinder"
                vc.selectCalendarPurpose = .ExtraMinutesFinder_Date
                
                //This is as far as I have got, next I need to be able to select date range from the calendar.
                
                vc.showNavigationBar = true
            }
        }   
        
        else if (segue.identifier == "GoToSearchPerson") {
            
            if(targetPurpose == .TimeStamps_Edit)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "TimeStamps_Edit"
                    
                    vc.GoToMenuType = .TimeStamps
                    
                    vc.showNavigationBar = true
                }
            }
            else if(targetPurpose == .TimeStamps_Delete)
            {
                
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Delete"
                vc.GoToMenuType = .TimeStamps
                
            }
            }
            
            else if(targetPurpose == .TimeStamps_Search)
            {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Search"
                vc.GoToMenuType = .TimeStamps
                
            }
            }
            
            else if(targetPurpose == .TimeStamps_ExtraMinutesFinder)
            {
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_ExtraMinutesFinder"
                vc.GoToMenuType = .TimeStamps
                
            }
            }
            
            else if(targetPurpose == .TimeStamps_Edit)
            {
            if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                
                vc.selectCalendarPurpose = .TimeStamps
                
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                
                vc.showNavigationBar = true
                
            }
            }
            
           else if(targetPurpose == .RegisterdHours_Edit)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Edit"
                    vc.GoToMenuType = .RegisteredHours
                }
            }
                
                
            else if(targetPurpose == .RegisteredHours_Delete)
            {
                
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Delete"
                    vc.GoToMenuType = .RegisteredHours
                }
            }
                
            else if(targetPurpose == .RegisteredHours_Search)
            {
                
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Search"
                    vc.GoToMenuType = .RegisteredHours
                    
                }
            }
                
            else if(targetPurpose == .RegisterdHours_Set)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Missing"
                    vc.GoToMenuType = .RegisteredHours
                }
            }
            
            else if(targetPurpose == .Billing_ViewInvoice)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToInvoiceSearch"
                    vc.GoToMenuType = .Billing
                    vc.Purpose = ""
                }
            }
            
            else if(targetPurpose == .Child_Edit)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToEditChild"
                    vc.GoToMenuType = .Children
                    vc.Purpose = ""
                }
            }
            
            
            
        }
       
       else if (segue.identifier == "GoToTimeStampsMenu") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? TimeStampsMenuController {
                
                vc.selectedMenu = .TimeStamps
                
            }
        }   
        
       else if (segue.identifier == "GoToAuthyAuthenticate") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? AuthyAuthenticateViewController {
                
                vc.targetAuthyId =  selectedAuhtyId
                vc.numberOfSeconsToWait = 60
                vc.successSegueIdentifier = "GoToMainMenu"
                vc.selectedAuthyAction = selectedAuthyAction
                vc.targetChildId = childId
            }
            
        }
        else if (segue.identifier == "GoToNewAuthyUser") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? AuthyPersonSearchTableViewController {
                
                vc.successSeqgueIdentifier = "GoToNewAuthyUser"
                
                vc.ShouldUseTapToSelect = true
                
            }
        }
        else if (segue.identifier == "GoToTestAuthyUser") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? AuthyPersonSearchTableViewController {
                
                vc.successSeqgueIdentifier = "GoToTestAuthyUser"
                vc.showNavigationBar = true
                
            }
            
        }
        else if (segue.identifier == "GoToRegister") {
            //No need to pass anyhting to the regiser.
        }
    }
}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Specifying the number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Specifying the number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //We use this method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuButtonCell", for: indexPath) as! MainMenuButtonCollectionViewCell
        
        if(cell.label==nil){
        cell.awakeFromNib()
        cell.delegate = self
        }
        
        cell.setDisplayText(newDisplayText: DisplayTextList[indexPath.row])
        
        cell.setAuthyId(auhtyId: authyIdList[indexPath.row])
        
        cell.segueText = segueIdList[indexPath.row]
        
        cell.targetPurpose = PurposeList[indexPath.row]
        
        //var bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        
       // cell.layer.borderColor = bcolor.cgColor
        //cell.layer.borderWidth = 0.5
        //cell.layer.cornerRadius = 3
        
       // cell.backgroundColor = .white
        
        return cell
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let foodCell = cell as! MainMenuButtonCollectionViewCell
        
        foodCell.button.setBackgroundImage(images[indexPath.row], for: .normal)
       
        let tintedImage = images[indexPath.row].withRenderingMode(.alwaysTemplate)
        
        foodCell.button.setBackgroundImage(tintedImage, for: .normal)
        
        foodCell.button.tintColor = StyleManager.DarkBackground()
        
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    //Removes the navigation bar from the top
    override func viewWillDisappear(_ animated: Bool) {
        
         super.viewWillDisappear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(false, animated: animated);
           
        }
        else
        {
         self.navigationController?.setNavigationBarHidden(true, animated: animated);
        }
        
    }
    
    func NavBarMenuTapped(){
        
        //There are some exceptions here. For instance if looking at authy users, we should go back to the authy menu.
        
        renderMenuAssets(menuType: .MainMenu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        
        ShowNavBar()
    }
 
    
    func ShowNavBar()
    {
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            SetNavigationBarDetails()
        }
    }
   
    
    func SetNavigationBarDetails()
    {
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.navigationController?.navigationBar.topItem?.title = " "
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.NavigationBarBackButton()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        
        if(selectedMenu == .MainMenu)
        {
            //When about scren is built, put this in!
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "About"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            //Right button
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarBackGround()
            
        }
        else
        {
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            //Right button
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        }
        
        switch selectedMenu {
        case .MainMenu:
            self.navigationItem.title="Menu"
        case .Billing:
            self.navigationItem.title="Billing"
        case .TimeStamps:
            self.navigationItem.title="Time Stamps"
        case .RegisteredHours:
            self.navigationItem.title="Registered Hours"
        case .Authy:
            self.navigationItem.title="Authy"
        case .AuthyUsers:
            self.navigationItem.title="Authy Users"
        case .Children:
            self.navigationItem.title="Children"
        default: break
        }
    }
}

extension MainMenuViewController: MainMenuButtonCollectionViewCellDelegate {
    
    func performSegue(segueId: String) {
        
            self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    func renderMenuAssets(menuType: MenuTypes) {
        
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
                self.selectedMenu = menuType
                
                self.loadMenuAssets()
        
                self.SetNavigationBarDetails()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    self.collectionView.reloadData()
                    
                    SVProgressHUD.dismiss(withDelay: 0.1, completion: {
                       
                        
                    } )
        }
      
        
        }
    
    }

