//
//  Recomnedations.swift
//  BrightStart
//
//  Created by Brandon Young on 02/05/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import Eureka
import SVProgressHUD

class Recomnedations: FormViewController {
    
    var _CommonHelper: CommonHelper!
    
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
                view.text = "Welcome to Bright Start."
                view.textAlignment = .center
                view.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
            }
            section.header = header
        }
        
        form +++ Section()
            {
                $0.header = HeaderFooterView<LogoView>(.class)
        }
        
        form +++ Section("Thanks for choosing Bright Start")
            <<< LabelRow("Step0Text"){
                $0.title = "We thought it would be worth your while for us to compile some information that would help you better familiarise your self with Bright Starts broad feature list. You may find that you already have knowledge of some of the information described below. However, you will more than likely find new information that will help save you time moving forward."
                $0.cell.textLabel?.numberOfLines = 6
        }
        
        self.form +++ Section()
            <<< ButtonRow(){
                $0.title = "Lets get going"
                }.onCellSelection {  cell, row in
                    
                    let nextText = self.form.rowBy(tag: "Step1Text") as? LabelRow
                    //nextText?.cell.isHidden = false
                    
                    nextText?.hidden = false
                    
                    let nextButton = self.form.rowBy(tag: "Step1Button") as? LabelRow
                    nextButton?.cell.isHidden = false
                    
                    let currentText = self.form.rowBy(tag: "Step0Text") as? LabelRow
                    currentText?.cell.isHidden = true
                    
                    cell.isHidden = true
                    
                    
                }.cellUpdate
                {
                    cell, row in
                    cell.backgroundColor = StyleManager.theme1()
                    cell.textLabel?.textColor = StyleManager.theme2()
                    cell.height = { 70 }
        }
        
        form +++ Section("Lets start at the beginning")
            
            
            
            <<< LabelRow("Step1Text"){
                $0.title = "Once you have added your children to Bright Start using the functionality found within the Main Menu. You are ready to use the ‘Register’ to sign children in and out.The process of signing a child in or out straight forward. From within the ‘Register’ simply swipe left on a child’s name. When this happens ‘Time Stamps’ are created. These ‘Time Stamps will later be used to create invoices.’."
                $0.cell.textLabel?.numberOfLines = 6
                
                $0.hidden = true
        }
        
        self.form +++ Section()
            <<< ButtonRow("Step1Button"){
                $0.title = "Next"
                $0.hidden = true
                
                }.onCellSelection {  cell, row in
                    
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
        
        self.navigationItem.title = "Quick Create"
        
    }
    
    func NavBarMenuTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: nil)
    }
    
    
    
}

