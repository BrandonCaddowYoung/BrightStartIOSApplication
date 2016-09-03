//
//  StandardTableViewController.swift
//  TableViewProject
//
//  Created by dev on 10/03/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import Foundation
import UIKit

class StandardTableViewController: UITableViewController, UITextFieldDelegate {
    
    var tweets: [[Child]] = [];
    
    var searchText: String? = ""{
        didSet
        {
            searchTextField?.text = searchText
            
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
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
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight =  tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refresh()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    @IBAction func refreshTable(sender: UIRefreshControl?) {
        
        self.showOverlayMessage("Refreshing...")
        
        self.tweets.removeAll();
        
        if searchText != nil{
            
            RestApiManager.sharedInstance.getPeople { json in
                
                for (index: _, subJson: JSON) in json {
                    
                    let name = JSON["Name"].stringValue
                    
                    if(self.searchText! != ""){
                        if(!name.containsString(self.searchText!))
                        {
                            continue
                        }
                    }
                    
                    let currentlySignedIn = NSString(string:JSON["CurrentlySignedIn"].stringValue).boolValue
                    
                    let id = JSON["Id"].stringValue
                    
                    if id.isEmpty{
                    continue
                    }
                    
                    //Get last login time, and last logout time.
                    
                    let startTime = JSON["StartTime"].stringValue;
                    let finishTime = JSON["FinishTime"].stringValue;
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    let start = dateFormatter.dateFromString(startTime)
                    
                    let end = dateFormatter.dateFromString(finishTime)
                    
                    let child = Child(name: name, id: id,  currentlySignedIn: currentlySignedIn,startTime: start!, endTime: end!);
                    
                    self.tweets.insert([child], atIndex: 0)
                    
                    self.tableView.reloadData()
                    
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    
                    self.tweets = self.tweets.reverse()
                    
                    self.tableView.reloadData()
                    sender?.endRefreshing()
                    
                     self.dismissViewControllerAnimated(false, completion: nil)
                    
                })
                
            }
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField
        {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        
        return true
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].count
    }
    
    //Make sure the word tweet is linked up using the storboard, go to the view and clikc on the cell then set the identifier to tweet.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Tweet", forIndexPath: indexPath) as! CustomTableViewCell
        
        //print(tweets)
        
        let section = indexPath.section;
        let row = indexPath.row;
        
      if tweets.count > section && tweets[section].count > row {
            print(tweets[section][row])
            cell.tweet = tweets[section][row];
        }
        
        return cell
    }
    
    func showOverlayMessage(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Tweet", forIndexPath: indexPath) as! CustomTableViewCell
            cell.tweet = tweets[indexPath.section][indexPath.row];
            
            let signIn = UITableViewRowAction(style: .Normal, title: "Sign in " + ((cell.tweet?.Name)! as String)) { action, index in
                
                self.showOverlayMessage("Signing in...")
                
                RestApiManager.sharedInstance.signIn((cell.tweet?.Id)! as String, timeOfSignIn: NSDate(),
                                                     onCompletion: {
                                                        dispatch_async(dispatch_get_main_queue(),{
                                                            self.searchText = ""
                                                        })
                    }
                )
            }
            signIn.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let signOut = UITableViewRowAction(style: .Normal, title: "Sign out " + ((cell.tweet?.Name)! as String)) { action, index in
                
                self.showOverlayMessage("Signing out...")
                
                RestApiManager.sharedInstance.signOut((cell.tweet?.Id)! as String, timeOfSignOut: NSDate(),
                                                      
                                                      onCompletion: {
                                                        
                                                        dispatch_async(dispatch_get_main_queue(),{
                                                            self.searchText = ""
                                                        })
                                                        
                })
                
            }
            signOut.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let cancel = UITableViewRowAction(style: .Destructive, title: "Cancel previous") { action, index in
                
                self.showOverlayMessage("Please wait...")
                
            }
            cancel.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            if(cell.tweet?.CurrentlySignedIn == true){
                return [signOut]
            }
            else
            {
                return [signIn]
            }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override f , commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}



