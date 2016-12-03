//
//  SignInViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 03/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var spacerMiddleTopView: UIView!
    
    @IBOutlet weak var spacerMiddleMiddleView: UIView!
    
    @IBOutlet weak var spacerMiddleBottomView: UIView!
    
    @IBOutlet weak var logoImaveView: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIImageView!
    @IBOutlet weak var signInButtonLabl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupConstraints()
    }

    func setupConstraints() {
        
        //BOTTOM VIEW
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        bottomView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        bottomView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //bottom
        bottomView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -20).isActive = true
        // no top
        
        //height
        bottomView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //IMAGE WITHIN BOTTOM VIEW
        
        //Sign in button and label
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButtonLabl.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.widthAnchor.constraint(
            equalTo: bottomView.widthAnchor,
            multiplier: 0.20).isActive = true
        
        signInButton.heightAnchor.constraint(
            equalTo: bottomView.heightAnchor,
            multiplier: 0.30).isActive = true
        
        
        signInButton.topAnchor.constraint(
            equalTo: middleView.bottomAnchor).isActive = true
        
        signInButton.trailingAnchor.constraint(
            equalTo: passwordTextField.trailingAnchor).isActive = true
        
        //Making sure the label is attached to the button(underneath)
        signInButtonLabl.topAnchor.constraint(
            equalTo: signInButton.bottomAnchor).isActive = true
        
        signInButtonLabl.centerXAnchor.constraint(
            equalTo: signInButton.centerXAnchor).isActive = true

        //Setting height and width of the sign in button
        
        signInButton.heightAnchor.constraint(
            equalTo: bottomView.heightAnchor,
            multiplier: 0.25).isActive = true
        
        signInButton.widthAnchor.constraint(
            equalTo: bottomView.widthAnchor,
            multiplier: 0.10).isActive = true

        

        
        
        
        
        //MIDDLE VIEW
        
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        middleView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        middleView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //bottom
        middleView.bottomAnchor.constraint(
            equalTo: bottomView.topAnchor).isActive = true
    
        //no top
        
        //height
        middleView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.50).isActive = true
        
        //TEXT INPUT FIELDS WITHIN MIDDLE VIEW
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        //Setting up the MIDDLE spacer views
        
        spacerMiddleTopView.translatesAutoresizingMaskIntoConstraints = false
        spacerMiddleMiddleView.translatesAutoresizingMaskIntoConstraints = false
        spacerMiddleBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //TOP SPACER
        
        //left
        spacerMiddleTopView.leadingAnchor.constraint(
            equalTo: middleView.leadingAnchor).isActive = true
        //right
        spacerMiddleTopView.trailingAnchor.constraint(
            equalTo: middleView.trailingAnchor).isActive = true
        //top
        spacerMiddleTopView.bottomAnchor.constraint(
            equalTo: middleView.topAnchor
           ).isActive = true
        
        //height
        spacerMiddleTopView.heightAnchor.constraint(
            equalTo: middleView.heightAnchor,
            multiplier: 0.10).isActive = true

        
        
        //MIDDLE SPACER
        
        //left
        spacerMiddleMiddleView.leadingAnchor.constraint(
            equalTo: middleView.leadingAnchor).isActive = true
        //right
        spacerMiddleMiddleView.trailingAnchor.constraint(
            equalTo: middleView.trailingAnchor).isActive = true
        
        spacerMiddleMiddleView.centerYAnchor.constraint(
            equalTo: middleView.centerYAnchor).isActive = true
        
        //height
        spacerMiddleMiddleView.heightAnchor.constraint(
            equalTo: middleView.heightAnchor,
            multiplier: 0.10).isActive = true

        
        //BOTTOM SPACER
        
        
        //left
        spacerMiddleBottomView.leadingAnchor.constraint(
            equalTo: middleView.leadingAnchor).isActive = true
        //right
        spacerMiddleBottomView.trailingAnchor.constraint(
            equalTo: middleView.trailingAnchor).isActive = true
        
        //bottom
        spacerMiddleBottomView.bottomAnchor.constraint(
            equalTo: middleView.bottomAnchor
            ).isActive = true
        
        //height
        spacerMiddleBottomView.heightAnchor.constraint(
            equalTo: middleView.heightAnchor,
            multiplier: 0.10).isActive = true



        
        
        
        
        
        //Center all text input and labels horizontally
        
        usernameLabel.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
        passwordLabel.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
        
        
        //USER TEXT FIELD
        
        //bottom
        usernameTextField.bottomAnchor.constraint(
            equalTo: spacerMiddleMiddleView.topAnchor
            ).isActive = true
        
        //width
        usernameTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true

        //USER LABEL
        
        //bottom
        usernameLabel.bottomAnchor.constraint(
            equalTo: usernameTextField.topAnchor
            ).isActive = true
        
        //left
        usernameLabel.leftAnchor.constraint(
            equalTo: usernameTextField.leftAnchor
            ).isActive = true
        
        //PASSWORD TEXT LABEL
        
        //top
        passwordLabel.topAnchor.constraint(
            equalTo: spacerMiddleMiddleView.bottomAnchor
            ).isActive = true
        
        
        //PASSSWORD TEXT FIELD
        
        //top
        passwordTextField.topAnchor.constraint(
            equalTo: passwordLabel.bottomAnchor
            ).isActive = true
        
        
        passwordTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true

        //top
        passwordLabel.leftAnchor.constraint(
            equalTo: passwordTextField.leftAnchor
            ).isActive = true
        
        
        
        
        //TOP VIEW
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        topView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        topView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //bottom
        topView.bottomAnchor.constraint(
            equalTo: middleView.topAnchor).isActive = true
        //top
        //topView.topAnchor.constraint(
          //  equalTo: view.topAnchor,
            //constant: -20).isActive = true
        
        //height
        topView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //IMAGE WITHIN TOP VIEW
        
        logoImaveView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImaveView.centerXAnchor.constraint(
            equalTo: topView.centerXAnchor).isActive = true
        logoImaveView.centerYAnchor.constraint(
            equalTo: topView.centerYAnchor).isActive = true
        
        logoImaveView.widthAnchor.constraint(
            equalTo: topView.widthAnchor).isActive = true
        
        logoImaveView.heightAnchor.constraint(
            equalTo: topView.heightAnchor).isActive = true
        
        
        
        
        
        
        
        
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
