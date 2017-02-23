//
//  MainMenuViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

enum MenuTypes: Int {
    case MainMenu
    case TimeStamps
    case Authy
    case AuthyUsers
    case RegisteredHours
}

enum PurposeTypes: Int {
    
    case None
    
    case Register
    case information
    case SignOut
   
    case RegisterdHours_Set
    case RegisterdHours_Edit
    case RegisteredHours_Delete
    case RegisteredHours_Search
    
    case TimeStamps_Set
    case TimeStamps_Edit
    case TimeStamps_Delete
    case TimeStamps_Search
    case TimeStamps_Missing
    
    case Authy_NewUser
    case Authy_Test
    case Authy_Settings
}

class MainMenuViewController: UIViewController {
    
   var targetPurpose: PurposeTypes!
    
    var loadingSpiiner: ProgressHUD!
    
    var selectedAuhtyId: NSString!
    
    var childId: NSString!
    
    var authyUsersOnly: Bool! = false
    
    var authyUserList = [AuthyUser]()
    
    var _ApplicatoinColours: ApplicatoinColours!
    
    var collectionView: UICollectionView!
    var topThirdView: UIView!
    
    var topThirdViewTopSpacer: UIView!
    var topThirdViewMiddleSpacer: UIView!
    
    var leftSpacer: UIView!
    var rightSpacer: UIView!
    
    var headingLabel: UILabel!
    //var bodyLabel: UILabel!
    
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

        _ApplicatoinColours = ApplicatoinColours()
        
        setupCollectionView()
        
        //Changes the color of the backgorund within the nav bar.
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor
        
        //Changes the color of the text within the nav bar
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = _ApplicatoinColours.FontColour
        
      loadMenuAssets()
        
        
        // Create and add the view to the screen.
        loadingSpiiner = ProgressHUD(text: "Loading")
        
