
import Foundation
import UIKit

class ClockingTableViewController: UITableViewController, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
            
        }
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
       
        let alert = _CommonHelper.showOverlayMessage("Refreshing...")
        self.present(alert, animated: true, completion: nil)
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Child", for: indexPath) as! ClockingTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
      if children.count > section && children[section].count > row {
            print(children[section][row])
            cell.child = children[section][row];
        }
        
        return cell
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
                
                let alert = self._CommonHelper.showOverlayMessage("Signing in...")
                self.present(alert, animated: true, completion: nil)
                
                CommonRequests.sharedInstance.signIn(personId: (cell.child?.Id)! as String, timeOfSignIn: Date() as NSDate,
                                                     onCompletion: {
                                                        DispatchQueue.main.async(execute: {
                                                            self.refreshTable()
                                                        })
                    }
                )
            }
            signIn.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            var rowTitle2 = "Sign out " + ((cell.child?.Name)! as String)
            
            if(UIDevice.current.userInterfaceIdiom == .phone){
                rowTitle2 = "Sign out"
            }
            
            let signOut = UITableViewRowAction(style: .normal, title: rowTitle2) { action, index in
                
                let alert = self._CommonHelper.showOverlayMessage("Signing out...")
                self.present(alert, animated: true, completion: nil)
                    
                CommonRequests.sharedInstance.signOut(personId: (cell.child?.Id)! as String, timeOfSignOut: Date() as NSDate,
                                                      
                                                      onCompletion: {
                                                        
                                                        DispatchQueue.main.async(execute: {
                                                            self.refreshTable()
                                                        })
                                                        
                })
                
            }
            signOut.backgroundColor = UIColor(red: 253/255, green: 126/255, blue: 143/255, alpha: 1.0)
            
            let cancel = UITableViewRowAction(style: .default,  title:"Cancel previous") { action, index in
                
                let alert = self._CommonHelper.showOverlayMessage("Please wait...")
                self.present(alert, animated: true, completion: nil)
                
                
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



