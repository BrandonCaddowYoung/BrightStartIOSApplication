//
//  TimeStampSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SVProgressHUD

class TimeStampSearchTableViewController:  UITableViewController, UITextFieldDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
   
    var SelectedPersonLog: PersonLog!
    
     var ShouldUseTapToSelect: Bool! = true
    
    var TargetDate: Date!
    var TargetPersonId: NSString!
    var SelectedPersonFullName: NSString!
    
    var OptionText: NSString!
    
    var timeStamps: [[PersonLog]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var showNavigationBar: Bool! = true
    
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

        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
         self.tableView.tableFooterView = UIView()
        
        // A little trick for removing the cell separators
        self.tableView.tableFooterView = UIView()
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        tableView.estimatedRowHeight =  tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        view.backgroundColor = _ApplicatoinColours.TableBackGround
        
        refresh()

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
            navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
            
            //Back color
            navigationController?.navigationBar.tintColor = _ApplicatoinColours.NavigationBarBackBackButtonColor //Orange
            
            //Back ground color
            navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor // Grey
            
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            
            self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black
            
            navigationController?.navigationBar.topItem?.title = ""
            navigationController?.navigationBar.backItem?.title = ""
            
            
            
            
            self.navigationItem.title="Time Stamp Search"
            
            
          
            
            
            
            
            
            
            
            
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    func NavBarMenuTapped(){
        
    }

    
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.timeStamps.removeAll();
        
        PersonLogRequests.sharedInstance.GetLogByDateAndId(personId: TargetPersonId as String, targetDate: TargetDate as NSDate, onCompletion: { json in
            
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
                
                SVProgressHUD.dismiss(withDelay: 0, completion: {
                    
                })
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(ShouldUseTapToSelect==true){
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeStamp", for: indexPath) as! TimeStampSearchTableViewCell
            cell.log = timeStamps[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedPersonLog = cell.log
            
            self.performSegue(withIdentifier: "GoToTimeStampsEditor", sender: nil)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeStamp", for: indexPath) as! TimeStampSearchTableViewCell
            cell.log = timeStamps[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedPersonLog = cell.log
           
            let delete = UITableViewRowAction(style: .normal, title: "Remove") { (action, indexPath) in
                
                PersonLogRequests.sharedInstance.DeletePersonLog(logId: cell.log?.Id as! String, onCompletion:
                    {_ in
                        
                        self.refresh()
                        
                }
                )
                
            }
            delete.backgroundColor = _ApplicatoinColours.Grey
            
            let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
                self.performSegue(withIdentifier: "GoToTimeStampsEditor", sender: nil)
            }
            share.backgroundColor = _ApplicatoinColours.Orange
            
            return [delete, share]
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToTimeStampsEditor") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? TimeStampsEditorViewController {
                
                if(SelectedPersonLog.Action == "Login")
                {
                    vc.editType = .Start
                }
                else if(SelectedPersonLog.Action == "Logout")
                {
                    vc.editType = .Start
                }
                
                vc.EditorMode = .TimeStamps_Edit
                
                let dateFormatter = DateFormatter()
                
                //Need to make API call to get name here! For now its just the id that is going to go through!
                  vc.Name = ""
                
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