        self.view.addSubview(loadingSpiiner)
        hideSpinner()
        
        
    }
    
    func fetchAuthyUsersBelongingToChild()
    {
        
    }
    
    func showSpinner()
    {
        loadingSpiiner.show()
    }
    
    func hideSpinner()
    {
        //if(loadingSpiiner!=nil){
        loadingSpiiner.hide()
        //}
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
            
            images = [UIImage(named: "Register")!, UIImage(named: "WatchesFrontView100")!, UIImage(named: "TimeCard")!, UIImage(named: "Fingerprint")!, UIImage(named: "Information")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToRegister", "GoToRegisteredHoursMenu", "GoToTimeStampsMenu", "GoToAuthyMenu", "GoToInformation", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Register, PurposeTypes.None, PurposeTypes.None, PurposeTypes.None, PurposeTypes.information, PurposeTypes.SignOut]
            
            DisplayTextList = ["Register",  "Registered Hours", "Time Stamps", "Auhty", "Informaiton", "Sign Out"]
            
            authyIdList = ["",  "", "", "", "", ""]
            
        case .TimeStamps:
            
            images = [UIImage(named: "Search")!, UIImage(named: "Edit")!, UIImage(named: "Delete")!, UIImage(named: "Home")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToSearchPerson", "GoToSearchPerson", "GoToSearchPerson", "GoToMainMenu", "GoToSignIn"]
            
             PurposeList = [PurposeTypes.TimeStamps_Search, PurposeTypes.TimeStamps_Edit, PurposeTypes.TimeStamps_Delete, PurposeTypes.None, PurposeTypes.SignOut]
            
            DisplayTextList = ["Search",  "Edit", "Delete", "Home", "Sign Out"]
            
            authyIdList = ["", "", "", "", ""]
            
            showNavigationBar = true
            
            
        case .RegisteredHours:
            
            images = [UIImage(named: "Binoculars100")!, UIImage(named: "Fantasy100")!,UIImage(named: "PencilTip100")!, UIImage(named: "Delete")!, UIImage(named: "Home")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToSearchPerson", "GoToSearchPerson","GoToSearchPerson", "GoToSearchPerson", "GoToMainMenu", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.RegisteredHours_Search, PurposeTypes.RegisterdHours_Set, PurposeTypes.RegisterdHours_Edit, PurposeTypes.RegisteredHours_Delete, PurposeTypes.None, PurposeTypes.SignOut]
            
            DisplayTextList = ["Search",  "Set", "Edit","Delete", "Home", "Sign Out"]
            
            authyIdList = ["", "", "", "","", ""]
            
            showNavigationBar = true
            
            
        case .Authy:
            
            images = [UIImage(named: "AddUserMale")!, UIImage(named: "TestTube")!,  UIImage(named: "Settings")!, UIImage(named: "Home")!, UIImage(named: "SignOut")!]
            
            segueIdList = ["GoToNewAuthyUser", "GoToTestAuthyUser", "GoToAuthySettings", "GoToMainMenu", "GoToSignIn"]
            
            PurposeList = [PurposeTypes.Authy_NewUser, PurposeTypes.Authy_Test, PurposeTypes.Authy_Settings, PurposeTypes.None, PurposeTypes.SignOut]
            
            DisplayTextList = ["New User",  "Test User", "Settings", "Home", "Sign Out"]
            
            authyIdList = ["", "", "", "", ""]
            
        case .AuthyUsers:
            
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
                            self.images.append(UIImage(named: "Standing Man")!) //Replace with Plus100
                            self.segueIdList.append("GoToNewAuthyUser")
                            self.DisplayTextList.append("New User")
                            self.authyIdList.append("")
                            self.PurposeList.append(PurposeTypes.None)

                        }
                        else{
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
       
        collectionView.backgroundColor = _ApplicatoinColours.BackGroundColour
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //For some reason above the collectionView there is space, this removes the space.
       // self.automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(collectionView)
        
        topThirdView = UIView()
        view.addSubview(topThirdView)
        
        topThirdViewTopSpacer = UIView()
        view.addSubview(topThirdViewTopSpacer)
        
        topThirdViewMiddleSpacer = UIView()
        view.addSubview(topThirdViewMiddleSpacer)
        
        headingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        headingLabel.text = "Menu"
        
        headingLabel.font = UIFont(name: "Helvetica Neue", size: _ApplicatoinColours.MenuHeadingFontSize)
        headingLabel.font = UIFont.systemFont(ofSize: _ApplicatoinColours.MenuHeadingFontSize, weight: UIFontWeightThin)
        
        headingLabel.textColor = _ApplicatoinColours.FontColour
        
        view.addSubview(headingLabel)
        
        setupConstraints()
        
    }
    
    func setupConstraints()
    {
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //The first view takes up a third of the screen.
        
        leftSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
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
        
        rightSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
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
        topThirdView.backgroundColor = _ApplicatoinColours.BackGroundColour

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
        topThirdViewTopSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
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
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //top
        headingLabel.topAnchor.constraint(
            equalTo: topThirdViewTopSpacer.bottomAnchor).isActive = true
        
        //left
        //headingLabel.leadingAnchor.constraint(
          //  equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        //headingLabel.trailingAnchor.constraint(
          //  equalTo: rightSpacer.leadingAnchor).isActive = true
        
        headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        headingLabel.addConstraint(NSLayoutConstraint(item: headingLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 21))
        
        topThirdViewMiddleSpacer.translatesAutoresizingMaskIntoConstraints = false
        topThirdViewMiddleSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        //left
        topThirdViewMiddleSpacer.leadingAnchor.constraint(
            equalTo: leftSpacer.trailingAnchor).isActive = true
        //right
        topThirdViewMiddleSpacer.trailingAnchor.constraint(
            equalTo: rightSpacer.leadingAnchor).isActive = true
        //top
        topThirdViewMiddleSpacer.topAnchor .constraint(
            equalTo: headingLabel.bottomAnchor).isActive = true
        
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
        
        if (segue.identifier == "GoToSearchPerson") {
            
            if(targetPurpose == .TimeStamps_Edit)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "TimeStamps_Edit"
                }
            }
            
            
            else if(targetPurpose == .TimeStamps_Delete)
            {
                
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Delete"
                
            }
            }
            
            else if(targetPurpose == .TimeStamps_Search)
            {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Search"
                
            }
            }
            
            else if(targetPurpose == .TimeStamps_Missing)
            {
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Missing"
                
                
            }
            }
            
            else if(targetPurpose == .TimeStamps_Edit)
            {
            if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                
                vc.selectCalendarPurpose = .TimeStamps
                
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                //vc.childId = self.SelectedPersonId as String
                //vc.childName = self.SelectedPersonFullName as String
            }
            }
            
           else if(targetPurpose == .RegisterdHours_Edit)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Edit"
                }
            }
                
                
            else if(targetPurpose == .RegisteredHours_Delete)
            {
                
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Delete"
                    
                }
            }
                
            else if(targetPurpose == .RegisteredHours_Search)
            {
                
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Search"
                    
                }
            }
                
            else if(targetPurpose == .RegisterdHours_Set)
            {
                if let vc = segue.destination as? PersonSearchTableViewController {
                    
                    vc.successSegueIdentifier = "GoToCalendar"
                    vc.Purpose = "RegisteredHours_Missing"
                    
                    
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
            
            if let vc = segue.destination as? AuthyTestViewController {
                
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
            
            //Settings the menu details.
            
            if let vc = segue.destination as? ClockingTableViewController {
                
                
            }
            
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
        
        return cell
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let foodCell = cell as! MainMenuButtonCollectionViewCell
        foodCell.button.setBackgroundImage(images[indexPath.row], for: .normal)
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    //Removes the navigation bar from the top
    override func viewWillDisappear(_ animated: Bool) {
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(false, animated: animated);
            super.viewWillDisappear(animated)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        hideSpinner()

        
         if(!showNavigationBar){
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
    }
    
}

extension MainMenuViewController: MainMenuButtonCollectionViewCellDelegate {
    
    func changeColorOfButton(forCell: MainMenuButtonCollectionViewCell) {
        //forCell.button.backgroundColor = UIColor.blue
    }
    
    func performSegue(segueId: String) {
        
            self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    func renderMenuAssets(menuType: MenuTypes) {
        
        selectedMenu = menuType
        
        loadMenuAssets()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.reloadData()
            
            self.hideSpinner()
            
        }
       
    }
}
