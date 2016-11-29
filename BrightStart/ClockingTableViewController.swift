
import Foundation
import UIKit

class ClockingTableViewController: UITableViewController, UITextFieldDelegate {
    
    var children: [[Child]] = [];
    
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
        
        refresh()
        
    }
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
            
        }
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.showOverlayMessage("Refreshing...")
        
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
                    
                     self.dismiss(animated: false, completion: nil)
                    
                })
            }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return children.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children[section].count
    }
    
    //Make sure the word tweet is linked up using the storboard, go to the view and clikc on the cell then set the identifier to tweet.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath) as! ClockingTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
      if children.count > section && children[section].count > row {
            print(children[section][row])
            cell.child = children[section][row];
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
            cell.child = children[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            let signIn = UITableViewRowAction(style: .normal, title: "Sign in " + ((cell.child?.Name)! as String)) { action, index in
                
                self.showOverlayMessage("Signing in...")
                
                CommonRequests.sharedInstance.signIn(personId: (cell.child?.Id)! as String, timeOfSignIn: Date() as NSDate,
                                                     onCompletion: {
                                                        DispatchQueue.main.async(execute: {
                                                            self.refreshTable()
                                                        })
                    }
                )
            }
            signIn.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let signOut = UITableViewRowAction(style: .normal, title: "Sign out " + ((cell.child?.Name)! as String)) { action, index in
                
                self.showOverlayMessage("Signing out...")
                
                CommonRequests.sharedInstance.signOut(personId: (cell.child?.Id)! as String, timeOfSignOut: Date() as NSDate,
                                                      
                                                      onCompletion: {
                                                        
                                                        DispatchQueue.main.async(execute: {
                                                            self.refreshTable()
                                                        })
                                                        
                })
                
            }
            signOut.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let cancel = UITableViewRowAction(style: .default,  title:"Cancel previous") { action, index in
                
                self.showOverlayMessage("Please wait...")
                
            }
            cancel.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
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
    
}



