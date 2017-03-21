//
//  DoubleTemplateViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 21/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class CreateChild_Quick_1ViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var Top: UIView!
    
    @IBOutlet weak var HeadingLabel: UILabel!
    
    @IBOutlet weak var UpperHeading: UIView!
    
    @IBOutlet weak var UpperContent: UIView!
    
    @IBOutlet weak var Middle: UIView!
    
    @IBOutlet weak var LowerHeading: UIView!
    
    @IBOutlet weak var LowerContent: UIView!
    
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var MiddleNameTextField: UITextField!
    
    @IBOutlet weak var LastNameTextField: UITextField!
    
    @IBOutlet weak var DateOfBirthLabel: UILabel!
    
    @IBOutlet weak var DateOfBirthDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        self.hideKeyboardWhenTappedAround()
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        setupConstraints()
        
        Top.backgroundColor = _ApplicatoinColours.White
        
        UpperHeading.backgroundColor = _ApplicatoinColours.White
        
        UpperContent.backgroundColor = _ApplicatoinColours.White
        
        Middle.backgroundColor = _ApplicatoinColours.White
        
        LowerHeading.backgroundColor = _ApplicatoinColours.White
        
        LowerContent.backgroundColor = _ApplicatoinColours.White
        
        Bottom.backgroundColor = _ApplicatoinColours.White
    }
    
    
    func setupConstraints() {
        
        
        //Middle
        
        Middle.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        Middle.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        
        Middle.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //height
        Middle.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.01).isActive = true
        
        
        
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
        
        
        //Heading label
        
        HeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        HeadingLabel.centerYAnchor.constraint(
            equalTo: Top.centerYAnchor).isActive = true
        
        //center
        HeadingLabel.trailingAnchor.constraint(
            equalTo: Top.trailingAnchor, constant: -15).isActive = true
        
        HeadingLabel.widthAnchor.constraint(
            equalTo: Top.widthAnchor, multiplier: 0.70).isActive = true
        
        HeadingLabel.textAlignment = .right
       
        HeadingLabel.adjustsFontSizeToFitWidth = true
        
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
        
        //Name Label
        
        NameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        NameLabel.centerYAnchor.constraint(
           equalTo: UpperHeading.centerYAnchor).isActive = true
        
        //width
        NameLabel.widthAnchor.constraint(
            equalTo: UpperHeading.widthAnchor).isActive = true
        
        //left
        NameLabel.leadingAnchor.constraint(
            equalTo: UpperHeading.leadingAnchor, constant: 20 ).isActive = true
        
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
            equalTo: Middle.topAnchor).isActive = true
        
        
        //First Name
        
        FirstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        FirstNameTextField.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        //width
        FirstNameTextField.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.70).isActive = true
        
        //top
        FirstNameTextField.topAnchor.constraint(
            equalTo: UpperContent.topAnchor, constant: 15).isActive = true
        
        //height
        FirstNameTextField.heightAnchor.constraint(
            equalTo: UpperContent.heightAnchor, multiplier: 0.15).isActive = true
        
        //Middle Name
        
        MiddleNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        MiddleNameTextField.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        //width
        MiddleNameTextField.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.70).isActive = true
        
        //top
        MiddleNameTextField.topAnchor.constraint(
            equalTo: FirstNameTextField.bottomAnchor, constant: 15).isActive = true
        
        //height
        MiddleNameTextField.heightAnchor.constraint(
            equalTo: UpperContent.heightAnchor, multiplier: 0.15).isActive = true
        
        //Bottom Name
        
        LastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LastNameTextField.centerXAnchor.constraint(
            equalTo: UpperContent.centerXAnchor).isActive = true
        
        //width
        LastNameTextField.widthAnchor.constraint(
            equalTo: UpperContent.widthAnchor, multiplier: 0.70).isActive = true
        
        //top
        LastNameTextField.topAnchor.constraint(
            equalTo: MiddleNameTextField.bottomAnchor, constant: 15).isActive = true
        
        //height
        FirstNameTextField.heightAnchor.constraint(
            equalTo: UpperContent.heightAnchor, multiplier: 0.15).isActive = true
        
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
        
        //Lower Heading
        
        LowerHeading.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LowerHeading.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        LowerHeading.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        LowerHeading.topAnchor.constraint(
            equalTo: Middle.bottomAnchor).isActive = true
        
        //height
        LowerHeading.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        
        //DOB Label
        
        DateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        DateOfBirthLabel.centerYAnchor.constraint(
            equalTo: LowerHeading.centerYAnchor).isActive = true
        
        //width
        DateOfBirthLabel.widthAnchor.constraint(
            equalTo: LowerHeading.widthAnchor).isActive = true
        
        //left
        DateOfBirthLabel.leadingAnchor.constraint(
            equalTo: LowerHeading.leadingAnchor, constant: 20 ).isActive = true
        
        
        //Lower Content
        
        LowerContent.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        LowerContent.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        //width
        LowerContent.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        //bottom
        LowerContent.bottomAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        //top
        LowerContent.topAnchor.constraint(
            equalTo: LowerHeading.bottomAnchor).isActive = true
        
        //DOB Picker
        
        DateOfBirthDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        DateOfBirthDatePicker.widthAnchor.constraint(
            equalTo: LowerContent.widthAnchor).isActive = true
        
        DateOfBirthDatePicker.heightAnchor.constraint(
            equalTo: LowerContent.heightAnchor).isActive = true
        
        //center
        DateOfBirthDatePicker.centerXAnchor.constraint(
            equalTo: LowerContent.centerXAnchor).isActive = true
        
        DateOfBirthDatePicker.centerYAnchor.constraint(
            equalTo: LowerContent.centerYAnchor).isActive = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
