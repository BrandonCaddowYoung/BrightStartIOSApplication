//
//  TimeStampSearchTableViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 27/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class PersonSearchTableViewController:  UITableViewController, UITextFieldDelegate {
    
    //var TargetDate: Date!
    //var TargetPersonId: NSString!
    
    var SelectedPersonId: NSString!
    var OptionText: NSString!
    
    var children: [[Child]] = [];
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
        
        tableView.estimatedRowHeight =  tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        refresh()
        
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.children.removeAll();
        
        CommonRequests.sharedInstance.getPeople { json in
            
            for (index: _, subJson: JSON) in json {
                
                let name = JSON["Name"].stringValue
                
                let currentlySignedIn = NSString(string:JSON["CurrentlySignedIn"].stringValue).boolValue
                
                let id = JSON["Id"].stringValue
                
                if id.isEmpty{
                    continue
                }
                
                //Get last login time, and last logout time.
                
                let startTime = JSON["StartTime"].stringValue;
                let finishTime = JSON["FinishTime"].stringValue;
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                let start = dateFormatter.date(from: startTime)
                
                let end = dateFormatter.date(from: finishTime)
                
                let child = Child(name: name as NSString, id: id as NSString,  currentlySignedIn: currentlySignedIn,startTime: start!, endTime: end!);
                
                self.children.insert([child], at: 0)
                
                self.tableView.reloadData()
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.children = self.children.reversed()
                
                self.tableView.reloadData()
                sender?.endRefreshing()
                
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Child", for: indexPath) as! PersonSearchTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
        if children.count > section && children[section].count > row {
            cell.child = children[section][row];
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Child", for: indexPath) as! PersonSearchTableViewCell
            cell.child = children[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            let rowTitle = OptionText
            
            let findTimeStamps = UITableViewRowAction(style: .normal, title: rowTitle as String?) { action, index in
                
                self.SelectedPersonId = ((cell.child?.Id)! as String as String as NSString!)
                
                self.performSegue(withIdentifier: "GoToTimeStampSearch", sender: nil)
                
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
                
                    vc.TargetDate = Date()
                    vc.TargetPersonId = self.SelectedPersonId
                    
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
        
    }
}
