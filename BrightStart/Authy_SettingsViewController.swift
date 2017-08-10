//
//  Authy_SettingsViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 17/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class Authy_SettingsViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var selectedMenu: MenuTypes!
    
    var showNavigationBar = true
    
    @IBOutlet weak var Middle: UIView!
    
    @IBOutlet weak var Middle1: UIView!
    @IBOutlet weak var Middle2: UIView!
    @IBOutlet weak var Middle3: UIView!
    @IBOutlet weak var Middle4: UIView!
    
    @IBOutlet weak var UseAuthyLabel: UILabel!
    
    @IBOutlet weak var AuthyDescriptionLabel: UILabel!
    
    @IBOutlet weak var OnSignInLabel: UILabel!
    
    @IBOutlet weak var OnSignOutLabel: UILabel!
    
    @IBOutlet weak var UseAuthySwitch: UISwitch!
    
    @IBOutlet weak var OnSignInSwitch: UISwitch!
    
    @IBOutlet weak var OnSignOutSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        Middle.backgroundColor = StyleManager.DarkBackground()
        
        Middle1.backgroundColor = StyleManager.theme2()
        
        Middle2.backgroundColor = StyleManager.DarkBackground()
        Middle3.backgroundColor = StyleManager.theme2()
        Middle4.backgroundColor = StyleManager.theme2()
        
        view.backgroundColor = StyleManager.DarkBackground()
        
        
        Middle1.addBottomBorder(color: StyleManager.theme4(), margins: 1)
        Middle1.addTopBorder(color: StyleManager.theme4(), margins: 1)
        
        Middle2.addBottomBorder(color: StyleManager.theme4(), margins: 1)
        
        Middle3.addBottomBorder(color: StyleManager.theme4(), margins: 1)
        
        Middle4.addBottomBorder(color: StyleManager.theme4(), margins: 1)
        
        AuthyDescriptionLabel.lineBreakMode = .byWordWrapping
        AuthyDescriptionLabel.numberOfLines = 5
        AuthyDescriptionLabel.textColor = StyleManager.FontColour()
        
        AuthyDescriptionLabel.text = "By using Authy, all registered parents will be required to have their mobiles phones with them when ever they drop off or pick up their children."
        
        
        OnSignInSwitch.onTintColor = StyleManager.theme1()
        OnSignOutSwitch.onTintColor = StyleManager.theme1()
        UseAuthySwitch.onTintColor = StyleManager.theme1()
        
        let defaults = UserDefaults.standard
        
        let shouldUseAuthy = defaults.bool(forKey: "ShouldUseAuhty")
        
        if(shouldUseAuthy==true)
        {
            OnSignInSwitch.isEnabled = true
            OnSignOutSwitch.isEnabled = true
            
            OnSignInLabel.isEnabled = true
            OnSignOutLabel.isEnabled = true
            
            let shouldUseAuhtyOnSignIn = defaults.bool(forKey: "ShouldUseAuhtyOnSignIn")
            
            if(shouldUseAuhtyOnSignIn == true)
            {
                OnSignInSwitch.setOn(true, animated: true)
            }
            else
            {
                OnSignInSwitch.setOn(false, animated: true)
            }
            
            let shouldUseAuhtyOnSignOut = defaults.bool(forKey: "ShouldUseAuhtyOnSignOut")
            
            if(shouldUseAuhtyOnSignOut==true)
            {
                OnSignOutSwitch.setOn(true, animated: true)
                
            }
            else
            {
                OnSignOutSwitch.setOn(false, animated: true)
            }
            
        }
        else
        {
            OnSignInSwitch.isEnabled = false
            OnSignOutSwitch.isEnabled = false
            
            OnSignInLabel.isEnabled = false
            OnSignOutLabel.isEnabled = false
            
            OnSignInSwitch.setOn(false, animated: true)
            OnSignOutSwitch.setOn(false, animated: true)
            UseAuthySwitch.setOn(false, animated: true)
        }
        
    }
    
    func setupConstraints() {
        
        //Positioning the left subview
        
        Middle.translatesAutoresizingMaskIntoConstraints = false
        
        //Middle
        
        //left
        Middle.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        Middle.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //height
        Middle.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.70).isActive = true
        
        //center
        Middle.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        Middle.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        Middle1.translatesAutoresizingMaskIntoConstraints = false
        
        //Middle 1
        
        //left
        Middle1.leadingAnchor.constraint(
            equalTo: Middle.leadingAnchor).isActive = true
        
        //right
        Middle1.trailingAnchor.constraint(
            equalTo: Middle.trailingAnchor).isActive = true
        
        //height
        Middle1.heightAnchor.constraint(
            equalTo: Middle.heightAnchor, multiplier: 0.15).isActive = true
        
        //height
        Middle1.topAnchor.constraint(
            equalTo: Middle.topAnchor).isActive = true
        
        
        UseAuthyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        UseAuthyLabel.leadingAnchor.constraint(
            equalTo: Middle1.leadingAnchor, constant: 10).isActive = true
        
        //horizontal center
        UseAuthyLabel.centerYAnchor.constraint(
            equalTo: Middle1.centerYAnchor).isActive = true
        
        
        UseAuthySwitch.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        UseAuthySwitch.trailingAnchor.constraint(
            equalTo: Middle1.trailingAnchor, constant: -10).isActive = true
        
        //horizontal center
        UseAuthySwitch.centerYAnchor.constraint(
            equalTo: Middle1.centerYAnchor).isActive = true
        
        
        //Middle2
        
        Middle2.translatesAutoresizingMaskIntoConstraints = false
        
        //Middle2
        
        //left
        Middle2.leadingAnchor.constraint(
            equalTo: Middle.leadingAnchor).isActive = true
        
        //right
        Middle2.trailingAnchor.constraint(
            equalTo: Middle.trailingAnchor).isActive = true
        
        //height
        Middle2.heightAnchor.constraint(
            equalTo: Middle.heightAnchor, multiplier: 0.20).isActive = true
        
        //height
        Middle2.topAnchor.constraint(
            equalTo: Middle1.bottomAnchor).isActive = true
        
        
        AuthyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        AuthyDescriptionLabel.leadingAnchor.constraint(
            equalTo: Middle2.leadingAnchor, constant: 10).isActive = true
        
        //right
        AuthyDescriptionLabel.trailingAnchor.constraint(
            equalTo: Middle2.trailingAnchor).isActive = true
        
        //horizontal center
        AuthyDescriptionLabel.centerYAnchor.constraint(
            equalTo: Middle2.centerYAnchor).isActive = true
        
        
        
        //Middle3
        
        Middle3.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        Middle3.leadingAnchor.constraint(
            equalTo: Middle.leadingAnchor).isActive = true
        
        //right
        Middle3.trailingAnchor.constraint(
            equalTo: Middle.trailingAnchor).isActive = true
        
        //height
        Middle3.heightAnchor.constraint(
            equalTo: Middle.heightAnchor, multiplier: 0.15).isActive = true
        
        //height
        Middle3.topAnchor.constraint(
            equalTo: Middle2.bottomAnchor).isActive = true
        
        
        OnSignInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        OnSignInLabel.leadingAnchor.constraint(
            equalTo: Middle3.leadingAnchor, constant: 10).isActive = true
        
        //horizontal center
        OnSignInLabel.centerYAnchor.constraint(
            equalTo: Middle3.centerYAnchor).isActive = true
        
        
        OnSignInSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        OnSignInSwitch.trailingAnchor.constraint(
            equalTo: Middle3.trailingAnchor, constant: -10).isActive = true
        
        //horizontal center
        OnSignInSwitch.centerYAnchor.constraint(
            equalTo: Middle3.centerYAnchor).isActive = true
        
        
        
        
        //Middle4
        
        Middle4.translatesAutoresizingMaskIntoConstraints = false
        
        
        //left
        Middle4.leadingAnchor.constraint(
            equalTo: Middle.leadingAnchor).isActive = true
        
        //right
        Middle4.trailingAnchor.constraint(
            equalTo: Middle.trailingAnchor).isActive = true
        
        //height
        Middle4.heightAnchor.constraint(
            equalTo: Middle.heightAnchor, multiplier: 0.15).isActive = true
        
        //height
        Middle4.topAnchor.constraint(
            equalTo: Middle3.bottomAnchor).isActive = true
        
        OnSignOutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        OnSignOutLabel.leadingAnchor.constraint(
            equalTo: Middle4.leadingAnchor, constant: 10).isActive = true
        
        //horizontal center
        OnSignOutLabel.centerYAnchor.constraint(
            equalTo: Middle4.centerYAnchor).isActive = true
        
        OnSignOutSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        //right
        OnSignOutSwitch.trailingAnchor.constraint(
            equalTo: Middle4.trailingAnchor, constant: -10).isActive = true
        
        //horizontal center
        OnSignOutSwitch.centerYAnchor.constraint(
            equalTo: Middle4.centerYAnchor).isActive = true
        
        
        
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if (segue.identifier! == "GoToMenu") {
            
            //Settings the menu details.
            
            //Need to get the specific user. so navigate to menu.
            
            if let vc = segue.destination as? MainMenuViewController {
                
                if(selectedMenu == nil){
                    vc.selectedMenu = .Authy
                }
                else if(selectedMenu == .Authy){
                    vc.selectedMenu = .Authy
                }
                else if(selectedMenu == .MainMenu)
                {
                    vc.selectedMenu = .MainMenu
                }
                
            }
            
        }
    }
    
    
    @IBAction func UseAuthySwitched(_ sender: Any) {
        
        
        let defaults = UserDefaults.standard
        
        if(self.UseAuthySwitch.isOn)
        {
            OnSignInSwitch.isEnabled = true
            OnSignOutSwitch.isEnabled = true
            
            OnSignInLabel.isEnabled = true
            OnSignOutLabel.isEnabled = true
            
            defaults.set(true, forKey: "ShouldUseAuhty")
            
        }else
        {
            OnSignInSwitch.isEnabled = false
            OnSignOutSwitch.isEnabled = false
            
            OnSignInLabel.isEnabled = false
            OnSignOutLabel.isEnabled = false
            
            defaults.set(false, forKey: "ShouldUseAuhty")
            
            OnSignInSwitch.setOn(false, animated: true)
            OnSignOutSwitch.setOn(false, animated: true)
            
            defaults.set(false, forKey: "ShouldUseAuhtyOnSignIn")
            defaults.set(false, forKey: "ShouldUseAuhtyOnSignOut")
            
        }
        
    }
    
    
    @IBAction func OnSIgnInSwitched(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        if(self.OnSignInSwitch.isOn)
        {
            defaults.set(true, forKey: "ShouldUseAuhtyOnSignIn")
        }else
        {
            defaults.set(false, forKey: "ShouldUseAuhtyOnSignIn")
        }
        
    }
    
    
    
    @IBAction func OnSignOutSwitched(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if(self.OnSignOutSwitch.isOn)
        {
            defaults.set(true, forKey: "ShouldUseAuhtyOnSignOut")
        }else
        {
            defaults.set(false, forKey: "ShouldUseAuhtyOnSignOut")
        }
        
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
