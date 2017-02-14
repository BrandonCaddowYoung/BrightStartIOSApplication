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
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "GoToSearchPerson_Edit"
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_ExtraMinutes") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Delete") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                 vc.Purpose = "GoToSearchPerson_Delete"
                
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Search") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "GoToSearchPerson_Search"
                
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Missing") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "GoToSearchPerson_Missing"

                
            }
        }
        
        if (segue.identifier == "GoToMainMenu") {
            
            //Settings the menu details.
            
            
            // if let navController = segue.destination as? UINavigationController {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .MainMenu
                
            }
            
        }
        
            
        }
    
    
}
