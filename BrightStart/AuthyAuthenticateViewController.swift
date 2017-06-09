//
//  AuthyAuthenticateViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 12/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit
import SVProgressHUD

class AuthyAuthenticateViewController: UIViewController, UITextFieldDelegate {

     var showNavigationBar = true
    
    var shouldPerformCheck = true
    
    var timer = Timer()
    
    var uuid :NSString!
    
    var successSegueIdentifier :NSString!
    
    var targetChildId :NSString!
    
    var targetAuthyId :NSString!
    var numberOfSeconsToWait: Int!
    
    var selectedAuthyAction = AuhtyActions.ShouldDoNothing
    
    var targetAuthyUser = AuthyUser()

    
    @IBOutlet weak var CenterView: UIView!
    @IBOutlet weak var SecondstoGoLabel: UILabel!
    @IBOutlet weak var SecondsToGoLabel2: UILabel!
    @IBOutlet weak var TopLabel: UILabel!
    
    @IBOutlet weak var TopContainer: UIView!
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var TokenTextFiled: UITextField!
    @IBOutlet weak var DontHaveYourPhoneLabel: UILabel!
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SecondstoGoLabel.text = String(numberOfSeconsToWait)
        
         self.hideKeyboardWhenTappedAround()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        // Do any additional setup after loading the view.
        
        TokenTextFiled.setBottomBorder(backGroundColor: StyleManager.DarkBackground().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme2(), palceHoldertextColor: StyleManager.theme3())
        
        TokenTextFiled.delegate = self;
        
        TokenTextFiled.isHidden = true;
        
        setupConstraints()
        
        CenterView.backgroundColor = StyleManager.theme1()
        
        view.backgroundColor = StyleManager.DarkBackground()
        TopContainer.backgroundColor = StyleManager.DarkBackground()
        BottomContainer .backgroundColor = StyleManager.DarkBackground()
        
        SecondstoGoLabel.font = _ApplicatoinColours.MassiveFont
        
        SecondstoGoLabel.textColor = StyleManager.theme4()
        
        SecondsToGoLabel2.font = _ApplicatoinColours.sshmediumlFont
        SecondsToGoLabel2.textColor = StyleManager.theme5()
        
        TopLabel.font = _ApplicatoinColours.MenuFont
        TopLabel.textColor = StyleManager.FontColour()
        
        DontHaveYourPhoneLabel.font = _ApplicatoinColours.MenuFont
        DontHaveYourPhoneLabel.textColor = StyleManager.FontColour()
        DontHaveYourPhoneLabel.isHidden = true
        
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
       
        //PhoneNumberLabel.text = targetAuthyUser.PhoneNumber as String
        
