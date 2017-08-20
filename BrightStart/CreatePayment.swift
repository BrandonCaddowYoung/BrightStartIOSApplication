//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class CreatePayment: FormViewController {
    
    var staffArray = Array<BrightStartChild>()
    var payMentMethodArray = Array<String>()
    var voucherArray = Array<String>()
    var invoiceArray = Array<Invoice>()
    
    var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        payMentMethodArray.append("Cheque")
        payMentMethodArray.append("Cash")
        payMentMethodArray.append("Voucher")
        payMentMethodArray.append("Bank Transfer")
        payMentMethodArray.append("Other")
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .light)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Adding a payment to Bright Start."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
//            <<< LabelRow(){
//                $0.title = "This feature allows you to add a payment to Bright Start."
//                $0.cell.textLabel?.numberOfLines = 5
//        }
//        
//        form +++ Section("How does it work?")
//            <<< LabelRow(){
//                $0.title = "Simply complete the form below before submitting the payment using the button found at the bottom of the page."
//                $0.cell.textLabel?.numberOfLines = 6
//        }
//       
        VoucherRequests.sharedInstance.GetAllVouchersForComboBox(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                print(JSON["PersonName"].stringValue)
                
                self.voucherArray.append(JSON["PersonName"].stringValue)
            }
            
            DispatchQueue.main.async(execute: {
                ////Do nothing.
            })
            
        })
        
        ChildRequests.sharedInstance.GetAllEnrolledChilren(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let child = BrightStartChild()
                
                child.AccountId = JSON["AccountId"].stringValue as NSString
                
                child.ChildFirstName = JSON["ChildFirstName"].stringValue as NSString
                child.ChildLastName = JSON["ChildLastName"].stringValue as NSString
                
                child.ChildFullName = JSON["ChildFullName"].stringValue as NSString
                
                
                child.ChildId = JSON["ChildId"].stringValue as NSString
                
                let dateFormatter = DateFormatter()
                //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let dateOfBirth = JSON["ChildDOB"].stringValue
                
                var newDate = dateFormatter.date(from: dateOfBirth)
                
                if(newDate == nil){
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    newDate = dateFormatter.date(from: dateOfBirth)
                    
                    if(newDate == nil){
                        continue
                    }
                }
                
                child.ChildDOB = newDate!
                
                self.childrenArray.append(child)
            }
            
            DispatchQueue.main.async(execute: {
                
                self.form +++ Section("Payment")
                    
                    <<< PickerInlineRow<BrightStartChild>("PickerChild") {
                        $0.title = "Child"
                        $0.options = self.childrenArray
                        $0.add(rule: RuleRequired())
                        $0.displayValueFor = {
                            guard let pv = $0 else{
                                return nil
                            }
                            return "\(pv.ChildFullName)"
                        }
                        
                        }
                        
                        .cellUpdate { cell, row in
                            if !row.isValid {
                                cell.textLabel?.textColor = .red
                            }
                        }
                        
                        .onChange{
                            
                            //Clearing the invoice array.
                            self.invoiceArray = Array<Invoice>()
                            
                            InvoiceRequests.sharedInstance.GetAllInvoicesBelongingToChild(childId: $0.value?.ChildId as! String, onCompletion: { json in
                                
                                for (index: _, subJson: JSON) in json {
                                    
                                    let invoice = Invoice()
                                    
                                    //invoice.ChildId = Int(JSON["ChildId"].stringValue)!
                                    invoice.ChildId = Int(Double(JSON["ChildId"].stringValue)!)
                                    invoice.Early_Time_Minutes = Double(JSON["Early_Time_Minutes"].stringValue)!
                                    
                                    invoice.EnforceFullTime = Bool(JSON["EnforceFullTime"].stringValue)!
                                    invoice.EnforcePartTime = Bool(JSON["EnforcePartTime"].stringValue)!
                                    
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
                                    
                                    self.invoiceArray.append(invoice)
                                    
                                }
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    if let r = self.form.rowBy(tag: "PickInvoice") as? PickerInlineRow<Invoice> {
                                        
                                        self.invoiceArray.sort(){$0.IssueDate < $1.IssueDate}
                                        
                                        r.options = self.invoiceArray
                                        r.updateCell()
                                    }
                                        
                                    })
                                })
                            }
                    
                    <<< PickerInlineRow<Invoice>("PickInvoice") {
                        $0.title = "Invoice"
                        $0.options = self.invoiceArray
                        $0.add(rule: RuleRequired())
                        $0.displayValueFor = {
                            guard let pv = $0 else{
                                return nil
                            }
                            return "#"  + "\(pv.InvoiceNumber)" + " - " + "Total: " + String(pv.InvoiceTotal)
                        }
                    }
                        .cellUpdate { cell, row in
                            if !row.isValid {
                                cell.textLabel?.textColor = .red
                            }
                    }
                
                    <<< PickerInlineRow<String>("PickPaymentMethod") {
                        $0.title = "Payment method"
                        $0.options = self.payMentMethodArray
                        $0.add(rule: RuleRequired())
                        $0.displayValueFor = {
                            guard let pv = $0 else{
                                return nil
                            }
                            return "\(pv)"
                        }
                        
                        }
                        
                        .cellUpdate { cell, row in
                            if !row.isValid {
                                cell.textLabel?.textColor = .red
                            }
                        }
                        
                        .onChange { row in
                            
                            //let comments = self.form.rowBy(tag: "Comment")
                             let voucherPicker = self.form.rowBy(tag: "PickVoucher")
                            
                            if row.value == "Voucher" {
                                voucherPicker?.hidden = false
                                //comments?.baseCell.textLabel?.text = "Using Voucher"
                            } else {
                                voucherPicker?.hidden = true
                               // comments?.baseCell.textLabel?.text = ""
                            }
                            
                            voucherPicker?.evaluateHidden()
                    }
                
                    <<< PickerInlineRow<String>("PickVoucher") {
                        $0.hidden = true
                        $0.title = "Voucher type"
                        $0.options = self.voucherArray
                        
                        $0.displayValueFor = {
                            guard let pv = $0 else{
                                return nil
                            }
                            return "\(pv)"
                        }
                }       .onChange { row in
                            
                            let comments = self.form.rowBy(tag: "Comment")
                            //let voucherPicker = self.form.rowBy(tag: "PickVoucher")
                            
                           comments?.baseCell.textLabel?.text = "Using Voucher"
                           comments?.baseCell.detailTextLabel?.text = "Using Voucher"
                    }
                    
                    <<< DecimalRow("Amount") {
                        $0.title = "Amount"
                        $0.placeholder = "enter the transaction amount."
                        $0.value = Double(0.0)
                        
                        $0.useFormatterDuringInput = true
                        let formatter = CurrencyFormatter()
                        formatter.locale = .current
                        formatter.numberStyle = .currency
                        $0.formatter = formatter
                    }
                
                    <<< TextRow("Comment") {
                        $0.title = "Comment"
                        $0.placeholder = "Enter any comments here."
                    }
                    
                    <<< DateRow("FundsRecevied"){
                        $0.title = "date funds received"
                        $0.value = Date(timeIntervalSinceReferenceDate: 0)
                }
                
                self.form +++ Section()
                    <<< ButtonRow(){
                        $0.title = "Make Payment"
                        }.onCellSelection {  cell, row in
                            
                            let dateRow: DateRow? = self.form.rowBy(tag: "FundsRecevied")
                            let dateFundsRecevied = dateRow?.value
                            
                            let textRow: TextRow? = self.form.rowBy(tag: "Comment")
                            let comments = textRow?.value ?? ""
                            
                            let decimalRow: DecimalRow? = self.form.rowBy(tag: "Amount")
                            let amount = decimalRow?.value ?? 0.00
                            //let voucher: PickerInlineRow<String>? = self.form.rowBy(tag: "PickVoucher")
                            
                            let paymentMethod: PickerInlineRow<String>? = self.form.rowBy(tag: "PickPaymentMethod")
                            
                            let invoice: PickerInlineRow<Invoice>? = self.form.rowBy(tag: "PickInvoice")
                            let invoiceNumber = invoice?.value?.InvoiceNumber.stringValue
                            
                            let child: PickerInlineRow<BrightStartChild>? = self.form.rowBy(tag: "PickerChild")
                            let accountId = child?.value?.AccountId as! String
                            

                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                            
                            let dateFundsRecevied2 = dateFormatter.string(from: dateFundsRecevied! as Date)
                            
                            if  row.section?.form?.validate().count != 0 {
                                
                            }
                            else {
                                
                                SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                                SVProgressHUD.show()
                                
                                FinancialTransactionRequests.sharedInstance.CreateFinancialTransaction(accountId: accountId, invoiceNumber: invoiceNumber!, transactionDate: dateFundsRecevied2, transactionAmount: String(describing: amount), transactionType: (paymentMethod?.value)!, transactionComment: comments, datePaymentHitAccount: dateFundsRecevied2, onCompletion:
                                    { json in
                                        
                                        DispatchQueue.main.async(execute: {
                                            
                                            SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                            } )
                                            
                                        })
                                })
                            }
                        }.cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 70 }
                }
            })
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Children
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        SetNavigationBarDetails()
        
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
        
        self.navigationItem.title = "Create"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    
