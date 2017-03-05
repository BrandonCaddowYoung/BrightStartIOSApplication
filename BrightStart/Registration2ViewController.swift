//
//  Registration2ViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 07/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class Registration2ViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var registration: RegistrationModel!
    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var MiddleContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    @IBOutlet weak var FooterContainer: UIView!
    
    @IBOutlet weak var HeaderLabel: UILabel!
    @IBOutlet weak var SubHeaderLabl: UILabel!
    
    @IBOutlet weak var NurseryNameTextField: UITextField!
    @IBOutlet weak var ManagerNameTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    
    
    @IBOutlet weak var FinishedButton: UIButton!
    
    @IBOutlet weak var FooterLabel: UILabel!
    override func viewDidLoad() {
        
        registration = RegistrationModel()
        
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //Styling button
        FinishedButton.layer.cornerRadius = 5
        FinishedButton.layer.borderWidth = 1
        FinishedButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        FinishedButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        FinishedButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        FinishedButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        FooterContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        SubHeaderLabl.textAlignment = NSTextAlignment.center;
        SubHeaderLabl.numberOfLines = 0;
        SubHeaderLabl.font = UIFont.systemFont(ofSize: 16.0);
        SubHeaderLabl.text = "Just a few more details and you'l be set!";
        
        
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupConstraints() {
        
        //Positioning the left subview
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        MiddleContainer.translatesAutoresizingMaskIntoConstraints = false
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        FooterContainer.translatesAutoresizingMaskIntoConstraints = false
        
        HeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        SubHeaderLabl.translatesAutoresizingMaskIntoConstraints = false
        NurseryNameTextField.translatesAutoresizingMaskIntoConstraints = false
        ManagerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        PhoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        FinishedButton.translatesAutoresizingMaskIntoConstraints = false
        FooterLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            multiplier: 0.25).isActive = true
        
        //Heading label
        
        //top
        HeaderLabel.bottomAnchor.constraint(
            equalTo: TopContainer.bottomAnchor, constant: -10).isActive = true
        
        //top
        HeaderLabel.centerXAnchor.constraint(
            equalTo: TopContainer.centerXAnchor).isActive = true
        
        
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
            multiplier: 0.25).isActive = true
        
        //Sub label
        
        //top
        SubHeaderLabl.topAnchor.constraint(
            equalTo: MiddleContainer.topAnchor, constant:10).isActive = true
        
        //top
        SubHeaderLabl.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        SubHeaderLabl.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
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
            equalTo: FooterContainer.topAnchor).isActive = true
        
        //height
        BottomContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.40).isActive = true
        
        
        //email text field
        
        NurseryNameTextField.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        NurseryNameTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.50).isActive = true
        
        NurseryNameTextField.topAnchor.constraint(
            equalTo: BottomContainer.topAnchor).isActive = true
        
        //Password
        
        ManagerNameTextField.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        ManagerNameTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.50).isActive = true
        
        ManagerNameTextField.topAnchor.constraint(
            equalTo: NurseryNameTextField.bottomAnchor, constant: 10).isActive = true
        
        //Confirm
        
        PhoneNumberTextField.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        PhoneNumberTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.50).isActive = true
        
        PhoneNumberTextField.topAnchor.constraint(
            equalTo: ManagerNameTextField.bottomAnchor, constant: 10).isActive = true
        
        //Confirm
        
        FinishedButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        FinishedButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.50).isActive = true
        
        FinishedButton.topAnchor.constraint(
            equalTo: PhoneNumberTextField.bottomAnchor, constant: 10).isActive = true
        
        //Footer
        
        //left
        FooterContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //Right
        FooterContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //top
        FooterContainer.topAnchor.constraint(
            equalTo: BottomContainer.bottomAnchor).isActive = true
        
        //top
        FooterContainer.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true
        
        //Footer label
        
        //top
        FooterLabel.bottomAnchor.constraint(
            equalTo: FooterContainer.bottomAnchor, constant:-10).isActive = true
        
        //top
        FooterLabel.centerXAnchor.constraint(
            equalTo: FooterContainer.centerXAnchor).isActive = true
    }
    
   
    @IBAction func FinishClicked(_ sender: Any) {
        
      registration.nurserySchoolName = NurseryNameTextField.text!
        
        
        RegistrationRequests.sharedInstance.CreateNewNurserySchoolFromScratch(nurserySchoolName: registration.nurserySchoolName, managerName: registration.managerName, nurserySchoolPhoneNumber: registration.nurserySchoolPhoneNumber, username: registration.username, password: registration.password, onCompletion: { json in
            
            //Should get the authy id back from this create call.
            //Pass authy id into the new view incase the user wants to do a test.
            
            DispatchQueue.main.async(execute: {
                
                self.performSegue(withIdentifier: "GoToSignIn", sender: self)
                
            })
            
        })
        
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
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
