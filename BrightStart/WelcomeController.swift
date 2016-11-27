//
//  WelcomeController.swift
//  BrightStart
//
//  Created by dev on 16/04/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    
    @IBOutlet weak var nurserySchoolIdTextField: UITextField!
    
    
    @IBAction func goToRegisterButton(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "AccessGrantedSegue", sender: self)
        
    }
    
    @IBAction func nurserySchoolIdEditEnd(_ sender: AnyObject) {
        
        print("Need to confirm the nurssery school Id here!")
        
        performSegue(withIdentifier: "AccessGrantedSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        
        // Receive
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            nurserySchoolIdTextField.text = id;
            
           print("Found a nursery school id and it is: ")
            print(id)
        }
        else
        {
            print("Not found a nursery school id")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("Closing keyboard")
        
        self.view.endEditing(true)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "AccessGrantedSegue") {
            
            let defaults = UserDefaults.standard
            
            print("Storing the following id in the storage: " + nurserySchoolIdTextField.text!)
            
            // Store
            defaults.set(nurserySchoolIdTextField.text!, forKey: "NurserySchoolId")
            
        }
    }
    
}
