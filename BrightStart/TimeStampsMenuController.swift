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
        
    }
    
    var activeSegue = ""
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "TimeStamps_Edit") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Edit"
            }
        }
        
       else if (segue.identifier == "GoToSearchPerson_ExtraMinutes") {
            
            if let vc = segue.destination as? RegisterdHoursTimeStampsCalendarViewController {
                
                vc.Purpose = "GoToSearchPerson_ExtraMinutes"
                //vc.childId = self.SelectedPersonId as String
                //vc.childName = self.SelectedPersonFullName as String
                
                vc.showNavigationBar = true
                
            }
        }
        
       else if (segue.identifier == "TimeStamps_Delete") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                 vc.Purpose = "TimeStamps_Delete"
                
            }
        }
        
       else if (segue.identifier == "TimeStamps_Search") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_Search"
                
            }
        }
        
       else if (segue.identifier == "TimeStamps_ExtraMinutesFinder") {
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.successSegueIdentifier = "GoToCalendar"
                vc.Purpose = "TimeStamps_ExtraMinutesFinder"

                
            }
        }
        
       else if (segue.identifier == "GoToMainMenu") {
            
            //Settings the menu details.
            
            
            // if let navController = segue.destination as? UINavigationController {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .MainMenu
                
            }
            
        }
        
            
        }
    
    
}
