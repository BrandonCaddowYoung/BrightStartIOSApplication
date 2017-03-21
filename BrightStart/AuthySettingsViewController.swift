//
//  AuthySettingsViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 05/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AuthySettingsViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!

    var selectedMenu: MenuTypes!
    
    var showNavigationBar = true
    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var MiddleContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    
    
    @IBOutlet weak var Top: UIView!
    @IBOutlet weak var Top1: UIView!
    @IBOutlet weak var Middle: UIView!
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var OnSignInLabel: UILabel!
    @IBOutlet weak var UseAuthyLabel: UILabel!
    @IBOutlet weak var OnSignOutLabel: UILabel!
    @IBOutlet weak var ExplinationLabel: UILabel!
    
    @IBOutlet weak var UseAuthySwitch: UISwitch!
    @IBOutlet weak var OnSignInSwitch: UISwitch!
    @IBOutlet weak var OnSignOutSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        Top.backgroundColor = _ApplicatoinColours.White
        Top1.backgroundColor = _ApplicatoinColours.BackGroundColour
        Middle.backgroundColor = _ApplicatoinColours.White
        Bottom.backgroundColor = _ApplicatoinColours.White
        
        setupConstraints()
        
        Top.addBottomBorder(color: _ApplicatoinColours.Orange, margins: 1)
        Top.addTopBorder(color: _ApplicatoinColours.Orange, margins: 1)
        
        //Middle.addBottomBorder(color: _ApplicatoinColours.Orange, margins: 1)
        Middle.addTopBorder(color: _ApplicatoinColours.Orange, margins: 1)
        
        Bottom.addBottomBorder(color: _ApplicatoinColours.Orange, margins: 1)
        Bottom.addTopBorder(color: _ApplicatoinColours.Orange, margins: 1)
        
        ExplinationLabel.lineBreakMode = .byWordWrapping
        ExplinationLabel.numberOfLines = 5
        ExplinationLabel.textColor = _ApplicatoinColours.FontColour
        
        ExplinationLabel.text = "By using Authy, all registered parents will be required to have their mobiles phones with them when ever they drop off or pick up their children."
        
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        
        //Positioning the left subview
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        MiddleContainer.translatesAutoresizingMaskIntoConstraints = false
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
      
        OnSignInLabel.translatesAutoresizingMaskIntoConstraints = false
        UseAuthyLabel.translatesAutoresizingMaskIntoConstraints = false
        OnSignOutLabel.translatesAutoresizingMaskIntoConstraints = false
        UseAuthySwitch.translatesAutoresizingMaskIntoConstraints = false
        OnSignInSwitch.translatesAutoresizingMaskIntoConstraints = false
        OnSignOutSwitch.translatesAutoresizingMaskIntoConstraints = false
        ExplinationLabel.translatesAutoresizingMaskIntoConstraints = false

        Top.translatesAutoresizingMaskIntoConstraints = false
        Top1.translatesAutoresizingMaskIntoConstraints = false
        Middle.translatesAutoresizingMaskIntoConstraints = false
        Bottom.translatesAutoresizingMaskIntoConstraints = false
        
        //Top
        
        //left
        TopContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //Right
        TopContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        TopContainer.topAnchor.constraint(
            equalTo: view.readableContentGuide.topAnchor).isActive = true
        
        //height
        TopContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //Middle
        
        //left
        MiddleContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //Right
        MiddleContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        MiddleContainer.topAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        //height
        MiddleContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.60).isActive = true
        
        //Top
        
        //left
        Top.leadingAnchor.constraint(
            equalTo: TopContainer.leadingAnchor).isActive = true
        
        //right
        Top.trailingAnchor.constraint(
            equalTo: TopContainer.trailingAnchor).isActive = true
        
        //right
        Top.topAnchor.constraint(
            equalTo: TopContainer.topAnchor, constant: 35).isActive = true
        
        //height
        Top.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //Use Authy
        
        //left
        UseAuthyLabel.leadingAnchor.constraint(
            equalTo: Top.leadingAnchor, constant: 20).isActive = true
        
        //top
        UseAuthyLabel.centerYAnchor.constraint(
            equalTo: Top.centerYAnchor).isActive = true
        
       
        //Use Authy Switch
        
        //right
        UseAuthySwitch.trailingAnchor.constraint(
            equalTo: Top.trailingAnchor, constant : -20).isActive = true
        
        UseAuthySwitch.centerYAnchor.constraint(
            equalTo: UseAuthyLabel.centerYAnchor).isActive = true
        
        
        //Top
        
        //left
        Top1.leadingAnchor.constraint(
            equalTo: MiddleContainer.leadingAnchor).isActive = true
        
        //right
        Top1.trailingAnchor.constraint(
            equalTo: MiddleContainer.trailingAnchor).isActive = true
        
        //top
        Top1.topAnchor.constraint(
            equalTo: Top.bottomAnchor).isActive = true
        
        //height
        Top1.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor,
            multiplier: 0.40).isActive = true
        
        //Use Authy
        
        //left
        ExplinationLabel.leadingAnchor.constraint(
            equalTo: Top1.leadingAnchor, constant: 20).isActive = true
        
        ExplinationLabel.trailingAnchor.constraint(
            equalTo: Top1.trailingAnchor, constant: -20).isActive = true
        
        //top
        ExplinationLabel.centerYAnchor.constraint(
            equalTo: Top1.centerYAnchor).isActive = true
        
        //Middle
        
        //left
        Middle.leadingAnchor.constraint(
            equalTo: MiddleContainer.leadingAnchor).isActive = true
        
        //right
        Middle.trailingAnchor.constraint(
            equalTo: MiddleContainer.trailingAnchor).isActive = true
        
        //top
        Middle.topAnchor.constraint(
            equalTo: Top1.bottomAnchor).isActive = true
        //height
        Middle.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //Use Authy
        
        //left
        OnSignInLabel.leadingAnchor.constraint(
            equalTo: Middle.leadingAnchor, constant: 20).isActive = true
        
        //top
        OnSignInLabel.centerYAnchor.constraint(
            equalTo: Middle.centerYAnchor).isActive = true
        
        
        //Use Authy Switch
        
        //right
        OnSignInSwitch.trailingAnchor.constraint(
            equalTo: Middle.trailingAnchor, constant : -20).isActive = true
        
        OnSignInSwitch.centerYAnchor.constraint(
            equalTo: OnSignInLabel.centerYAnchor).isActive = true
        //Bottom
        
        //left
        Bottom.leadingAnchor.constraint(
            equalTo: MiddleContainer.leadingAnchor).isActive = true
        
        //right
        Bottom.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor).isActive = true
        
        //top
        Bottom.topAnchor .constraint(
            equalTo: Middle.bottomAnchor).isActive = true
        
        //height
        Bottom.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor,
            multiplier: 0.20).isActive = true
        
        
        Bottom.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        
        //Use Authy
        
        //left
        OnSignOutLabel.leadingAnchor.constraint(
            equalTo: Bottom.leadingAnchor, constant: 20).isActive = true
        
        //top
        OnSignOutLabel.centerYAnchor.constraint(
            equalTo: Bottom.centerYAnchor).isActive = true
        
        
        //Use Authy Switch
        
        //right
        OnSignOutSwitch.trailingAnchor.constraint(
            equalTo: Bottom.trailingAnchor, constant : -20).isActive = true
        
        OnSignOutSwitch.centerYAnchor.constraint(
            equalTo: OnSignOutLabel.centerYAnchor).isActive = true
        
        //Bottom
        
        //left
        BottomContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //Right
        BottomContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        BottomContainer.topAnchor.constraint(
            equalTo: MiddleContainer.bottomAnchor).isActive = true
        
        //top
        BottomContainer.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
    }

    
    @IBAction func UseAuthyClicked(_ sender: Any) {
        
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
    
    @IBAction func OnSignInSwitched(_ sender: UISwitch) {
        
         let defaults = UserDefaults.standard
        
        if(self.OnSignInSwitch.isOn)
        {
            defaults.set(true, forKey: "ShouldUseAuhtyOnSignIn")
        }else
        {
        defaults.set(false, forKey: "ShouldUseAuhtyOnSignIn")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            
            SetNaviagationBarDetails()
            
        }
    }
    
    func SetNaviagationBarDetails()
    {
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.Black]
        navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.White
        
        self.navigationController?.navigationBar.topItem?.title = "Authy Settings";
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        
        self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black

    }
    
    func NavBarMenuTapped()
    {
        selectedMenu = .Authy
        
    self.performSegue(withIdentifier: "GoToMenu", sender: self)
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
    
    
   
    
    @IBAction func OKClicked(_ sender: Any) {
        
        selectedMenu = .Authy
        
         self.performSegue(withIdentifier: "GoToMenu", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if (segue.identifier! == "GoToMenu") {
            
            //Settings the menu details.
            
            //Need to get the specific user. so navigate to menu.
            
            if let vc = segue.destination as? MainMenuViewController {
                
                if(selectedMenu == .Authy){
                vc.selectedMenu = .Authy
                }
                else if(selectedMenu == .MainMenu)
                {
                vc.selectedMenu = .MainMenu
                }
            }
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
