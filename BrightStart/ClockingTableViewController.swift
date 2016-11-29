//
//  StandardTableViewController.swift
//  TableViewProject
//
//  Created by dev on 10/03/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import Foundation
import UIKit

class ClockingTableViewController: UITableViewController, UITextFieldDelegate {
    
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
    
    
    func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.showOverlayMessage("Refreshing...")
        
        self.tweets.removeAll();
        
        if searchText != nil{
            
            CommonRequests.sharedInstance.getPeople { json in
                
                for (index: _, subJson: JSON) in json {
                    
                    let name = JSON["Name"].stringValue
                    
                    if(self.searchText! != ""){
                        if(!name.contains(self.searchText!))
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
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    let start = dateFormatter.date(from: startTime)
                    
                    let end = dateFormatter.date(from: finishTime)
                    
                    let child = Child(name: name as NSString, id: id as NSString,  currentlySignedIn: currentlySignedIn,startTime: start!, endTime: end!);
                    
                    self.tweets.insert([child], at: 0)
                    
                    self.tableView.reloadData()
                    
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.tweets = self.tweets.reversed()
                    
                    self.tableView.reloadData()
                    sender?.endRefreshing()
                    
                     self.dismiss(animated: false, completion: nil)
                    
                })
                
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField
        {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        
        return true
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].count
    }
    
    //Make sure the word tweet is linked up using the storboard, go to the view and clikc on the cell then set the identifier to tweet.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath) as! ClockingTableViewCell
        
        //print(tweets)
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
      if tweets.count > section && tweets[section].count > row {
            print(tweets[section][row])
            cell.tweet = tweets[section][row];
        }
        
        return cell
    }
    
    func showOverlayMessage(_ message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath) as! ClockingTableViewCell
            cell.tweet = tweets[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            let signIn = UITableViewRowAction(style: .normal, title: "Sign in " + ((cell.tweet?.Name)! as String)) { action, index in
                
                self.showOverlayMessage("Signing in...")
                
                CommonRequests.sharedInstance.signIn(personId: (cell.tweet?.Id)! as String, timeOfSignIn: Date() as NSDate,
                                                     onCompletion: {
                                                        DispatchQueue.main.async(execute: {
                                                            self.searchText = ""
                                                        })
                    }
                )
            }
            signIn.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let signOut = UITableViewRowAction(style: .normal, title: "Sign out " + ((cell.tweet?.Name)! as String)) { action, index in
                
                self.showOverlayMessage("Signing out...")
                
                CommonRequests.sharedInstance.signOut(personId: (cell.tweet?.Id)! as String, timeOfSignOut: Date() as NSDate,
                                                      
                                                      onCompletion: {
                                                        
                                                        DispatchQueue.main.async(execute: {
                                                            self.searchText = ""
                                                        })
                                                        
                })
                
            }
            signOut.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let cancel = UITableViewRowAction(style: .default,  title:"Cancel previous") { action, index in
                
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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



