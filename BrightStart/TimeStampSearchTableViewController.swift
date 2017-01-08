//
//  TimeStampSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class TimeStampSearchTableViewController:  UITableViewController, UITextFieldDelegate {

    var SelectedPersonLog: PersonLog!
    
    var TargetDate: Date!
    var TargetPersonId: NSString!
    var SelectedPersonFullName: NSString!
    
    var OptionText: NSString!
    
    var timeStamps: [[PersonLog]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    func refreshTable()
    {
        timeStamps.removeAll()
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
        
        // let alert = _CommonHelper.showOverlayMessage("Refreshing...")
        // self.present(alert, animated: true, completion: nil)
        
        self.timeStamps.removeAll();
        
        PersonLogRequests.sharedInstance.GetLoginLogsByDateAndId(personId: TargetPersonId as String, targetDate: TargetDate as NSDate, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let log = PersonLog()
                
                log.PersonId = JSON["PersonId"].stringValue as NSString
                log.Id = JSON["Id"].stringValue as NSString
                
                log.Action = JSON["Action"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let timeStamp = JSON["TimeStamp"].stringValue
                
                var newDate = dateFormatter.date(from: timeStamp)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: timeStamp)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                log.TimeStamp = newDate!
               
                self.timeStamps.insert([log], at: 0)
                
                self.tableView.reloadData()
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.timeStamps = self.timeStamps.reversed()
                
                self.tableView.reloadData()
                sender?.endRefreshing()
                
                //self.dismiss(animated: false, completion: nil)
                
            })
            
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return timeStamps.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeStamps[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeStamp", for: indexPath) as! TimeStampSearchTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
        if timeStamps.count > section && timeStamps[section].count > row {
            //print(children[section][row])
            cell.log = timeStamps[section][row];
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeStamp", for: indexPath) as! TimeStampSearchTableViewCell
            cell.log = timeStamps[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedPersonLog = cell.log
            
            let rowTitle2 = OptionText
            
            let optionText = UITableViewRowAction(style: .normal, title: rowTitle2 as String?) { action, index in
                
                self.performSegue(withIdentifier: "GoToTimeStampsEditor", sender: nil)
                
                
            }
            optionText.backgroundColor = _ApplicatoinColours.TableBackGroundOptionColour

            
            if(rowTitle2==""){
                return[]
            }
            else{
                return [optionText]
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
        
        if (segue.identifier == "GoToTimeStampsEditor") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? TimeStampsEditorViewController {
                
                let dateFormatter = DateFormatter()
                
                //Need to make API call to get name here! For now its just the id that is going to go through!
                  vc.Name = "Tupac Shakur"
                
                vc.PersonId = SelectedPersonLog.PersonId as String
                
                vc.Name = SelectedPersonFullName as String!;
                
                vc.Action = SelectedPersonLog.Action as String
                
                dateFormatter.dateFormat = "dd/MM/yyyy"
                vc.Date = dateFormatter.string(from: SelectedPersonLog.TimeStamp) as String
                
                dateFormatter.dateFormat = "hh:mm:ss"
                vc.Time = dateFormatter.string(from: SelectedPersonLog.TimeStamp) as String
                
                vc.DateAsObject = SelectedPersonLog.TimeStamp
                    
                
            }
            
        }
    }
    
}
