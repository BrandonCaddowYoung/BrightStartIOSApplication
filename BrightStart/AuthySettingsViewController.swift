//
//  AuthySettingsViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 05/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AuthySettingsViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!

    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var MiddleContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    @IBOutlet weak var ContentContainer: UIView!
    
    @IBOutlet weak var Top: UIView!
    @IBOutlet weak var Middle: UIView!
    @IBOutlet weak var Bottom: UIView!
    
    @IBOutlet weak var OkButton: UIButton!

    @IBOutlet weak var OnSignInLabel: UILabel!
    @IBOutlet weak var UseAuthyLabel: UILabel!
    @IBOutlet weak var OnSignOutLabel: UILabel!
    
    @IBOutlet weak var UseAuthySwitch: UISwitch!
    @IBOutlet weak var OnSignInSwitch: UISwitch!
    @IBOutlet weak var OnSignOutSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //Styling button
        OkButton.layer.cornerRadius = 5
        OkButton.layer.borderWidth = 1
        OkButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        OkButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        OkButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
         ContentContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        Top.backgroundColor = _ApplicatoinColours.BackGroundColour
        Middle.backgroundColor = _ApplicatoinColours.BackGroundColour
        Bottom.backgroundColor = _ApplicatoinColours.BackGroundColour
        
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
        
        ContentContainer.translatesAutoresizingMaskIntoConstraints = false
        

        
        OkButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        OnSignInLabel.translatesAutoresizingMaskIntoConstraints = false
        UseAuthyLabel.translatesAutoresizingMaskIntoConstraints = false
        OnSignOutLabel.translatesAutoresizingMaskIntoConstraints = false
        UseAuthySwitch.translatesAutoresizingMaskIntoConstraints = false
        OnSignInSwitch.translatesAutoresizingMaskIntoConstraints = false
        OnSignOutSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        
        Top.translatesAutoresizingMaskIntoConstraints = false
        Middle.translatesAutoresizingMaskIntoConstraints = false
        Bottom.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        
        
        //Content
        
        //left
        ContentContainer.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Right
        ContentContainer.centerYAnchor.constraint(
            equalTo: MiddleContainer.centerYAnchor).isActive = true
        
        //width
        ContentContainer.widthAnchor.constraint(
            equalTo: MiddleContainer.widthAnchor,
            multiplier: 0.60).isActive = true

        
        //height
        ContentContainer.heightAnchor.constraint(
            equalTo: MiddleContainer.heightAnchor,
            multiplier: 0.70).isActive = true
        
        
        
        
        //Top
        
        //left
        Top.leadingAnchor.constraint(
            equalTo: ContentContainer.leadingAnchor).isActive = true
        
        //right
        Top.trailingAnchor.constraint(
            equalTo: ContentContainer.trailingAnchor).isActive = true
        
        //right
        Top.topAnchor.constraint(
            equalTo: ContentContainer.topAnchor).isActive = true
        
        //height
        Top.heightAnchor.constraint(
            equalTo: ContentContainer.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //Use Authy
        
        //left
        UseAuthyLabel.leadingAnchor.constraint(
            equalTo: Top.leadingAnchor).isActive = true
        
        //top
        UseAuthyLabel.topAnchor.constraint(
            equalTo: Top.topAnchor).isActive = true
        
       
        //Use Authy Switch
        
        //right
        UseAuthySwitch.trailingAnchor.constraint(
            equalTo: Top.trailingAnchor).isActive = true
        
        //top
        UseAuthySwitch.topAnchor.constraint(
            equalTo: Top.topAnchor).isActive = true
        
        
        
        
        
        
        //Middle
        
        //left
        Middle.leadingAnchor.constraint(
            equalTo: ContentContainer.leadingAnchor).isActive = true
        
        //right
        Middle.trailingAnchor.constraint(
            equalTo: ContentContainer.trailingAnchor).isActive = true
        
        //Y
        Middle.centerYAnchor.constraint(
            equalTo: ContentContainer.centerYAnchor).isActive = true
        
        //height
        Middle.heightAnchor.constraint(
            equalTo: ContentContainer.heightAnchor,
            multiplier: 0.20).isActive = true
        
        
        //Use Authy
        
        //left
        OnSignInLabel.leadingAnchor.constraint(
            equalTo: Middle.leadingAnchor).isActive = true
        
        //top
        OnSignInLabel.topAnchor.constraint(
            equalTo: Middle.topAnchor).isActive = true
        
        
        //Use Authy Switch
        
        //right
        OnSignInSwitch.trailingAnchor.constraint(
            equalTo: Middle.trailingAnchor).isActive = true
        
        //top
        OnSignInSwitch.topAnchor.constraint(
            equalTo: Middle.topAnchor).isActive = true

        
        
        
        
        
        
        
        //Bottom
        
        //left
        Bottom.leadingAnchor.constraint(
            equalTo: ContentContainer.leadingAnchor).isActive = true
        
        //right
        Bottom.widthAnchor.constraint(
            equalTo: ContentContainer.widthAnchor).isActive = true
        
        //right
        Bottom.bottomAnchor.constraint(
            equalTo: ContentContainer.bottomAnchor).isActive = true
        
        //height
        Bottom.heightAnchor.constraint(
            equalTo: ContentContainer.heightAnchor,
            multiplier: 0.20).isActive = true
        
        
        Bottom.centerXAnchor.constraint(
            equalTo: ContentContainer.centerXAnchor).isActive = true
        
        
        //Use Authy
        
        //left
        OnSignOutLabel.leadingAnchor.constraint(
            equalTo: Bottom.leadingAnchor).isActive = true
        
        //top
        OnSignOutLabel.topAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        
        //Use Authy Switch
        
        //right
        OnSignOutSwitch.trailingAnchor.constraint(
            equalTo: Bottom.trailingAnchor).isActive = true
        
        //top
        OnSignOutSwitch.topAnchor.constraint(
            equalTo: Bottom.topAnchor).isActive = true
        
        
        
        
        
        
        
        
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
        
        
        //OK Button
        
        //X
        OkButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        //Y
        OkButton.centerYAnchor.constraint(
            equalTo: BottomContainer.centerYAnchor).isActive = true
        
        OkButton.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        
        
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
