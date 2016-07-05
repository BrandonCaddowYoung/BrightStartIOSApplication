//
//  FrontPageController.swift
//  BrightStart
//
//  Created by dev on 18/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class FrontPageController: UIViewController {
  
    
    @IBOutlet weak var nurserySchoolIdTextField: UITextField!
    
    @IBAction func nurserySchoolIdEditEnd(sender: AnyObject) {
        
        print("2. Need to confirm the nurssery school Id here!")
        
        performSegueWithIdentifier("AccessGrantedSegue", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("Closing keyboard")
        
        self.view.endEditing(true)
        return false
    }
    
}
