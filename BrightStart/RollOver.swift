//
//  RollOver_Step1.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class RollOver: FormViewController {
    
     var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .dark)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
         let month = calendar.component(.month, from: date)
        
        let monthArray = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Rollinver over registered hours."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
            }
            
            <<< LabelRow("123"){
                $0.title = "This feature allows you to take the registered hours from one month and copy them over to another month."
                $0.cell.textLabel?.numberOfLines = 5
        }
        
       
        
        form +++ Section("How does it work?")
            <<< LabelRow("test"){
                $0.title = "To get started, select target month and your destination month."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Target")
            
            <<< PickerInlineRow<String>("TargetYearPicker") {
                $0.title = "Year"
                $0.options = [String(year-1), String(year), String(year+1)]
                $0.value = String(year)    // initially selected
        }
        
            <<< PickerInlineRow<String>("TargetMonthPicker") {
                $0.title = "Month"
                $0.options = monthArray
                $0.value = monthArray[month-1]    // initially selected
        }
            
            +++ Section("Destination")
            
            <<< PickerInlineRow<String>("DestinationYearPicker") {
                $0.title = "Year"
                $0.options = [String(year-1), String(year), String(year+1)]
                $0.value = String(year)    // initially selected
            }
            
            <<< PickerInlineRow<String>("DestinationMonthPicker") {
                $0.title = "Month"
                $0.options = monthArray
                $0.value = monthArray[month-1]    // initially selected
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
                        row.options = fullChildList.map { ($0.value as String) }
                        
                        }.onPresent { from, to in
                            to.selectableRowCellUpdate = { cell, row in
                                cell.backgroundColor = StyleManager.theme2()
                            }
                }
                
                self.form +++ Section("")
                    <<< ButtonRow(){
                        $0.title = "Perform Roll Over"
                        }.onCellSelection {  cell, row in
                            
                            let mulitpleRow: MultipleSelectorRow<String> = self.form.rowBy(tag: "SelectedChildren")!
                            
                            let ids = self._CommonHelper.GetKeysFromValues(dictionary: fullChildList as Dictionary<String, String>, selectedArray: mulitpleRow.value!)
                            
                            
                            let targetYear: PickerInlineRow<String>? = self.form.rowBy(tag: "TargetYearPicker")
                            let targetMonth: PickerInlineRow<String>? = self.form.rowBy(tag: "TargetMonthPicker")
                            
                            let targetMonthAsInt = self._CommonHelper.GetMonthAsInt(monthAsString: (targetMonth?.value)!)
                            
                            let destinationYear: PickerInlineRow<String>? = self.form.rowBy(tag: "DestinationYearPicker")
                            let destinationMonth: PickerInlineRow<String>? = self.form.rowBy(tag: "DestinationMonthPicker")
                            
                            let destinationMonthAsInt = self._CommonHelper.GetMonthAsInt(monthAsString: (destinationMonth?.value)!)
                            
                            self.RollOver(targetChildren: ids, targetYear: String(describing: (targetYear?.value)!),targetMonth: String(targetMonthAsInt),destinationYear: String(describing: (destinationYear?.value)!),destinationMonth: String(destinationMonthAsInt))
                            
                        }.cellUpdate
                        {
                            cell, row in
                            cell.backgroundColor = StyleManager.theme1()
                            cell.textLabel?.textColor = StyleManager.theme2()
                            cell.height = { 100 }
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
        
         self.navigationItem.title = "Roll Over"
        
    }
  
    func NavBarMenuTapped(_ sender: Any) {
       self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
    
    func RollOver(targetChildren: [String], targetYear: String, targetMonth: String, destinationYear: String, destinationMonth: String)
    {
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        PerformRollOverRecursively(targetChildren: targetChildren, targetYear: String(targetYear), targetMonth: String(targetMonth), destinationYear: String(destinationYear), destinationMonth: String(destinationMonth),  onCompletion: { json in
            
            DispatchQueue.main.async(execute: {
                
                SVProgressHUD.dismiss(withDelay: 1, completion: {
                    self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                } )
            })
        })
    }
    
    func PerformRollOverRecursively(targetChildren: [String], targetYear: String, targetMonth: String, destinationYear: String, destinationMonth: String, onCompletion: @escaping () -> Void)
    {
        var childrenList = targetChildren
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        RegistrationHoursRequests.sharedInstance.RollOverRegisteredHours(targetChildren: lastItem as! [String], targetYear: String(targetYear)!, targetMonth: String(targetMonth)!, destinationYear: String(destinationYear)!, destinationMonth: String(destinationMonth)!, onCompletion:
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
                    self.PerformRollOverRecursively(targetChildren: childrenList, targetYear: targetYear, targetMonth: targetMonth, destinationYear: destinationYear, destinationMonth: destinationMonth, onCompletion: onCompletion)
                    
                })
        })
        
    }
    
    
}

extension UIViewController {
    
    func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBackbutton(title: String) {
        if let nav = self.navigationController,
            let item = nav.navigationBar.topItem {
            item.backBarButtonItem  = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action:
                #selector(self.backButtonAction))
        } else {
            if let nav = self.navigationController,
                let _ = nav.navigationBar.backItem {
                self.navigationController!.navigationBar.backItem!.title = title
            }
        }
    }
}
