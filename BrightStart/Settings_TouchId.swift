//
//  Settings_Email.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Settings_TouchId: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var emailSettings = EmailSettings()
    
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
                view.text = "TouchId"
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
                
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return self._CommonHelper.isDeviceTouchIdEnabled()
                })
                $0.title = "You do not have a device with a finger print reader or you have not yet added any finger prints."
                $0.cell.textLabel?.numberOfLines = 5
            }
            
            <<< SwitchRow("SwitchRow") { row in      // initializer
                row.title = "Use finger print to sign in."
                
                row.hidden = Condition.function(["switchRowTag"], { form in
                    return !self._CommonHelper.isDeviceTouchIdEnabled()
                })
                row.value = _CommonHelper.retrieveUsingTouchId()
                
                }.onChange { row in
                    row.title = (row.value ?? false) ? "Use finger print." : "Do not use finger print reader."
                    row.updateCell()
                }.cellSetup
                {
                    cell,
                    row in cell.switchControl.onTintColor = StyleManager.theme1()
                    
                }.cellUpdate { cell, row in
                    cell.textLabel?.font = .italicSystemFont(ofSize: 18.0)
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Save Changes"
                }.onCellSelection {  cell, row in
                    
                                                SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                                                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                                                SVProgressHUD.show()
                    
                    let switchRow: SwitchRow? = self.form.rowBy(tag: "SwitchRow")
                    
                    let defaults = UserDefaults.standard
                    defaults.set(switchRow?.value, forKey: "UsingTouchId")
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                    })

                }
                .cellUpdate
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
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Settings
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
        
        self.navigationItem.title = "Setting Rates"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
}

