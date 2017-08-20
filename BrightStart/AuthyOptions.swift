//
//  AuhtyOptions.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class AuthyOptions: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
    var childrenArray = Array<BrightStartChild>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setThemeUsingPrimaryColor(StyleManager.theme2(), withSecondaryColor: StyleManager.theme2(), andContentStyle: .dark)
        // UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
        _CommonHelper = CommonHelper()
        
        form +++ Section(){ section in
            var header = HeaderFooterView<UILabel>(.class)
            header.height = { 80.0 }
            header.onSetupView = {view, _ in
                view.textColor = StyleManager.theme1()
                view.text = "Configuring Authy."
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
        //                $0.title = "This feature enables you to take the 'Registered Hours' from one month and copy them over to another month. Bright Start intellegently keeps track of days of the week so you dont even need to look at your calendar."
        //                $0.cell.textLabel?.numberOfLines = 5
        //        }
        //
        //        form +++ Section("How does it work?")
        //            <<< LabelRow(){
        //                $0.title = "Its simple, just select the target month and ten your destination month before tapping the button found at the bottom of this page."
        //                $0.cell.textLabel?.numberOfLines = 6
        //        }
        //
        form +++ Section("Settings")
            
       <<< SwitchRow("UseAuthy") { row in
            row.title = "Use Authy?"
            }.onChange { row in
                row.title = (row.value ?? false) ? "Authy is on" : "Authy is off"
                row.updateCell()
            }.cellSetup { cell, row in
                cell.switchControl.onTintColor = StyleManager.theme1()
            }.cellUpdate { cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 18.0)
        }
            <<< LabelRow(){
                
                $0.hidden = Condition.function(["UseAuthy"], { form in
                    return !((form.rowBy(tag: "UseAuthy") as? SwitchRow)?.value ?? false)
                })
                $0.cell.textLabel?.numberOfLines = 6
                $0.title = "By using Authy, all registered parents will be required to have their mobiles phones with them when ever they drop off or pick up their children."
        }
        
       <<< SwitchRow("SignIn") { row in
            row.title = "Use Authy on Sign In"
        
        row.hidden = Condition.function(["UseAuthy"], { form in
            return !((form.rowBy(tag: "UseAuthy") as? SwitchRow)?.value ?? false)
        })
        
            }.onChange { row in
                row.title = (row.value ?? false) ? "Sign in enabled" : "Sign in disabled"
                row.updateCell()
            }.cellSetup { cell, row in
 cell.switchControl.onTintColor = StyleManager.theme1()
        }.cellUpdate { cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 18.0)
        }
            <<< LabelRow("SignInLabel"){
                
                $0.hidden = Condition.function(["SignIn"], { form in
                    return (!((form.rowBy(tag: "SignIn") as? SwitchRow)?.value ?? false) || !((form.rowBy(tag: "UseAuthy") as? SwitchRow)?.value ?? false))
                })
                $0.cell.textLabel?.numberOfLines = 6
                $0.title = "When a child attemps to sign in, the given parent will receive a notificaton to their phone which they will be required to accept before the child is succesfully signed in."
        }
        
       <<< SwitchRow("SignOut") { row in
            row.title = "Use Authy on Sign Out"
        
        row.hidden = Condition.function(["UseAuthy"], { form in
            return !((form.rowBy(tag: "UseAuthy") as? SwitchRow)?.value ?? false)
        })
        
            }.onChange { row in
                row.title = (row.value ?? false) ? "Sign out enabled" : "Sign in enabled"
                row.updateCell()
        }.cellSetup
        {
            cell,
            row in cell.switchControl.onTintColor = StyleManager.theme1()
            
        }.cellUpdate { cell, row in
                cell.textLabel?.font = .italicSystemFont(ofSize: 18.0)
        }
            <<< LabelRow("SignOutLabel"){
                
                $0.hidden = Condition.function(["SignOut"], { form in
                    return (!((form.rowBy(tag: "SignOut") as? SwitchRow)?.value ?? false) || !((form.rowBy(tag: "UseAuthy") as? SwitchRow)?.value ?? false))
                })
                $0.cell.textLabel?.numberOfLines = 6
                  $0.title = "When a child attemps to sign out, the given parent will receive a notificaton to their phone which they will be required to accept before the child is succesfully signed in."
        }
        
        
        let defaults = UserDefaults.standard
       
        var switchRow: SwitchRow? = form.rowBy(tag: "UseAuthy")
        switchRow?.value = defaults.bool(forKey: "ShouldUseAuhty")
       // switchRow?.updateCell() // or row.updateCell()
        
        switchRow = form.rowBy(tag: "SignIn")
        switchRow?.value = defaults.bool(forKey: "ShouldUseAuhtyOnSignIn")
        //switchRow?.updateCell() // or row.updateCell()
       
        switchRow = form.rowBy(tag: "SignOut")
        switchRow?.value = defaults.bool(forKey: "ShouldUseAuhtyOnSignOut")
        //switchRow?.updateCell() // or row.updateCell()
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Save Changes"
                }.onCellSelection {  cell, row in
                   
                    SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
                    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                    SVProgressHUD.show()
                    
                    var switchRow: SwitchRow? = self.form.rowBy(tag: "UseAuthy")
                    defaults.set(switchRow?.value, forKey: "ShouldUseAuhty")
                    
                    switchRow = self.form.rowBy(tag: "SignIn")
                    defaults.set(switchRow?.value, forKey: "ShouldUseAuhtyOnSignIn")
                    
                    switchRow = self.form.rowBy(tag: "SignOut")
                    defaults.set(switchRow?.value, forKey: "ShouldUseAuhtyOnSignOut")
                    
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        
                        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                        
                    } )
                    
                }.cellUpdate
                {
                    cell, row in
                    cell.backgroundColor = StyleManager.theme1()
                    cell.textLabel?.textColor = StyleManager.theme2()
                    cell.height = { 70 }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToMenu") {
            
            if let vc = segue.destination as? MainMenuViewController {
                vc.selectedMenu = .Authy
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
        
        self.navigationItem.title = "Authy Settings"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
}


