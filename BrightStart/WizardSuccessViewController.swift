//
//  DoubleTemplateViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 21/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class WizardSuccessViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var SuccessLabel: UILabel!
    
    @IBOutlet weak var UpperContent: UIView!
    
    @IBOutlet weak var SuccessImage: UIImageView!
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var OKButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        Top.backgroundColor = _ApplicatoinColours.BackGroundColour
        UpperHeading.backgroundColor = _ApplicatoinColours.BackGroundColour
        UpperContent.backgroundColor = _ApplicatoinColours.BackGroundColour
        Bottom.backgroundColor = _ApplicatoinColours.BackGroundColour
       
        self.SuccessImage?.image = UIImage(named: "Rocket")?.maskWithColor(color: _ApplicatoinColours.White)
        
        SuccessLabel.text = "That was succesful!!"
        
        SuccessLabel.font = _ApplicatoinColours.largeFont
        SuccessLabel.textColor = _ApplicatoinColours.White
       
        OKButton.setTitleColor(_ApplicatoinColours.Orange, for: UIControlState.normal)
    }
    
    func setupConstraints() {
        
        //Top
        
        Top.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Top.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Top.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        Top.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //height
        Top.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //Upper Heading
        
        UpperHeading.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperHeading.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperHeading.topAnchor.constraint(
            equalTo: Top.bottomAnchor).isActive = true
        
        //height
        UpperHeading.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        SuccessLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        SuccessLabel.centerXAnchor.constraint(
            equalTo: UpperHeading.centerXAnchor).isActive = true
        
        SuccessLabel.centerYAnchor.constraint(
            equalTo: UpperHeading.centerYAnchor).isActive = true

        //Bottom
        
        Bottom.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Bottom.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        Bottom.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        Bottom.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //height
        Bottom.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        //Upper Content
        
        UpperContent.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        UpperHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        UpperContent.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //top
        UpperContent.topAnchor.constraint(
            equalTo: UpperHeading.bottomAnchor).isActive = true
        
        //height
        UpperContent.bottomAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        SuccessImage.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        SuccessImage.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        SuccessImage.centerYAnchor.constraint(
            equalTo: UpperContent.centerYAnchor).isActive = true

        
        OKButton.translatesAutoresizingMaskIntoConstraints = false
        
        OKButton.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        OKButton.topAnchor.constraint(
            equalTo: SuccessImage.bottomAnchor).isActive = true
        
        OKButton.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.50).isActive = true
        
        OKButton.heightAnchor.constraint(
            equalTo: UpperContent.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OkTapped(_ sender: Any) {
         self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "GoToMenu") {
            if let vc = segue.destination as? MainMenuViewController {
                
                //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
                vc.selectedMenu = .MainMenu
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
