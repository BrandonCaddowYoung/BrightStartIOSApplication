//
//  TimeStampsMenuController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 24/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class TimeStampsMenuController: MainMenuViewController {

    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToSearchPerson_Edit") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.OptionText = "Edit time stmaps."
                
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Delete") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.OptionText = "Delete time stamps."
                
            }
        }
        
        if (segue.identifier == "GoToSearchPerson_Search") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.OptionText = "Search for time stamps."
                
            }
        }

        if (segue.identifier == "GoToSearchPerson_Missing") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.OptionText = "Search for missing time stamps."
                
            }
        }
        

        

        
    }
    
    
}
