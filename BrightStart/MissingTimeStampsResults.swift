//
//  MissingTimeStampsResults.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class MissingTimeStampsResults: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var countArray : Array<TimeStampCount> = []
    
    var startDate = Date()
    var endDate = Date()
    
    var selectedDate = Date()
    var SelectedPersonId = ""
    var SelectedPersonFullName = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .light)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Missing timestamps reuslts"
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
                $0.title = "Found below are the results found for the following date range. " + startDate.ToString() + " - " + endDate.ToString()
                $0.cell.textLabel?.numberOfLines = 5
        }
        
        //Retrieve all missing time stamps
        CommonRequests.sharedInstance.GetMissingTimeStamps(start: startDate, end: endDate, onCompletion: { json in
            
            for (index: _, subJson: JSON) in json {
                
                let count = TimeStampCount()
                
                count.ChildFullName = JSON["ChildFullName"].stringValue
                count.ChildId = JSON["ChildId"].stringValue
                count.NumberOfStamps = Int(JSON["NumberOfStamps"].stringValue)!
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
                
                let targetDate = JSON["TargetDate"].stringValue
                
                var newDate = dateFormatter.date(from: targetDate)
                
                if(newDate == nil){
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    newDate = dateFormatter.date(from: targetDate)
                    if(newDate == nil){
                        continue
                    }
                }
                
                count.TargetDate = newDate!
                
                self.countArray.append(count)
            }
            
            DispatchQueue.main.async(execute: {
                
                for count in self.countArray{
                    
                    //ITERATE
                    
                    self.form +++ Section("Missing time stamp")
                        
                        <<< LabelRow() {
                            $0.title = "name"
                            $0.value = count.ChildFullName
                        }
                        
                        <<< LabelRow() {
                            $0.title = "number of time stamps"
                            $0.value = String(count.NumberOfStamps)
                        }
                        
                        <<< LabelRow() {
                            $0.title = "date"
                            $0.value = count.TargetDate.ToString()
                        }
                        
                        <<< ButtonRow(){
                            $0.title = "Go to this date"
                            }.onCellSelection {  cell, row in
                                
                                self.selectedDate = count.TargetDate
                                
                                self.SelectedPersonId = count.ChildId
                                self.SelectedPersonFullName = count.ChildFullName
                                
                                self.performSegue(withIdentifier: "GoToDateInCalendar", sender: self)
                                
                            }.cellUpdate
                            {
                                cell, row in
                                cell.backgroundColor = StyleManager.theme1()
                                cell.textLabel?.textColor = StyleManager.theme2()
                                cell.height = { 70 }
                    }
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
        
        self.navigationItem.title = "Missing Time Stamps"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier! == "GoToDateInCalendar") {
            
            if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                
                vc.jumpToDate = self.selectedDate
                vc.shouldJumpToDate = true
                
                vc.childId = self.SelectedPersonId as String
                vc.childName = self.SelectedPersonFullName as String
                vc.Purpose = "TimeStamps_Edit"
                vc.selectCalendarPurpose = .TimeStamps
                
                vc.showNavigationBar = true
                
            }
        }
        else if (segue.identifier! == "GoToMainMenu") {
            
            //Settings the menu details.
            
            //Need to get the specific user. so navigate to menu.
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .TimeStamps
            }
        }
    }
    
}

