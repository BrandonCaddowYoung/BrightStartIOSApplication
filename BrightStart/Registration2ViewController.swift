//
//  Registration2ViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 07/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit
import SVProgressHUD

class Registration2ViewController: UIViewController , UITextFieldDelegate {
    
     var _PopUpAlert: UIAlertController!
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var registration: RegistrationModel!
    
      var showNavigationBar = true
    
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
   
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        
        //registration = RegistrationModel()
        
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //Styling button
        FinishedButton.layer.cornerRadius = 5
        FinishedButton.layer.borderWidth = 1
        FinishedButton.layer.borderColor = StyleManager.FontColour().cgColor
        FinishedButton.backgroundColor = StyleManager.buttonBackGround()
        FinishedButton.setTitleColor(StyleManager.buttonForeGround(), for: .normal)
        
        FinishedButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        TopContainer.backgroundColor = StyleManager.theme2()
        MiddleContainer.backgroundColor = StyleManager.theme2()
        BottomContainer.backgroundColor = StyleManager.theme2()
        FooterContainer.backgroundColor = StyleManager.theme2()
        
        SubHeaderLabl.textAlignment = NSTextAlignment.center;
        SubHeaderLabl.numberOfLines = 0;
        SubHeaderLabl.font = UIFont.systemFont(ofSize: 16.0);
        SubHeaderLabl.text = "Just a few more details and you will be ready to go.";
        
        
        NurseryNameTextField.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
        
         NurseryNameTextField.delegate = self;
        
        ManagerNameTextField.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
        
         ManagerNameTextField.delegate = self;
        
        PhoneNumberTextField.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
        
         PhoneNumberTextField.delegate = self;
        
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func SetNavigationBarDetails()
    {
        
        self.navigationController?.navigationBar.topItem?.title = " "
        
        //No right button
        
        //Changes the color of the backgorund within the nav bar.
        //navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.theme2()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.theme1()
        
        self.navigationController?.navigationBar.topItem?.title = " ";
        
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
            multiplier: 0.15).isActive = true
        
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
            multiplier: 0.50).isActive = true
        
        
        //email text field
        
        NurseryNameTextField.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        NurseryNameTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        NurseryNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        NurseryNameTextField.topAnchor.constraint(
            equalTo: BottomContainer.topAnchor).isActive = true
        
        //Password
        
        ManagerNameTextField.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        ManagerNameTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        ManagerNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ManagerNameTextField.topAnchor.constraint(
            equalTo: NurseryNameTextField.bottomAnchor, constant: 10).isActive = true
        
        //Confirm
        
        PhoneNumberTextField.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        PhoneNumberTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        PhoneNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        PhoneNumberTextField.topAnchor.constraint(
            equalTo: ManagerNameTextField.bottomAnchor, constant: 10).isActive = true
        
        //Confirm
        
        FinishedButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true
        
        FinishedButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.50).isActive = true
        
        FinishedButton.heightAnchor.constraint(
            equalTo: BottomContainer.heightAnchor,
            multiplier : 0.30).isActive = true
        
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
        
       

    }
    
   
    @IBAction func FinishClicked(_ sender: Any) {
        
      registration.nurserySchoolName = NurseryNameTextField.text!
        registration.managerName = ManagerNameTextField.text!
        registration.nurserySchoolPhoneNumber = PhoneNumberTextField.text!
        
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        RegistrationRequests.sharedInstance.CreateNewNurserySchoolFromScratch(nurserySchoolName: registration.nurserySchoolName, managerName: registration.managerName, nurserySchoolPhoneNumber: registration.nurserySchoolPhoneNumber, username: registration.username, password: registration.password, onCompletion: { json in
            
            //Should get the authy id back from this create call.
            //Pass authy id into the new view incase the user wants to do a test.
            
            DispatchQueue.main.async(execute: {
                
                SVProgressHUD.dismiss(withDelay: 1, completion: {
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: "")
                    
                    self.performSegue(withIdentifier: "GoToSignIn", sender: self)
                    
                } )
                
            })
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            
            SetNavigationBarDetails()
            
        }
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
