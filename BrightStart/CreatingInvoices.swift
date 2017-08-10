//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class CreatingInvoices: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .dark)
        
        //UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Creating invoices."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
            <<< LabelRow(){
                $0.title = "This feature allows you to create Invoices for both individual or multplie children."
                $0.cell.textLabel?.numberOfLines = 5
        }
        
        form +++ Section("How does it work?")
            <<< LabelRow(){
                $0.title = "To get going, simply select the appropriate dates using the fields below. Lastly, select your children before tapping the button at the bottom of the page. All created invoices can be found within the 'Billing' menu under the 'View Invoices' menu."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Registered Hours Date Range")
            
            <<< DateRow("RegisterdHourStart"){
                $0.title = "start"
                $0.value = Calendar.current.date(byAdding: .month, value: 1, to: Date())?.startOfMonth()
                
            }
            
            <<< DateRow("RegisteredHoursEnd"){
                $0.title = "end"
                $0.value = Calendar.current.date(byAdding: .month, value: 1, to: Date())?.endOfMonth()
                
        }
        
        form +++ Section("Non Registered Hours Date Range")
            
            <<< DateRow("NonRegisterdHourStart"){
                $0.title = "Start"
                $0.value = Date().startOfMonth()
                
            }
            
            <<< DateRow("NonRegisteredHoursEnd"){
                $0.title = "End"
                $0.value = Date().endOfMonth()
                
        }
        
        form +++ Section("Extra Hours Date Range")
            
            <<< DateRow("ExtraHourStart"){
                $0.title = "start"
                $0.value = Date().startOfMonth()
            }
            
            <<< DateRow("ExtraHoursEnd"){
                $0.title = "end"
                $0.value = Date().endOfMonth()
        }
        
        
        //Retrieve all children
        ChildRequests.sharedInstance.GetAllEnrolledChilren(onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let child = BrightStartChild()
                
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
                
                let fullChildList = Dictionary(keyValuePairs: self.childrenArray.map{($0.ChildId, $0.ChildFullName)})
                
                self.form +++ Section("Selected Children")
                    <<< MultipleSelectorRow<String>("SelectedChildren") { row in
                        row.title = "Children"
                        row.options = self.childrenArray.map { ($0.ChildFullName as String) }
                        
                        }.onPresent { from, to in
                            to.selectableRowCellUpdate = { cell, row in
                                cell.backgroundColor = StyleManager.theme2()
                            }
                }
                
                self.form +++ Section()
                    <<< ButtonRow(){
                        $0.title = "Create Invoices"
                        }.onCellSelection {  cell, row in
                            
                            let mulitpleRow: MultipleSelectorRow<String> = self.form.rowBy(tag: "SelectedChildren")!
                            
                            let ids = self._CommonHelper.GetKeysFromValues(dictionary: fullChildList as Dictionary<String, String>, selectedArray: mulitpleRow.value!)
                            
                            if  ids.count == 0 {
                                
                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                    
                                    self._CommonHelper.ShowErrorMessage(title: "No children selected.", subsTtitle: "In order to continue, atleast one child needs to be selected.");
                                    
                                } )
                            }
                            else {
                                
                            var row: DateRow? = self.form.rowBy(tag: "RegisterdHourStart")
                            let RegisteredHoursStart = row?.value
                            
                            row = self.form.rowBy(tag: "RegisteredHoursEnd")
                            let RegisteredHoursEnd = row?.value
                            
                            row = self.form.rowBy(tag: "NonRegisterdHourStart")
                            let NonRegisteredHoursStart = row?.value
                            
                            row = self.form.rowBy(tag: "NonRegisteredHoursEnd")
                            let NonRegisteredHoursEnd = row?.value
                            
                            row = self.form.rowBy(tag: "ExtraHourStart")
                            let ExtraHoursStart = row?.value
                            
                            row = self.form.rowBy(tag: "ExtraHoursEnd")
                            let ExtraHoursEnd = row?.value
                            
                            self.CreateInvoices(targetChildren: ids, registeredHoursStartDate: RegisteredHoursStart!, registeredHoursEndDate: RegisteredHoursEnd!, extraHoursStartDate: ExtraHoursStart!, extraHoursEndDate: ExtraHoursEnd!, nonRegisteredHoursStartDate: NonRegisteredHoursStart!, nonRegisteredHoursEndDate: NonRegisteredHoursEnd!)
                                
                            }
                            
                        }
                        .cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 70 }
                        }
                
            })
            
        })
        
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
        
        self.navigationItem.title = "Creating Invoices"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Billing
            }
        }
    }
    
    func CreateInvoices(targetChildren: [String], registeredHoursStartDate: Date, registeredHoursEndDate: Date, extraHoursStartDate: Date, extraHoursEndDate: Date,  nonRegisteredHoursStartDate: Date, nonRegisteredHoursEndDate: Date)
    {
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        //First lets remove bank holidays for the date periods.
        
        BillingRequests.sharedInstance.RemoveBankHolidayRegisteredHours(registeredHoursStartDate: registeredHoursStartDate, registeredHoursEndDate: registeredHoursEndDate, extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate, nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Great the registed hours have been removed, Now lets create the invoices.
                    
                    var fifteenDaysfromNow: Date {
                        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 15, to: Date(), options: [])!
                    }
                    
                    self.PerformCreatingInvoicesRecursively(targetChildren: targetChildren, registeredHoursStartDate: registeredHoursStartDate,registeredHoursEndDate: registeredHoursEndDate,extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate,nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: fifteenDaysfromNow, onCompletion: { json in
                        
                        DispatchQueue.main.async(execute: {
                            
                            SVProgressHUD.dismiss(withDelay: 1, completion: {
                                self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                            } )
                            
                        })
                    })
                    
                })
        })
    }
    
    
    func PerformCreatingInvoicesRecursively(targetChildren: [String], registeredHoursStartDate: Date, registeredHoursEndDate: Date, extraHoursStartDate: Date, extraHoursEndDate: Date,  nonRegisteredHoursStartDate: Date, nonRegisteredHoursEndDate: Date, dueDate: Date, onCompletion: @escaping () -> Void)
    {
        
        var childrenList = targetChildren
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        BillingRequests.sharedInstance.CreateInvoices(targetChildren: lastItem as! [String], registeredHoursStartDate: registeredHoursStartDate, registeredHoursEndDate: registeredHoursEndDate, extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate, nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: dueDate, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Remove the guy we just completed
                    childrenList.removeLast()
                    
                    //Check if we are all done!
                    if(childrenList.count == 0)
                    {
                        onCompletion()
                        
                        return
                    }
                    
                    self._CommonHelper.ShowSuccessMessage(title: "Invoice successfully created.", subsTtitle: String(childrenList.count) + " more to go.")
                    
                    //Do the next
                    self.PerformCreatingInvoicesRecursively(targetChildren: childrenList, registeredHoursStartDate: registeredHoursStartDate, registeredHoursEndDate: registeredHoursEndDate,  extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate, nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: dueDate, onCompletion: onCompletion)
                })
        })
    }
    
    
}

extension Dictionary {
    public init(keyValuePairs: [(Key, Value)]) {
        self.init()
        for pair in keyValuePairs {
            self[pair.0] = pair.1
        }
    }
}


