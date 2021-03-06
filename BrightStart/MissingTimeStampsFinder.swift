//
//  MissingTimeStampsFinder.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class MissingTimeStampsFinder: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var startDate = Date()
    var endDate = Date()
    
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
                view.text = "Searching for missing timestamps"
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
//                $0.title = "This feature allows you to quickly identify 'Missing Time Stamps'."
//                $0.cell.textLabel?.numberOfLines = 5
//                //$0.cell.height = { 300 }
//        }
//        
//        form +++ Section("What are 'Missing Time Stamps'?")
//            <<< LabelRow(){
//                $0.title = "Missing Time Stamps occur when a parent forgets to sign a child in or out, leaving just one time stamp for the day. This can cause problems when creating invoices as it is impossobile to know when the child was really supposed to be arriving or leaving."
//                $0.cell.textLabel?.numberOfLines = 6
//        }
        
        form +++ Section("Date range")
            
            <<< DateRow("StartDate"){
                $0.title = "start date"
                $0.value = Date()
            }
            <<< DateRow("EndDate"){
                $0.title = "end date"
                $0.value = Date().addDays(10)
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Search for missing time stmaps"
                }.onCellSelection {  cell, row in
                    
                    let start: DateRow? = self.form.rowBy(tag: "StartDate")
                    self.startDate = (start?.value)!
                    
                    let end: DateRow? = self.form.rowBy(tag: "EndDate")
                    self.endDate = (end?.value)!
                    
                    
                    if self._CommonHelper.IsStartDateAfterEndDate(startYear: (self.startDate.year),
                                                                  startMonth: (self.startDate.month),
                                                                  startDay: (self.startDate.day),
                                                                  endYear: (self.endDate.year),
                                                                  endMonth: (self.endDate.month),
                                                                  endDay: (self.endDate.day))                            {
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            
                            self._CommonHelper.ShowErrorMessage(title: "Sorry", subsTtitle: "Please ensuare that the start date is before the end date.");
                            
                        } )
                        
                        return
                    }

                    
                    
                    
                    self.performSegue(withIdentifier: "GoToMissingTimeStampsResults", sender: self)
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
        
        if (segue.identifier! == "GoToMissingTimeStampsResults") {
            
            if let vc = segue.destination as? MissingTimeStampsResults {
                
                vc.startDate = startDate
                vc.endDate = endDate
                
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

