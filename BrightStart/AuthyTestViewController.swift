//
//  AuthyTestViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AuthyTestViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var TokenContainer: UIView!
    @IBOutlet weak var MainContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var TokeTextBox: UITextField!
    
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    @IBOutlet weak var TickImage: UIImageView!
    
    @IBOutlet weak var WaitingLabel: UILabel!
    
    @IBOutlet weak var DoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //Styling button
        DoneButton.layer.cornerRadius = 5
        DoneButton.layer.borderWidth = 1
        DoneButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        DoneButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        DoneButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)

        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        TokenContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        MainContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        
        setupConstraints()

        // Do any additional setup after loading the view.
    }

    func setupConstraints() {
        
        //Positioning the left subview
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        TokenContainer.translatesAutoresizingMaskIntoConstraints = false
        MainContainer.translatesAutoresizingMaskIntoConstraints = false
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        PhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        TokeTextBox.translatesAutoresizingMaskIntoConstraints = false
        Spinner.translatesAutoresizingMaskIntoConstraints = false
        TickImage.translatesAutoresizingMaskIntoConstraints = false
        WaitingLabel.translatesAutoresizingMaskIntoConstraints = false
        DoneButton.translatesAutoresizingMaskIntoConstraints = false
       
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
            multiplier: 0.15).isActive = true
        
        //Y
        PhoneNumberLabel.centerYAnchor.constraint(
            equalTo: TopContainer.centerYAnchor).isActive = true
        
        //X
        PhoneNumberLabel.centerXAnchor.constraint(
            equalTo: TopContainer.centerXAnchor).isActive = true
        
        //Token Container
        
        //Top
        TokenContainer.topAnchor.constraint(
            equalTo: TopContainer.bottomAnchor).isActive = true
        
        //left
        TokenContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        TokenContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //height
        TokenContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.15).isActive = true
        
        //Y
        TokeTextBox.centerYAnchor.constraint(
            equalTo: TokenContainer.centerYAnchor).isActive = true
        
        //X
        TokeTextBox.centerXAnchor.constraint(
            equalTo: TokenContainer.centerXAnchor).isActive = true
        
        TokeTextBox.widthAnchor.constraint(
            equalTo: TokenContainer.widthAnchor, multiplier: 0.75).isActive = true

        
        //Main Container
        
        //Top
        MainContainer.topAnchor.constraint(
            equalTo: TokenContainer.bottomAnchor).isActive = true
        
        //left
        MainContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        MainContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        //height
        MainContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.50).isActive = true
        
        //Y
        Spinner.centerYAnchor.constraint(
            equalTo: MainContainer.centerYAnchor).isActive = true
        
        //X
        Spinner.centerXAnchor.constraint(
            equalTo: MainContainer.centerXAnchor).isActive = true
        
        //Y
        TickImage.centerYAnchor.constraint(
            equalTo: MainContainer.centerYAnchor).isActive = true
        
        //X
        TickImage.centerXAnchor.constraint(
            equalTo: MainContainer.centerXAnchor).isActive = true

        //Top
        WaitingLabel.topAnchor.constraint(
            equalTo: Spinner.bottomAnchor, constant: 10).isActive = true
        
        //Y
        WaitingLabel.centerXAnchor.constraint(
            equalTo: Spinner.centerXAnchor).isActive = true
        
        //Bottom Container
        
        //Top
        BottomContainer.topAnchor.constraint(
            equalTo: MainContainer.bottomAnchor).isActive = true
        
        //Top
        BottomContainer.bottomAnchor.constraint(
            equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        //left
        BottomContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //right
        BottomContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true

        
        //Y
        DoneButton.centerYAnchor.constraint(
            equalTo: BottomContainer.centerYAnchor).isActive = true
        
        //X
        DoneButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        DoneButton.widthAnchor.constraint(
            equalTo: BottomContainer.widthAnchor, multiplier: 0.50).isActive = true
        
        
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
