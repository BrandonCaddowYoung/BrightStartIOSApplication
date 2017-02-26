//
//  PersonSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class AuthyPersonSearchTableViewController:  UITableViewController, UITextFieldDelegate {
    
    
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator()
    {
        indicator = UIActivityIndicatorView(frame: CGRect())
        
    }
    
    var targetDate: Date!
    
    var successSeqgueIdentifier: NSString!
    
    var ShouldUseTapToSelect: Bool! = true
    
    var SelectedPersonFullName: NSString!
    var SelectedPersonId: NSString!
    
    var Purpose: NSString!
    var OptionText: NSString!
    
    var children: [[BrightStartChild]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var showNavigationBar = true
    
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
        
        self.indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        
        tableView.estimatedRowHeight =  tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        OptionText = "Create"
        
        refresh()
        
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.children.removeAll();
        
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
                self.indicator.hidesWhenStopped = true
                
            })
            
        })
        
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
                
                self.performSegue(withIdentifier: self.successSeqgueIdentifier as String, sender: nil)
                
            }
            findTimeStamps.backgroundColor = _ApplicatoinColours.TableBackGroundOptionColour
           
            return [findTimeStamps]
            
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if(ShouldUseTapToSelect==true){
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrightStartChild", for: indexPath as IndexPath) as! PersonSearchTableViewCell
        cell.child = children[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
        
        self.SelectedPersonId = ((cell.child?.ChildId)! as String as String as NSString!)
        
        self.SelectedPersonFullName = ((cell.child?.ChildFullName)! as String as String as NSString!)
        
        self.performSegue(withIdentifier: self.successSeqgueIdentifier as String, sender: nil)
            
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
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        
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
        
        if (segue.identifier! == "GoToNewAuthyUser") {
            
            //Settings the menu details.
            
            
            if let vc = segue.destination as? NewAuhtyViewController {
                
                vc.selectedChildId = self.SelectedPersonId
                
            }
        }
        
        if (segue.identifier! == "GoToTestAuthyUser") {
            
            //Settings the menu details.
            
            //Need to get the specific user. so navigate to menu.
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .AuthyUsers
                vc.childId = SelectedPersonId
                vc.authyUsersOnly = true
                vc.showNavigationBar = true
            }
        }
        
    }
}
