//
//  TimeStampsMenuController
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class TimeStampsMenuController: MainMenuViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       headingLabel.text = "Time Stamps"
        
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToSearchPerson_Edit") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? DateSelectionViewController {
                
                vc.OptionText = "Edit time stmaps."
                //vc.targetDate = DatePicker.date
                vc.Purpose = "GoToSearchPerson_Edit"
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Delete") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? DateSelectionViewController {
                
                vc.OptionText = "Delete time stamps."
               // vc.targetDate = DatePicker.date
                vc.Purpose = "GoToSearchPerson_Delete"
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Search") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? DateSelectionViewController {
                
                vc.OptionText = "Search for time stamps."
               // vc.targetDate = DatePicker.date
                vc.Purpose = "GoToSearchPerson_Search"
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Missing") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? DateSelectionViewController {
                
                vc.OptionText = "Search for missing time stamps."
               // vc.targetDate = DatePicker.date
                vc.Purpose = "GoToSearchPerson_Missing"
            }
        }
        
        if (segue.identifier == "GoToMainMenu") {
            
            //Settings the menu details.
            
            
            // if let navController = segue.destination as? UINavigationController {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.images = [UIImage(named: "Register"), UIImage(named: "Forecast"), UIImage(named: "TimeCard"), UIImage(named: "Information"), UIImage(named: "SignOut")]
                
                vc.segueIdList = ["GoToRegister", "GoToForecast", "GoToTimeStampsMenu", "GoToInformation", "GoToSignIn"]
                
                vc.DisplayTextList = ["Register",  "Forecast", "Time Stamps", "Informaiton", "Sign Out"]
                
            }
            //}
        }
        
            
        }
    
    
}
