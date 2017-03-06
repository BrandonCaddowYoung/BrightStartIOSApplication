//
//  PersonSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class PersonSearchTableViewController:  UITableViewController, UITextFieldDelegate {
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator()
    {
        indicator = UIActivityIndicatorView(frame: CGRect())
        
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            //Changes the color of the backgorund within the nav bar.
            navigationController?.navigationBar.barStyle = UIBarStyle.black
            navigationController?.navigationBar.barTintColor = _ApplicatoinColours.Black
            
            //Title color
            let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.Black]
            navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
            
            //Back color
            navigationController?.navigationBar.tintColor = _ApplicatoinColours.NavigationBarBackBackButtonColor //Orange
            
            //Back ground color
            navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor // Grey
            
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            
            self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black
            
            navigationController?.navigationBar.topItem?.title = "Search"
            
            navigationController?.navigationBar.backItem?.title = ""
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)

        }
        
    }
    
    func NavBarMenuTapped(){
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        indicator.hidesWhenStopped = true
        
        tableView.estimatedRowHeight =  tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        refresh()
        
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.children.removeAll();
        
        if(successSegueIdentifier == "GoToTimeStampsMenu" && Purpose=="GoToSearchPerson_ExtraMinutes")
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
                    
                    self.indicator.stopAnimating()
                    
                    
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
                    
                    self.indicator.stopAnimating()
                    
                    
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
        
        
        if (segue.identifier! == "GoToCalendar") {
            
            
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
            
            if(self.Purpose == "GoToSearchPerson_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "TimeStamps_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Delete"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "GoToSearchPerson_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "TimeStamps_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Delete"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "TimeStamps_Search")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Search"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                }
            }
            
            if(self.Purpose == "TimeStamps_Missing")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "TimeStamps_Missing"
                    vc.selectCalendarPurpose = .TimeStamps
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            //Do I need this?
            if(self.Purpose == "RegisteredHours_Edit")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Edit"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "RegisteredHours_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_ExtraMinutes"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "RegisteredHours_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Delete"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "RegisteredHours_ExtraMinutes")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "RegisteredHours_Delete")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Delete"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "RegisteredHours_Search")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Search"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }
            
            if(self.Purpose == "RegisteredHours_Missing")
            {
                if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                    
                    vc.childId = self.SelectedPersonId as String
                    vc.childName = self.SelectedPersonFullName as String
                    vc.Purpose = "RegisteredHours_Missing"
                    vc.selectCalendarPurpose = .RegistrationHours
                    
                    vc.showNavigationBar = true
                    
                }
            }

            
            
            
            
            
            
            
            
            
            
            
        }
        
       
        
    }
}
