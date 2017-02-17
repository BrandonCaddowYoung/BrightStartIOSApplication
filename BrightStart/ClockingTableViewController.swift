//
//  ClockingTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import Foundation
import UIKit

class ClockingTableViewController: UITableViewController, UITextFieldDelegate {
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator()
    {
    indicator = UIActivityIndicatorView(frame: CGRect())
        
    }
    
    var children: [[Child]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
     var ShouldUseTapToSelect: Bool! = false
    
    var selectedChildId: NSString!
    var selectedAuthyAction = AuhtyActions.ShouldDoNothing
    
    //var ClockingTableViewController:Bool! = false
    
    var showNavigationBar:Bool! = false
    
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
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(false, animated: animated);
            super.viewWillDisappear(animated)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(!showNavigationBar){
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        refresh()
        
        
        let threeFingerTap = UITapGestureRecognizer(target: self,
                                               action: #selector(ClockingTableViewController.tapDetected as
                                                (ClockingTableViewController) -> () -> ()))
        threeFingerTap.numberOfTapsRequired = 1
        threeFingerTap.numberOfTouchesRequired = 3
        
        self.view.addGestureRecognizer(threeFingerTap)
        
        
    }
    
    func tapDetected() {
        
        //Put system password here!
        
         self.performSegue(withIdentifier: "GoToMainMenu", sender: self)
    }
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
            
        }
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
       
       // let alert = _CommonHelper.showOverlayMessage("Refreshing...")
       // self.present(alert, animated: true, completion: nil)
        
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
                    
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Child", for: indexPath) as! ClockingTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
      if children.count > section && children[section].count > row {
            //print(children[section][row])
            cell.child = children[section][row];
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(ShouldUseTapToSelect==true){
            
             
            
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Child", for: indexPath) as! ClockingTableViewCell
            cell.child = children[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            var rowTitle = "Sign in " + ((cell.child?.Name)! as String)
           
             if(UIDevice.current.userInterfaceIdiom == .phone){
                rowTitle = "Sign in"
            }
            
            let signIn = UITableViewRowAction(style: .normal, title: rowTitle) { action, index in
                
                let defaults = UserDefaults.standard
                let shouldUseAuthy = defaults.bool(forKey: "ShouldUseAuhty")
                let shouldUseAuhtyOnSignIn = defaults.bool(forKey: "ShouldUseAuhtyOnSignIn")
                
                if(shouldUseAuthy==true && shouldUseAuhtyOnSignIn == true)
                {
                    self.selectedChildId = (cell.child?.Id)! as String as String as NSString!
                    
                    self.selectedAuthyAction = AuhtyActions.ShouldSignIn
                    
                    self.performSegue(withIdentifier: "GoToAuthyUsers", sender: self)
                    
                    return
                }
                else
                {
                
                    let alert = self._CommonHelper.showOverlayMessage("Signing in...")
                    self.present(alert, animated: true, completion: nil)
                    
                    CommonRequests.sharedInstance.signIn(personId: (cell.child?.Id)! as String, timeOfSignIn: Date() as NSDate,
                                                         onCompletion: {
                                                            DispatchQueue.main.async(execute: {
                                                                self.refreshTable()
                                                                
                                                                self.dismiss(animated: false, completion: nil)
                                                            })
                    }
                    )
                    
                }
                
            }
            signIn.backgroundColor = _ApplicatoinColours.TableBackGroundOptionColour2
            
            var rowTitle2 = "Sign out " + ((cell.child?.Name)! as String)
            
            if(UIDevice.current.userInterfaceIdiom == .phone){
                rowTitle2 = "Sign out"
            }
            
            let signOut = UITableViewRowAction(style: .normal, title: rowTitle2) { action, index in
                
                let defaults = UserDefaults.standard
                let shouldUseAuthy = defaults.bool(forKey: "ShouldUseAuhty")
                let shouldUseAuhtyOnSignOut = defaults.bool(forKey: "ShouldUseAuhtyOnSignOut")
                
                if(shouldUseAuthy==true && shouldUseAuhtyOnSignOut == true)
                {
                    self.selectedChildId = (cell.child?.Id)! as String as String as NSString!
                    
                    self.selectedAuthyAction = AuhtyActions.ShouldSignOut
                    
                    self.performSegue(withIdentifier: "GoToAuthyUsers", sender: self)
                    
                    return
                    
                }
                else
                {
                    let alert = self._CommonHelper.showOverlayMessage("Signing out...")
                    self.present(alert, animated: true, completion: nil)
                    
                    CommonRequests.sharedInstance.signOut(personId: (cell.child?.Id)! as String, timeOfSignOut: Date() as NSDate,
                                                          
                                                          onCompletion: {
                                                            
                                                            DispatchQueue.main.async(execute: {
                                                                self.refreshTable()
                                                                
                                                                self.dismiss(animated: false, completion: nil)
                                                                
                                                            })
                                                            
                    })
                    
                }
                
                
                
            }
            signOut.backgroundColor = _ApplicatoinColours.TableBackGroundOptionColour
            
            if(cell.child?.CurrentlySignedIn == true){
                return [signOut]
            }
            else
            {
                return [signIn]
            }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier! == "GoToMainMenu") {
            
            //Settings the menu details.
            
            //Need to get the specific user. so navigate to menu.
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .MainMenu
            }
        }
        
    else if (segue.identifier! == "GoToAuthyUsers") {
    
    //Settings the menu details.
    
    //Need to get the specific user. so navigate to menu.
    
    if let vc = segue.destination as? MainMenuViewController {
    
    //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
    
        vc.selectedMenu = .AuthyUsers
        vc.childId = selectedChildId
        vc.authyUsersOnly = true
        vc.selectedAuthyAction = selectedAuthyAction
    }
    }
        
    }
    
    
    
}



