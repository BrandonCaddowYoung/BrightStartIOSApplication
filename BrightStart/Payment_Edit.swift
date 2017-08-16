//
//  Payment_Edit.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Payment_Edit: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var minutes = [String]()
    var hours = [String]()
    
    var targetChildName = String()
    var targetPaymentId = String()
    var targetPayment = FinancialTransaction()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for i in 0...60{
            minutes.append("\(i)")
        }
        
        for i in 0...1000{
            hours.append("\(i)")
        }
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .light)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Rates"
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
        }
        
        self.form +++ Section("General")
            
            <<< LabelRow("ChildName") {
                $0.title = "Child Name"
                $0.value = String(targetChildName)
            }
            
            <<< LabelRow("TransactionId") {
                $0.title = "Transaction Id"
                $0.value = targetPayment.TransactionId
            }
            
            //EDITBALE ///////////
            
            
            <<< TextRow("TransactionType") {
                $0.title = "Transaction Type"
                $0.value = targetPayment.TransactionType
            }
            
            <<< TextRow("TransactionComment") {
                $0.title = "Comment"
                $0.value = targetPayment.TransactionComment
            }
            
            <<< DecimalRow("Amount") {
                $0.title = "Amount"
                $0.placeholder = "enter the transaction amount."
                $0.value = targetPayment.TransactionAmount
                
                $0.useFormatterDuringInput = true
                let formatter = CurrencyFormatter()
                formatter.locale = .current
                formatter.numberStyle = .currency
                $0.formatter = formatter
            }
            
            <<< DateInlineRow("DateFundsReceived") {
                $0.title = "Date Funds Received"
                $0.value = self.targetPayment.DatePaymentHitAccount
            }
            
            //NO LONGER ENDITBLE ///////////
            
            <<< LabelRow("InvoiceNumber") {
                $0.title = "invoice number"
                $0.value = targetPayment.InvoiceNumber
            }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Save changes"
                }.onCellSelection {  cell, row in
                    
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    var textRow: TextRow? = self.form.rowBy(tag: "TransactionType")
                    var labelRow: LabelRow? = self.form.rowBy(tag: "TransactionId")
                    var decimalRow: DecimalRow? = self.form.rowBy(tag: "TransactionId")
                    var dateInlineRow: DateInlineRow? = self.form.rowBy(tag: "DateFundsReceived")
                    
                    textRow = self.form.rowBy(tag: "TransactionType")
                    let transactionType = textRow?.value
                    
                    textRow = self.form.rowBy(tag: "TransactionComment")
                    let transactionComment = textRow?.value
                    
                    decimalRow = self.form.rowBy(tag: "Amount")
                    let amount = decimalRow?.value

                    dateInlineRow = self.form.rowBy(tag: "DateFundsReceived")
                    let dateFundsReceived = dateInlineRow?.value
                    
                    let TransactionType = transactionType
                    let TransactionComment = transactionComment
                   
                    let DateFundsReceived = dateFundsReceived?.ToURLString2()
                    
                    FinancialTransactionRequests.sharedInstance.UpdatePayment(
                        transactionId: self.targetPayment.TransactionId,
                        accountId: self.targetPayment.AccountId,
                        invoiceNumber: self.targetPayment.InvoiceNumber,
                        transactionDate: self.targetPayment.TransactionDate.ToURLString2(),
                        transactionAmount: amount?.toString(),
                        transactionType: TransactionType,
                        transactionComment: TransactionComment,
                        datePaymentHitAccount: DateFundsReceived,
                        onCompletion:
                        { json in
                            
                            DispatchQueue.main.async(execute: {
                                
                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                    self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
                                })
                                
                            })
                    })
                    
                    
                }.cellUpdate
                {
                    cell, row in
                    cell.backgroundColor = StyleManager.theme1()
                    cell.textLabel?.textColor = StyleManager.theme2()
                    cell.height = { 70 }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        SetNavigationBarDetails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMainMenu") {
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Billing
            }
        }
    }
    
    func SetNavigationBarDetails()
    {
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.theme4()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
        self.navigationItem.title = "Edit Payment"
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
}
