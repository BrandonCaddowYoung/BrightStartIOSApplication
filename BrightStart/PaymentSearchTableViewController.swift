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

class PaymentSearchTableViewController:  UITableViewController, UITextFieldDelegate , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var SelectedPayment: FinancialTransaction!
    
    var ShouldUseTapToSelect: Bool! = false
    
    var targetDate: Date!
    
    var TargetAccountId: String!
    //var TargetChildId: NSString!
    var SelectedPersonFullName: NSString!
    
    var OptionText: NSString!
    
    var Payments: [[FinancialTransaction]] = [];
    var _CommonHelper: CommonHelper!
    var _ApplicatoinColours: ApplicatoinColours!
    
    var showNavigationBar: Bool! = true
    
    func refreshTable()
    {
        Payments.removeAll()
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
        
        self.navigationItem.title="Payment Search"
        
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
        else if (segue.identifier == "GoToEditPayment") {
            
            if let vc = segue.destination as? Payment_Edit {
                vc.targetPayment = SelectedPayment
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
        
        self.Payments.removeAll();
        
        FinancialTransactionRequests.sharedInstance.GetListOfAllTransactionsBelongingToAccount(accountId: TargetAccountId, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let Payment = FinancialTransaction()
                
                Payment.TransactionComment = JSON["TransactionComment"].stringValue
                
                Payment.TransactionId = JSON["TransactionId"].stringValue
                Payment.AccountId = JSON["AccountId"].stringValue
                
                Payment.InvoiceNumber = JSON["InvoiceNumber"].stringValue
               
                Payment.TransactionAmount = JSON["TransactionAmount"].doubleValue
                
                Payment.TransactionType = JSON["TransactionType"].stringValue
                
                Payment.DatePaymentHitAccount = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["DatePaymentHitAccount"].stringValue)
                
                Payment.TransactionDate = self._CommonHelper.GetDateObjectFromString(dateAsString: JSON["TransactionDate"].stringValue)
                
                self.Payments.insert([Payment], at: 0)
                
                self.tableView.reloadData()
                
            }
            
            DispatchQueue.main.async(execute: {
                
                self.Payments = self.Payments.reversed()
                
                self.tableView.reloadData()
                sender?.endRefreshing()
                
                SVProgressHUD.dismiss(withDelay: 0, completion: {
                    
                })
            })
            
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Payments.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Payments[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Payment", for: indexPath) as! PaymentSearchTableViewCell
        
        let section = (indexPath as NSIndexPath).section;
        let row = (indexPath as NSIndexPath).row;
        
        if Payments.count > section && Payments[section].count > row {
            
            cell.Payment = Payments[section][row];
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(ShouldUseTapToSelect==true){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Payment", for: indexPath) as! PaymentSearchTableViewCell
            cell.Payment = Payments[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedPayment = cell.Payment
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Payment", for: indexPath) as! PaymentSearchTableViewCell
            cell.Payment = Payments[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row];
            
            //Saving the selected log so that when we segue we can call on it!
            SelectedPayment = cell.Payment
            
            let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { action, index in
                
                SVProgressHUD.show()
                SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                
                FinancialTransactionRequests.sharedInstance.DeletePayment(PaymentId: (cell.Payment?.TransactionId)!, onCompletion:
                    {_ in
                        
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            //self._CommonHelper.ShowSuccessMessage(title: "All done.", subsTtitle: "Payment successfully deleted!")
                        })
                        
                        self.refresh()
                }
                )
                
            }
            delete.backgroundColor = .red
            
            let edit = UITableViewRowAction(style: .default, title: "\u{2710}\n edit") { action, index in
                self.performSegue(withIdentifier: "GoToEditPayment", sender: nil)
            }
            edit.backgroundColor = StyleManager.theme1()
            
            return [edit, delete]
            
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


