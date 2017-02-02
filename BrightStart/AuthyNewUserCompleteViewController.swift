//
//  AuthyNewUserCompleteViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AuthyNewUserCompleteViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var MiddleContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var TickImage: UIImageView!
    @IBOutlet weak var DoneLabel: UILabel!
    
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var TestButton: UIButton!
    
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
        
        //Styling button
        TestButton.layer.cornerRadius = 5
        TestButton.layer.borderWidth = 1
        TestButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        TestButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        TestButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MiddleContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
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
     
        OkButton.translatesAutoresizingMaskIntoConstraints = false
        TestButton.translatesAutoresizingMaskIntoConstraints = false
       
        TickImage.translatesAutoresizingMaskIntoConstraints = false
        DoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        //Tick
        
        //X
        TickImage.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Y
        TickImage.centerYAnchor.constraint(
            equalTo: MiddleContainer.centerYAnchor).isActive = true
       
        //Done Label
        
        //top
        DoneLabel.topAnchor.constraint(
            equalTo: TickImage.bottomAnchor).isActive = true
        
        //X
        DoneLabel.centerXAnchor.constraint(
            equalTo: TickImage.centerXAnchor).isActive = true
        
        //Test Button
        
        TopContainer.addSubview(TestButton)
        
        //X
        TestButton.centerXAnchor.constraint(
            equalTo: TopContainer.centerXAnchor).isActive = true
        
        TestButton.centerYAnchor.constraint(
            equalTo: TopContainer.centerYAnchor).isActive = true
        
        TestButton.widthAnchor.constraint(
           equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        
        
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