        AuthyRequests.sharedInstance.SendOneTouchRequest(authyId: targetAuthyId as String, onCompletion:  { json in
            
            self.uuid = json.rawString() as NSString!
            
            DispatchQueue.main.async(execute: {
                
                self.SecondstoGoLabel.isHidden = false
                self.SecondsToGoLabel2.isHidden = false
                //self.TickImage.isHidden = true
                
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(AuthyAuthenticateViewController.checkForUsersAcceptance), userInfo: nil, repeats: true)
                
            })
            
        })

        
        
    }
    
    func checkForUsersAcceptance()
    {
        if(self.shouldPerformCheck == false){
            return;
        }
        
        SecondstoGoLabel.text = String(numberOfSeconsToWait)
        
        if(numberOfSeconsToWait<1)
        {
            self.shouldPerformCheck = false
            
            self.SecondstoGoLabel.isHidden = true
            self.SecondsToGoLabel2.isHidden = true
            //self.TickImage.isHidden = false
            
            self.timer.invalidate()
            
            //self.WaitingLabel.text = ""
            
           self._CommonHelper.ShowErrorMessage(title: "Sorry", subsTtitle: "You took too long confirming. please try again.")
            
             self.performSegue(withIdentifier: self.successSegueIdentifier as String, sender: self)
            
           // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
               
           // })
            
        }
        
        AuthyRequests.sharedInstance.HasOneTouchBeenApproved(uuid: uuid as String, onCompletion:  { json in
            
            let approved = json.rawString() as NSString!
            
            DispatchQueue.main.async(execute: {
                
                if(approved=="true")
                {
                    self.shouldPerformCheck = false
                    
                    self.SecondstoGoLabel.isHidden = true
                    self.SecondsToGoLabel2.isHidden = true
                    //self.TickImage.isHidden = false
                    
                    self.timer.invalidate()
                    
                    self.onSuccss()
                    
                }
                
            })
        })
        
        numberOfSeconsToWait = numberOfSeconsToWait - 1
        
    }

    func onSuccss()
    {
        
          self._CommonHelper.ShowSuccessMessage(title: "Fantastic!", subsTtitle: "That worked!")
        
        
        if(selectedAuthyAction == .ShouldSignOut){
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            CommonRequests.sharedInstance.signOut(personId: self.targetChildId as String, timeOfSignOut: Date() as NSDate,
                                                  
                                                  onCompletion: {
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        
                                                        SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                            
                                                            self.performSegue(withIdentifier: "GoToRegister", sender: self)

                                                        } )
                                                        
                                                        
                                                    })
                                                    
            })
        }
        else if(selectedAuthyAction == AuhtyActions.ShouldSignIn){
            
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
                CommonRequests.sharedInstance.signIn(personId: self.targetChildId as String, timeOfSignIn: Date() as NSDate,
                                                     onCompletion: {
                                                        DispatchQueue.main.async(execute: {
                                                            
                                                            SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                                
                                                                self.performSegue(withIdentifier: "GoToRegister", sender: self)
                                                                
                                                            } )
                                                        })
                }
                )
        }
        else if(selectedAuthyAction == AuhtyActions.ShouldDoNothing){
         
            SecondstoGoLabel.text = ""
            SecondsToGoLabel2.text = ""
            
           // TopLabel.text = "Fantastic, that worked!"
            
             self.performSegue(withIdentifier: self.successSegueIdentifier as String, sender: self)
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
               
            //})
            
        }
    }
    
    func setupConstraints() {
        
        CenterView.translatesAutoresizingMaskIntoConstraints = false
        
        //Top
        
        CenterView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        CenterView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
     
        CenterView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.50).isActive = true
        
        //height
        CenterView.heightAnchor.constraint(
            equalTo: CenterView.widthAnchor).isActive = true
        
        SecondstoGoLabel.translatesAutoresizingMaskIntoConstraints = false
        
       SecondstoGoLabel.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        SecondstoGoLabel.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
       
        SecondsToGoLabel2.translatesAutoresizingMaskIntoConstraints = false
       
        SecondsToGoLabel2.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true

       SecondsToGoLabel2.topAnchor.constraint(
            equalTo: SecondstoGoLabel.bottomAnchor).isActive = true
        
        
        
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        
        TopContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.20).isActive = true
        
        TopContainer.leadingAnchor.constraint(
        equalTo: view.leadingAnchor).isActive = true
        
        TopContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        TopContainer.bottomAnchor.constraint(
            equalTo: CenterView.topAnchor).isActive = true
        
        
        
        
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        BottomContainer.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.20).isActive = true
        
        BottomContainer.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        BottomContainer.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        BottomContainer.topAnchor.constraint(
            equalTo: CenterView.bottomAnchor).isActive = true
        
        
        
        
        
        
        TopLabel.translatesAutoresizingMaskIntoConstraints = false
        
        TopLabel.centerXAnchor.constraint(
            equalTo: TopContainer.centerXAnchor).isActive = true
        
        TopLabel.centerYAnchor.constraint(
            equalTo: TopContainer.centerYAnchor).isActive = true

   
        
        
        TokenTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        TokenTextFiled.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        TokenTextFiled.centerYAnchor.constraint(
            equalTo: BottomContainer.centerYAnchor).isActive = true
        
        
        TokenTextFiled.widthAnchor.constraint(
            equalTo: BottomContainer.widthAnchor, multiplier: 0.50).isActive = true
        
        
        
        DontHaveYourPhoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        DontHaveYourPhoneLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        
        DontHaveYourPhoneLabel.bottomAnchor.constraint(
            equalTo: view.bottomAnchor).isActive = true

        
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        SetNavigationBarDetails()
    }
    
    func SetNavigationBarDetails()
    {
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.theme4()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
        self.navigationItem.title = " "
    }
    
    func NavBarMenuTapped(){
    self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    func createOverlay(frame : CGRect, xOffset: CGFloat, yOffset: CGFloat, radius: CGFloat) -> UIView
    {
        let overlayView = UIView(frame: frame)
        overlayView.alpha = 0.6
        overlayView.backgroundColor = UIColor.black
        
        // Create a path with the rectangle in it.
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset), radius: radius, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
        path.addRect(CGRect(x: 0, y: 0, width: overlayView.frame.width, height: overlayView.frame.height))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path;
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // Release the path since it's not covered by ARC.
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        return overlayView
    }

}

