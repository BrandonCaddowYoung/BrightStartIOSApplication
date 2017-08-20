//
//  SettingRegistrationHours.swift
//  BrightStart
//
//  Created by Brandon Young on 07/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class SettingRegistrationHours: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var personName = "";
    var personId = "";
    var targetDate = Date()
    
    var targetDateAsText = "";
    
    var showNavigationBar = true
    
    var selectedStartTime = Date()
    var selectedEndTime = Date()
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
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
                view.text = "Setting weekly regisred hours."
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
//                $0.title = "This feature allows you to create 'Registered Hours' for " + personName + ". To get going, simply select a start time and end time using the fields below before pressing the button found at the bottom of the page."
//                $0.cell.textLabel?.numberOfLines = 5
//        }
        
        form +++ Section("Date")
            <<< LabelRow(){
                $0.title = "date"
                $0.value = targetDate.ToString()
            }
            
            <<< LabelRow(){
                $0.title = "name"
                $0.value = personName
                
        }
        
        form +++ Section("Select the start time")
            
            <<< TimePickerRow("StartTimePicker") {
                $0.title = "start"
                $0.value = selectedStartTime.setTime(hour: 09, min: 00, sec: 00)!
        }
        
        form +++ Section("Select the end time")
            
            <<< TimePickerRow("EndTimePicker") {
                $0.title = "start"
                $0.value = selectedEndTime.setTime(hour: 17, min: 00, sec: 00)!
        }
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Create Registerd Hours"
                }.onCellSelection {  cell, row in
                    
                    var row: TimePickerRow? = self.form.rowBy(tag: "StartTimePicker")
                    let selectedStartTime = row?.value
                    
                    row = self.form.rowBy(tag: "EndTimePicker")
                    let selectedEndTime = row?.value
                    
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    RegistrationHoursRequests.sharedInstance.CreateRegisteredHours(personId: self.personId, startTime: selectedStartTime!, finishTime: selectedEndTime!, onCompletion: { (JSON) in
                        
                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                            
                            self._CommonHelper.ShowSuccessMessage(title: "Success", subsTtitle: "'Registered Hours' have been successfully created.")
                            
                            //Always goes back when done but this could be optional?
                            
                            if let nav = self.navigationController {
                                nav.popViewController(animated: true)
                            } else {
                                
                                self.dismiss(animated: true, completion: nil)
                            }
                        } )
                    })
                }.cellUpdate
                {
                    cell, row in
                    cell.backgroundColor = StyleManager.theme1()
                    cell.textLabel?.textColor = StyleManager.theme2()
                    cell.height = { 70 }
        }
        
        func viewWillAppear(_ animated: Bool) {
            
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
            
            let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
            
            //Right button
            self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
            self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
            
            self.navigationItem.title = "Weekly Registered Hours"
            
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any!) {
            
            if (segue.identifier == "GoToMenu") {
                
                if let vc = segue.destination as? MainMenuViewController {
                    
                    //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
                    
                    vc.selectedMenu = .RegisteredHours
                    
                }
                
            }
            
        }
        
    }
}

