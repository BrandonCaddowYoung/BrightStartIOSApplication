//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class CreatingInvoices: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Creating new invoices."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
            <<< LabelRow("Target"){
                $0.title = "This feature allows your to create invoices for multplie children."
                $0.cell.textLabel?.numberOfLines = 5
        }
        
        form +++ Section("How does it work?")
            <<< LabelRow("test"){
                $0.title = "To get started, smimply select the appropriate dates. Next select your children before clicking the button at the bottom of the page."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Registered Hours Date Range")
           
            <<< DateRow("RegisterdHourStart"){
                $0.title = "Start"
                $0.value = Calendar.current.date(byAdding: .month, value: 1, to: Date())?.startOfMonth()
                
            }
            
            <<< DateRow("RegisteredHoursEnd"){
                $0.title = "End"
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
                $0.title = "Start"
                $0.value = Date().startOfMonth()
                
            }
            
            <<< DateRow("ExtraHoursEnd"){
                $0.title = "End"
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
                
                self.form +++
                    SelectableSection<ListCheckRow<BrightStartChild>>("CHILDREN", selectionType: .multipleSelection){ section in
                        section.header = HeaderFooterView(title: "CHILDREN")
                        section.tag = "branch_section"
                }
                
                for option in self.childrenArray {
                    self.form.last! <<< ListCheckRow<BrightStartChild>(){ listRow in
                        listRow.title = option.ChildFullName as String
                        listRow.selectableValue = option
                        listRow.value = nil
                    }
                }
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Create Invoices"
                        }.onCellSelection {  cell, row in
                            
                            let branch_section = self.form.sectionBy(tag: "branch_section") as? SelectableSection<ListCheckRow<BrightStartChild>>
                            
                            let ids = self._CommonHelper.GetIdsFromList(selection: branch_section!)
                            
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
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
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
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: String(childrenList.count) + " more to go!")
                    
                    //Do the next
                    self.PerformCreatingInvoicesRecursively(targetChildren: childrenList, registeredHoursStartDate: registeredHoursStartDate, registeredHoursEndDate: registeredHoursEndDate,  extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate, nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: dueDate, onCompletion: onCompletion)
                })
        })
    }
    
    
}

