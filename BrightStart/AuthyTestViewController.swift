//
//  AuthyTestViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AuthyTestViewController: UIViewController, UITextFieldDelegate {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var timer = Timer()
    
    var uuid :NSString!
    
    var successSegueIdentifier :NSString!
    
    var targetChildId :NSString!
    
     var targetAuthyId :NSString!
    var numberOfSeconsToWait: Int!
    
    var selectedAuthyAction = AuhtyActions.ShouldDoNothing
    
    var targetAuthyUser = AuthyUser()
    
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
        
        WaitingLabel.isHidden = true;
        
        self.TokeTextBox.delegate = self
        
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
        
        
        AuthyRequests.sharedInstance.GetAuhtyUser(auhtyId: targetAuthyId as String, onCompletion:
            { json in
                
                for (index: _, subJson: JSON) in json {
                    
                    self.targetAuthyUser.CountryCode = JSON["CountryCode"].stringValue as NSString
                    self.targetAuthyUser.PhoneNumber = JSON["PhoneNumber"].stringValue as NSString
                    self.targetAuthyUser.Relationship = JSON["Relationship"].stringValue as NSString
                    self.targetAuthyUser.ChildId = JSON["ChildId"].stringValue as NSString
                    self.targetAuthyUser.Email = JSON["Email"].stringValue as NSString
                    self.targetAuthyUser.Name = JSON["Name"].stringValue as NSString
                    //targetAuthyUser.IsDisabled = JSON["targetAuthyUser.IsDisabled"].stringValue as NSString
                    
                }
                
                DispatchQueue.main.async(execute: {
                    
                   
                    
                })
                
    })
        
        PhoneNumberLabel.text = targetAuthyUser.PhoneNumber as String
        
        AuthyRequests.sharedInstance.SendOneTouchRequest(authyId: targetAuthyId as String, onCompletion:  { json in
            
            self.uuid = json.rawString() as NSString!
        
        DispatchQueue.main.async(execute: {
        
             self.Spinner.isHidden = false
          self.Spinner.startAnimating()
            self.WaitingLabel.isHidden = false;
            self.TickImage.isHidden = true
        
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AuthyTestViewController.checkForUsersAcceptance), userInfo: nil, repeats: true)
            
         })
        
         })
        
    }
    
    func checkForUsersAcceptance()
    {
        
        if(numberOfSeconsToWait<1)
        {
            self.Spinner.isHidden = true
            self.Spinner.stopAnimating()
            self.timer.invalidate()
            self.WaitingLabel.text = "Sorry you took too long confirming."
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                self.performSegue(withIdentifier: self.successSegueIdentifier as String, sender: self)
            })
            
        }
        
        AuthyRequests.sharedInstance.HasOneTouchBeenApproved(uuid: uuid as String, onCompletion:  { json in
            
            let approved = json.rawString() as NSString!
            
                DispatchQueue.main.async(execute: {
                    
                    if(approved=="true")
                    {
                        self.Spinner.isHidden = true
                        self.Spinner.stopAnimating()
                        self.timer.invalidate()
                        self.WaitingLabel.text = "Fantastic. That worked."
                        
                        self.onSuccss()
                        
                    }
                    
                })
        })
    
        numberOfSeconsToWait = numberOfSeconsToWait - 1
        
    }

    
    func onSuccss()
    {
        if(selectedAuthyAction == .ShouldSignOut){
    
        let alert = self._CommonHelper.showOverlayMessage("Signing out...")
        self.present(alert, animated: true, completion: nil)
        
        CommonRequests.sharedInstance.signOut(personId: targetChildId as String, timeOfSignOut: Date() as NSDate,
                                              
                                              onCompletion: {
                                                
                                                DispatchQueue.main.async(execute: {
                                                    
                                                    self.dismiss(animated: false, completion:
                                                        {self.performSegue(withIdentifier: "GoToRegister", sender: self)
                                                    }
                                                    )
                                                    
                                                    
                                                    
                                                    
                                                    
                                                })
                                                
        })

        }
        else if(selectedAuthyAction == AuhtyActions.ShouldSignIn){
        
            let alert = self._CommonHelper.showOverlayMessage("Signing in...")
            self.present(alert, animated: true, completion: nil)
            
            CommonRequests.sharedInstance.signIn(personId: targetChildId as String, timeOfSignIn: Date() as NSDate,
                                                 onCompletion: {
                                                    DispatchQueue.main.async(execute: {
                                                        
                                                        self.dismiss(animated: false, completion:
                                                            {self.performSegue(withIdentifier: "GoToRegister", sender: self)
                                                        }
                                                        )
                                                        
                                                    })
            }
            )
        
        }
    
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        //textField code
        
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        
        AuthyRequests.sharedInstance.ValidateToken(auhtyId: targetAuthyId as String, token: TokeTextBox.text!, onCompletion:  { json in
            
            let approved = json.rawString() as NSString!
            
            DispatchQueue.main.async(execute: {
                
                if(approved=="true")
                {
                    self.Spinner.isHidden = true
                    self.Spinner.stopAnimating()
                    self.timer.invalidate()
                    self.WaitingLabel.text = "Fantastic. That worked."
                }
                
            })
            
        })
        
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
    
    
    
    @IBAction func OKButtonclick(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToMainMenu", sender: self)

    }
    

    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

        
        if (segue.identifier == "GoToMainMenu") {
            
            //Settings the menu details.
            
            
            // if let navController = segue.destination as? UINavigationController {
            
            if let vc = segue.destination as? MainMenuViewController {
                
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
