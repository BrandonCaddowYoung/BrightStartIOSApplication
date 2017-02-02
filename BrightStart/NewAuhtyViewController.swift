//
//  NewAuhtyViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class NewAuhtyViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var TopContainer: UIView!
    
    @IBOutlet weak var MiddleContainer: UIView!
    
    
    @IBOutlet weak var NameTextBox: UITextField!
    
    @IBOutlet weak var RelationshipTextBox: UITextField!
    
    @IBOutlet weak var MobileNumberTextBox: UITextField!
    
    @IBOutlet weak var CountryCodeTextBox: UITextField!
    
    @IBOutlet weak var EmailAddresTextBox: UITextField!
    
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var SubmitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //Styling button
        SubmitButton.layer.cornerRadius = 5
        SubmitButton.layer.borderWidth = 1
        SubmitButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        SubmitButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SubmitButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)

        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
         setupConstraints()
        
        // Do any additional setup after loading the view.
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
    
    
    /*!
     @brief Sets up all constraints for the view.
     */
    func setupConstraints() {
        
        //Positioning the left subview
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        MiddleContainer.translatesAutoresizingMaskIntoConstraints = false
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        NameTextBox.translatesAutoresizingMaskIntoConstraints = false
        RelationshipTextBox.translatesAutoresizingMaskIntoConstraints = false
        MobileNumberTextBox.translatesAutoresizingMaskIntoConstraints = false
        CountryCodeTextBox.translatesAutoresizingMaskIntoConstraints = false
        EmailAddresTextBox.translatesAutoresizingMaskIntoConstraints = false
        SubmitButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        
        
        //MobileNumber text box
        
        //width
        MobileNumberTextBox.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor, multiplier: 0.60).isActive = true
        //X
        MobileNumberTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Y
        MobileNumberTextBox.centerYAnchor.constraint(
            equalTo: MiddleContainer.centerYAnchor).isActive = true
        
       
        //Relationship text box
        
        //width
        RelationshipTextBox.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor, multiplier: 0.60).isActive = true
        
        //Bottom
        RelationshipTextBox.bottomAnchor.constraint(
            equalTo: MobileNumberTextBox.topAnchor, constant: -10).isActive = true
        
        //X
        RelationshipTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true

        //Country code
        
        //width
        CountryCodeTextBox.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor, multiplier: 0.60).isActive = true
        //Top
        CountryCodeTextBox.topAnchor.constraint(
            equalTo: MobileNumberTextBox.bottomAnchor, constant: 10).isActive = true
        
        //X
        CountryCodeTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Email addres
        
        //width
        EmailAddresTextBox.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor, multiplier: 0.60).isActive = true
        //Top
        EmailAddresTextBox.topAnchor.constraint(
            equalTo: CountryCodeTextBox.bottomAnchor, constant: 10).isActive = true
        
        //X
        EmailAddresTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Email addres
        
        //width
        NameTextBox.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor, multiplier: 0.60).isActive = true
        //bottom
        NameTextBox.bottomAnchor.constraint(
            equalTo: RelationshipTextBox.topAnchor, constant: -10).isActive = true
        
        //X
        NameTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
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
        
        //Country code
        
        //width
        SubmitButton.widthAnchor.constraint(
            equalTo: BottomContainer.widthAnchor, multiplier: 0.60).isActive = true
        //Y
        SubmitButton.centerYAnchor.constraint(
            equalTo: BottomContainer.centerYAnchor, constant: 10).isActive = true
        
        //X
        SubmitButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true

        
        
      
    }
}
