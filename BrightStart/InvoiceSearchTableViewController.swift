//
//  TimeStampSearchTableViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class InvoiceSearchTableViewController:  UITableViewController, UITextFieldDelegate {
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator()
    {
        indicator = UIActivityIndicatorView(frame: CGRect())
    }
    
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
        
        self.indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight =  500
        
        _CommonHelper = CommonHelper()
        _ApplicatoinColours = ApplicatoinColours()
        
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
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    func NavBarMenuTapped(){
        
    }
    
    
    
    @IBAction func refreshTable(_ sender: UIRefreshControl?) {
        
        self.invoices.removeAll();
        
        InvoiceRequests.sharedInstance.GetAllInvoicesBelongingToChild(childId: TargetPersonId as String, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let invoice = Invoice()
                
                invoice.InvoiceId = Int(Float(JSON["InvoiceNumber"].stringValue)!)
                //invoice.Balance = Float(JSON["Invoice_Balance"].stringValue)!
                invoice.LateMinutes = Float(JSON["Late_Time_Minutes"].stringValue)!
                invoice.EarlyMinutes = Float(JSON["Early_Time_Minutes"].stringValue)!
                invoice.NonRegisteredMinutes = Float(JSON["NonRegistered_Time_Minutes"].stringValue)!
                invoice.RegisteredMinutes = Float(JSON["Registered_Time_Minutes"].stringValue)!
                
                invoice.Total = Float(JSON["InvoiceTotal"].stringValue)!
                invoice.ChildId = Int(Float(JSON["ChildId"].stringValue)!)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let startStamp = JSON["Start_Date"].stringValue
                var newStart = dateFormatter.date(from: startStamp)
                if(newStart == nil){
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    newStart = dateFormatter.date(from: startStamp)
                    if(newStart == nil){
                    //continue
                    }
                }
                
                let endStamp = JSON["End_Date"].stringValue
                var newEnd = dateFormatter.date(from: endStamp)
                if(newEnd == nil){
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    newEnd = dateFormatter.date(from: endStamp)
                    if(newEnd == nil){
                        //continue
                    }
                }
                
                invoice.Start = newStart!
                invoice.End = newEnd!
                
                self.invoices.insert([invoice], at: 0)
                
                self.tableView.reloadData()
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.invoices = self.invoices.reversed()
                
                self.tableView.reloadData()
                sender?.endRefreshing()
                
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
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
            
            //self.performSegue(withIdentifier: "GoToTimeStampsEditor", sender: nil)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Invoice", for: indexPath) as! InvoiceSearchTableViewCell
            cell.invoice = invoices[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedInvoice = cell.invoice
            
            let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { action, index in
                
                InvoiceRequests.sharedInstance.DeleteInvoice(invoiceId: (cell.invoice?.InvoiceId)!, onCompletion:
                    {_ in
                        
                        self.refresh()
                }
                )
                
            }
            delete.backgroundColor = .red

            
            let share = UITableViewRowAction(style: .default, title: "\u{2709}\n e-mail") { action, index in

                BillingRequests.sharedInstance.SendInvoice(invoiceId: (cell.invoice?.InvoiceId)!, onCompletion:
                    {_ in
                        
                        //Show success message!
                }
                )
                
                
            }
            share.backgroundColor = _ApplicatoinColours.Blue
            
            
            
            return [delete, share]
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
            
                        
        }
    }
    
}