//    func CreateChild(mothersEmail: String, fathersEmail: String, mothersName: String, fathersName: String,
//                     childFirstName: String, childMiddleName: String, childLastName: String, dob: Date)
//    {
//        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
//        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
//        SVProgressHUD.show()
//        
//        AccountRequests.sharedInstance.CreateAccount(mothersEmail: mothersEmail, fathersEmail: fathersEmail, mothersName: mothersName, fathersName: fathersName, houseNumber: houseNumber,
//                                                     road: road,
//                                                     town: town,county: county,
//                                                     postCode: postCode,
//                                                     homePhoneNumber: homePhoneNumber,
//                                                     motherWorkPhoneNumber: motherWorkPhoneNumber,
//                                                     fatherWorkPhoneNumber: fatherWorkPhoneNumber,
//                                                     payPalEmailAddress: fatherWorkPhoneNumber,
//                                                     motherMobile: motherMobile,
//                                                     fatherMobile: fatherMobile,
//                                                     motherOccupation: motherOccupation,
//                                                     fatherOccupation: fatherOccupation,
//                                                     existingAccountBalance: "",
//                                                     accountDetails: accountDetails,
//                                                     dateOpened: "",
//                                                     
//                                                     onCompletion:
//            { json in
//                
//                let accountId = (json["AccountId"].stringValue as NSString) as String
//                
//                DispatchQueue.main.async(execute: {
    
//                    ChildHelperRequests.sharedInstance.CreateChild(childFirstName: childFirstName, childMiddleName: childMiddleName, childLastName: childLastName, dob: dob as NSDate, accountId:accountId, medicalConditions: medicalConditions, gPsDetails: gPsDetails, emergencyName: emergencyName, emergencyRelation: emergencyRelation, emergencyHomeNumber: emergencyHomeNumber, emergencyMobileNumber: emergencyMobileNumber, emergencyWorkNumber: emergencyWorkNumber, keyWorkerId: chosenStaffMemberId as String?, everNoteAccessToken: "", otherNotes: otherNotes,onCompletion:
//                        { json in
//                            
//                            DispatchQueue.main.async(execute: {
//                                
//                                SVProgressHUD.dismiss(withDelay: 1, completion: {
//                                    self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
//                                })
//                                
//                            })
//                    })
//                })
//        })
//    }
    
}




