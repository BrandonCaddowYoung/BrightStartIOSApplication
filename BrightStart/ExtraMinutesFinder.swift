//
//  ExtraMinutesFinder.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class ExtraMinutesFinder: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var targetDate = Date()
    
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
                view.text = "Searching for extra time"
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
                $0.title = "This feature allows you to quickly identify children who have accumulated 'Extra Time' for a particular date."
                $0.cell.textLabel?.numberOfLines = 5
        }
        
        form +++ Section("What is 'Extra Time'?")
            <<< LabelRow(){
                $0.title = "'Extra Time' occurs when a child is early or late for their pre-defined 'Registered Hours'. When creating invoces, this time is accumulated and charged for accordingly."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        form +++ Section("Date range")
            
            <<< DateRow("TargetDate"){
                $0.title = "target date"
                $0.value = Date()
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Search for children wth extra time"
                }.onCellSelection {  cell, row in
                    
                    let start: DateRow? = self.form.rowBy(tag: "TargetDate")
                    self.targetDate = (start?.value)!
                    
                    self.performSegue(withIdentifier: "GoToSearchPerson", sender: self)
                    
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
        
        self.navigationItem.title = "Extra Time Search"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToSearchPerson") {
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.targetDate = targetDate
                
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                vc.successSegueIdentifier = "GoToTimeStampSearch"
                
            }
        }
        else if (segue.identifier! == "GoToMenu") {
            
            //Settings the menu details.
            
            //Need to get the specific user. so navigate to menu.
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .TimeStamps
            }
        }
        
    }
    
}

