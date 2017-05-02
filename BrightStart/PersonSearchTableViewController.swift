//
//  PersonSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SVProgressHUD

class PersonSearchTableViewController:  UITableViewController, UITextFieldDelegate , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var GoToMenuType: MenuTypes!
    
    var targetDate: Date!
    
     var ShouldUseTapToSelect: Bool! = true
    
    var showNavigationBar = true
    
    var SelectedPersonFullName: NSString!
    var SelectedPersonId: NSString!
    
     var Purpose: NSString!
    var OptionText: NSString!
    
    var successSegueIdentifier = ""
    
    var children: [[BrightStartChild]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    func refreshTable()
    {
        children.removeAll()
        tableView.reloadData()
        refresh()
    }
    
    func refresh()
    {
        if(refreshControl==nil)
        {
            refreshControl?.beginRefreshing()
        }
        else{
            refreshTable(refreshControl)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        self.tableView.tableFooterView = UIView()
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        tableView.estimatedRowHeight =  tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.backgroundColor = StyleManager.TableBackGroundColour()
        
        refresh()
        
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.children.removeAll();
        
        if(successSegueIdentifier == "GoToTimeStampSearch" && Purpose=="GoToSearchPerson_ExtraMinutes")
        {
            
        //Get only the children who were late or early.
            
            //Retrieve all children
            ChildRequests.sharedInstance.GetAllChildrenWhoHaveExtraMinutesForGivenDay(targetDate: targetDate as NSDate, onCompletion:
                { json in
                
                for (index: _, subJson: JSON) in json {
                    
                    let child = BrightStartChild()
                    
                    child.ChildFullName = JSON["ChildFullName"].stringValue as NSString
                    child.ChildId = JSON["ChildId"].stringValue as NSString
                    
                    let dateFormatter = DateFormatter()
                    //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                    
                    let dateOfBirth = JSON["ChildDOB"].stringValue
                    
                    var newDate = dateFormatter.date(from: dateOfBirth)
                    
                    if(newDate == nil){
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        newDate = dateFormatter.date(from: dateOfBirth)
                        
                        if(newDate == nil){
                            continue
                        }
                    }
                    
                    child.ChildDOB = newDate!
                    
                    self.children.insert([child], at: 0)
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.children = self.children.reversed()
                    
                    self.tableView.reloadData()
                    sender?.endRefreshing()
                    
                    SVProgressHUD.dismiss(withDelay: 0, completion: {
                    
                    })
                    
                    
                })
                
            })
            
        }
        else
        {
            //Retrieve all children
            ChildRequests.sharedInstance.GetAllEnrolledChilren(onCompletion: { json in
                
                for (index: _, subJson: JSON) in json {
                    
                    let child = BrightStartChild()
                    
                    child.ChildFullName = JSON["ChildFullName"].stringValue as NSString
                    child.ChildId = JSON["ChildId"].stringValue as NSString
                    
                    let dateFormatter = DateFormatter()
                    //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                    
                    let dateOfBirth = JSON["ChildDOB"].stringValue
                    
                    var newDate = dateFormatter.date(from: dateOfBirth)
                    
                    if(newDate == nil){
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        
                        newDate = dateFormatter.date(from: dateOfBirth)
                        
                        if(newDate == nil){
                            continue
                        }
                    }
                    
                    child.ChildDOB = newDate!
                    
                    self.children.insert([child], at: 0)
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.children = self.children.reversed()
                    
                    self.tableView.reloadData()
                    sender?.endRefreshing()
                    
                    SVProgressHUD.dismiss(withDelay: 0, completion: {
                    })
                    
                    
                })
                
            })
        }
        
        
    }
    
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        return children.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrightStartChild", for: indexPath) as! PersonSearchTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
        if children.count > section && children[section].count > row {
            cell.child = children[section][row];
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(ShouldUseTapToSelect==true){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrightStartChild", for: indexPath) as! PersonSearchTableViewCell
            cell.child = children[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            self.SelectedPersonId = ((cell.child?.ChildId)! as String as String as NSString!)
            
            self.SelectedPersonFullName = ((cell.child?.ChildFullName)! as String as String as NSString!)
            
            self.performSegue(withIdentifier: successSegueIdentifier, sender: nil)
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            if(ShouldUseTapToSelect==true){
                return []
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrightStartChild", for: indexPath) as! PersonSearchTableViewCell
            cell.child = children[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            let rowTitle = OptionText
            
            let findTimeStamps = UITableViewRowAction(style: .normal, title: rowTitle as String?) { action, index in
                
                self.SelectedPersonId = ((cell.child?.ChildId)! as String as String as NSString!)
                
                self.SelectedPersonFullName = ((cell.child?.ChildFullName)! as String as String as NSString!)

                
                self.performSegue(withIdentifier: self.successSegueIdentifier, sender: nil)
                
            }
            findTimeStamps.backgroundColor = _ApplicatoinColours.TableBackGroundOptionColour
            
            return [findTimeStamps]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
       
        if (segue.identifier == "GoToTimeStampSearch") {
            
            //Settings the menu details.
            
            
             if let vc = segue.destination as? TimeStampSearchTableViewController {
                
                    vc.TargetDate = targetDate
                    vc.TargetPersonId = self.SelectedPersonId
                    vc.SelectedPersonFullName = self.SelectedPersonFullName
                    
                    if(self.OptionText == "Edit time stmaps.")
                    {
                        vc.OptionText = "Edit"
                    }
                    else if(self.OptionText == "Delete time stamps.")
                    {
                        vc.OptionText = "Delete"
                    }
                    else
                    {
                     vc.OptionText = ""
                    }
                    
                }
        }
            
        if (segue.identifier == "GoToInvoiceSearch") {
        
            if let vc = segue.destination as? InvoiceSearchTableViewController {
                vc.TargetPersonId = self.SelectedPersonId
                vc.SelectedPersonFullName = self.SelectedPersonFullName
                
                if(self.OptionText == "Invoice Search.")
                {
                    vc.OptionText = "Search"
                }
                else
                {
                    vc.OptionText = ""
                }
                
            }
        }
        
        
        else if (segue.identifier! == "GoToCalendar") {
            
            
            if(self.Purpose == "TimeStamps_Edit")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Edit"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            else if(self.Purpose == "GoToSearchPerson_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            else if(self.Purpose == "TimeStamps_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Delete"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            else if(self.Purpose == "GoToSearchPerson_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
           else if(self.Purpose == "TimeStamps_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Delete"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
           else if(self.Purpose == "TimeStamps_Search")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Search"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                }
            }
            
           else if(self.Purpose == "TimeStamps_ExtraMinutesFinder")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_ExtraMinutesFinder"
                    vc.selectCalendarPurpose = .MissingTimeStamps_Person
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            //Do I need this?
            else if(self.Purpose == "RegisteredHours_Edit")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Edit"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
           else if(self.Purpose == "RegisteredHours_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_ExtraMinutes"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            else if(self.Purpose == "RegisteredHours_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Delete"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            else if(self.Purpose == "RegisteredHours_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            else if(self.Purpose == "RegisteredHours_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Delete"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
           else if(self.Purpose == "RegisteredHours_Search")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Search"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
           else if(self.Purpose == "RegisteredHours_Missing")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Missing"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }

            else if (segue.identifier == "GoToMenu") {
                
                
                if let vc = segue.destination as? MainMenuViewController {
                    
                    if(GoToMenuType == .MainMenu)
                    {
                    vc.selectedMenu = .MainMenu
                    }
                    
                    if(GoToMenuType == .TimeStamps)
                    {
                        vc.selectedMenu = .TimeStamps
                    }
                    
                    
                }
                
            }        }
        
    }
    
    
    func SetNavigationBarDetails()
    {
        self.navigationController?.navigationBar.topItem?.title = " "
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.NavigationBarBackButton()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            SetNavigationBarDetails();
            
            if(self.Purpose == "TimeStamps_Edit")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "GoToSearchPerson_ExtraMinutes")
            {
                self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "TimeStamps_Delete")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "GoToSearchPerson_ExtraMinutes")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "TimeStamps_Delete")
            {
                self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "TimeStamps_Search")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "TimeStamps_ExtraMinutesFinder")
            {
                self.navigationItem.title="Extra minutes"
            }
                
                //Do I need this?
            else if(self.Purpose == "RegisteredHours_Edit")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "RegisteredHours_ExtraMinutes")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "RegisteredHours_Delete")
            {
                self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "RegisteredHours_ExtraMinutes")
            {
                self.navigationItem.title="Extra minutes."
            }
                
            else if(self.Purpose == "RegisteredHours_Delete")
            {
                 self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "RegisteredHours_Search")
            {
                self.navigationItem.title="Select a child"
            }
                
            else if(self.Purpose == "RegisteredHours_Missing")
            {
               self.navigationItem.title="Select a child"
            }
            
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    func NavBarMenuTapped(){
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    //So we can stil pull to refresh
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage
    {
        return UIImage(named:"Rocket")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "We didnt find anything..."
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Go back to the previous screen and try re-searching."
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    
    
    
}
