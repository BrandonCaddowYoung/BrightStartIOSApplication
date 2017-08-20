//
//  TimeStampSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit
import SCLAlertView
import DZNEmptyDataSet
import SVProgressHUD

class InvoiceSearchTableViewController:  UITableViewController, UITextFieldDelegate , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var SelectedInvoice: Invoice!
    
    var ShouldUseTapToSelect: Bool! = false
    
     var targetDate: Date!
    
    var TargetPersonId: NSString!
    var SelectedPersonFullName: NSString!
    
    var OptionText: NSString!
    
    var invoices: [[Invoice]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var showNavigationBar: Bool! = true
    
    func refreshTable()
    {
        invoices.removeAll()
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
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight =  500
        
        view.backgroundColor = StyleManager.TableBackGroundColour()
        
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
    
    func SetNavigationBarDetails()
    {
        self.navigationController?.navigationBar.topItem?.title = " "
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.NavigationBarBackButton()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
        self.navigationItem.title="Invoice Search"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
           SetNavigationBarDetails()
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    func NavBarMenuTapped(){
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

        
        if (segue.identifier == "GoToTimeStampsEditor") {
            
        }
        else if (segue.identifier == "GoToEditInvoice") {
            
            if let vc = segue.destination as? Invoice_Edit {
                vc.targetInvoice = SelectedInvoice
                vc.targetChildName = self.SelectedPersonFullName as String
            }
            
        }
        
        else if (segue.identifier == "GoToMenu") {
            
            
            if let vc = segue.destination as? MainMenuViewController {
                
                vc.selectedMenu = .Billing
                
            }
            
        }
        
    }
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.invoices.removeAll();
        
        InvoiceRequests.sharedInstance.GetAllInvoicesBelongingToChild(childId: TargetPersonId as String, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let invoice = Invoice()
                
//              invoice.ChildId = Int(JSON["ChildId"].stringValue)!
                invoice.ChildId = JSON["ChildId"].intValue
                invoice.Early_Time_Minutes = JSON["Early_Time_Minutes"].doubleValue
              
                invoice.EnforceFullTime = JSON["EnforceFullTime"].boolValue
                invoice.EnforcePartTime = JSON["EnforcePartTime"].boolValue
                
                invoice.IsFullTime = Bool(JSON["IsFullTime"].stringValue)!
                invoice.InvoiceBalance = Double(JSON["InvoiceBalance"].stringValue)!
                
                invoice.ExtraStartDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["ExtraStartDate"].stringValue)
                invoice.ExtraFinishDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["ExtraFinishDate"].stringValue)
                invoice.IssueDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["IssueDate"].stringValue)
                invoice.End_Date = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["End_Date"].stringValue)
                invoice.Start_Date = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["Start_Date"].stringValue)
                
                invoice.NonRegisteredStartDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["NonRegisteredStartDate"].stringValue)
                invoice.NonRegisteredFinishDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["NonRegisteredFinishDate"].stringValue)
                
                invoice.RegisteredFinishDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["RegisteredFinishDate"].stringValue)
                invoice.RegisteredStartDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["RegisteredStartDate"].stringValue)
               
                invoice.NonRegistered_Time_Minutes = Double(JSON["NonRegistered_Time_Minutes"].stringValue)!
                
                invoice.InvoiceNumber = Int(JSON["InvoiceNumber"].stringValue)!
                invoice.InvoiceTotal = Double(JSON["InvoiceTotal"].stringValue)!
                
                invoice.Late_Time_Minutes = Double(JSON["Late_Time_Minutes"].stringValue)!
                invoice.Notes = JSON["Notes"].stringValue
                invoice.NumberOfBusinessDays = Int(Double(JSON["NumberOfBusinessDays"].stringValue)!)
                invoice.NumberOfFullDays = Int(Double(JSON["NumberOfFullDays"].stringValue)!)
                invoice.NumberOfFullHalfDays = Int(JSON["NumberOfFullHalfDays"].stringValue)!
                
                invoice.Registered_Time_Minutes = Double(JSON["Registered_Time_Minutes"].stringValue)!
               
                invoice.ChildId = Int(JSON["ChildId"].stringValue)!
                invoice.InvoiceTotal = Double(JSON["InvoiceTotal"].stringValue)!
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                invoice.Start_Date = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["Start_Date"].stringValue)
                invoice.End_Date = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["End_Date"].stringValue)
                
                invoice.UsingPartTime = Bool(JSON["UsingPartTime"].stringValue)!
                invoice.UsingFullTime = Bool(JSON["UsingFullTime"].stringValue)!
                
                self.invoices.insert([invoice], at: 0)
                
                self.tableView.reloadData()
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.invoices = self.invoices.reversed()
                
                self.tableView.reloadData()
                sender?.endRefreshing()
                
                SVProgressHUD.dismiss(withDelay: 0, completion: {
                    
                })
            })
            
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return invoices.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoices[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Invoice", for: indexPath) as! InvoiceSearchTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
        if invoices.count > section && invoices[section].count > row {
            
            cell.invoice = invoices[section][row];
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(ShouldUseTapToSelect==true){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Invoice", for: indexPath) as! InvoiceSearchTableViewCell
            cell.invoice = invoices[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedInvoice = cell.invoice
            
           
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "Invoice", for: indexPath) as! InvoiceSearchTableViewCell
            cell.invoice = invoices[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedInvoice = cell.invoice
            
            let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { action, index in
                
                SVProgressHUD.show()
                SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                
                InvoiceRequests.sharedInstance.DeleteInvoice(invoiceId: (cell.invoice?.InvoiceNumber)!, onCompletion:
                    {_ in
                        
                       
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            //self._CommonHelper.ShowSuccessMessage(title: "All done.", subsTtitle: "Invoice successfully deleted!")
                        })
                        
                        self.refresh()
                }
                )
                
            }
            delete.backgroundColor = .red
            
            let email = UITableViewRowAction(style: .default, title: "\u{2709}\n e-mail") { action, index in

                SVProgressHUD.show()
                SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                
                BillingRequests.sharedInstance.SendInvoice(invoiceId: (cell.invoice?.InvoiceNumber)!, onCompletion:
                    {_ in
                        
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            self._CommonHelper.ShowSuccessMessage(title: "Success", subsTtitle: "Invoice succesfully sent.")
                        })
                        
                        }
                )
            }
            email.backgroundColor = StyleManager.theme1()
            
            let edit = UITableViewRowAction(style: .default, title: "\u{2710}\n edit") { action, index in
                self.performSegue(withIdentifier: "GoToEditInvoice", sender: nil)
            }
            edit.backgroundColor = StyleManager.theme1()
            
            return [edit, delete, email]

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
}


