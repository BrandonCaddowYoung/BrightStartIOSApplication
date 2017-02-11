//
//  SignInViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var _PopUpAlert: UIAlertController!
    
    @IBOutlet weak var FooterView: UIView!
    
    @IBOutlet weak var spacerMiddleTopView: UIView!
    
    @IBOutlet weak var spacerMiddleMiddleView: UIView!
    
    @IBOutlet weak var spacerMiddleBottomView: UIView!
    
    @IBOutlet weak var logoImaveView: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var DontHaveAnAccountLabel: UILabel!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //We need this so that we can dismess the keyboard on enter.
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
      
        setupConstraints()
        
        //Styling the sign in button
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        signInButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        signInButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
       
        //Making the pasword textfield secure
        passwordTextField.isSecureTextEntry = true;
        
        let defaults = UserDefaults.standard
        
        //Check for existing username.
        if let username = defaults.string(forKey: "NurserySchoolUsername")
        {
            usernameTextField.text = username;
        }
        
        //We could put the passwod in place if it exists however is a security risk.
        
        #if DEBUG
            usernameTextField.text = "user1"
            passwordTextField.text = "user1"
        #endif
    }
    
    /*!
     @brief Retrieves the NurserySchoolId from the defaults.
     */
    func retreiveStoredNurserySchoolId() -> String
    {
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "NurserySchoolId")
        {
            return id
        }
        
        return ""
    }
    
    /*!
     @brief Removes the NurserySchoolId from the defaults.
     */
    func removeStoredNurserySchoolId()
    {
        storeNurserySchoolIdWithinDefaults(username: "",nurserySchoolId: "")
    }

    /*!
     @brief Sets up all constraints for the view.
     */
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
            equalTo: view.bottomAnchor).isActive = true
        // no top
        
        //height
        bottomView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        bottomView.addSubview(FooterView)
        
       // bottomView.backgroundColor = .yellow
        
        //IMAGE WITHIN BOTTOM VIEW
        
        //Sign in button
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signInButton.topAnchor.constraint(
            equalTo: middleView.bottomAnchor).isActive = true
        
       
        //width
         signInButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true

        
        signInButton.centerXAnchor.constraint(
           equalTo: bottomView.centerXAnchor).isActive = true
        
        //bottomView.backgroundColor = .red
        
        
        FooterView.translatesAutoresizingMaskIntoConstraints = false
        
        //FooterView.backgroundColor = .white
        
        //bottom
        FooterView.bottomAnchor.constraint(
            equalTo: bottomView.bottomAnchor).isActive = true
        
        //left
        FooterView.leadingAnchor.constraint(
            equalTo: bottomView.leadingAnchor).isActive = true
        //right
        FooterView.trailingAnchor.constraint(
            equalTo: bottomView.trailingAnchor).isActive = true
        
       
        //left
        FooterView.topAnchor.constraint(
            equalTo: signInButton.bottomAnchor).isActive = true
        //right
        FooterView.bottomAnchor.constraint(
            equalTo: bottomView.bottomAnchor).isActive = true

        
        
        
        
        
        DontHaveAnAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //bottom
        DontHaveAnAccountLabel.centerXAnchor.constraint(
            equalTo: FooterView.centerXAnchor, constant: -25).isActive = true
        
        //left
        DontHaveAnAccountLabel.bottomAnchor.constraint(
            equalTo: FooterView.bottomAnchor).isActive = true
        
        
        
        SignUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        SignUpButton.leadingAnchor.constraint(
            equalTo: DontHaveAnAccountLabel.trailingAnchor, constant: 5).isActive = true
        
        //left
       // SignUpButton.trailingAnchor.constraint(
          //  equalTo: FooterView.trailingAnchor).isActive = true

        
        
        //left
        SignUpButton.topAnchor.constraint(
            equalTo: DontHaveAnAccountLabel.topAnchor).isActive = true
        
        //left
        SignUpButton.bottomAnchor.constraint(
            equalTo: DontHaveAnAccountLabel.bottomAnchor).isActive = true
        
        
        
        //left
        //SignUpButton.centerYAnchor.constraint(
          //  equalTo: DontHaveAnAccountLabel.centerYAnchor).isActive = true
        
        
        
        
        //MIDDLE VIEW
        
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        // middleView.backgroundColor = .yellow
        
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
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
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
            multiplier: 0.0).isActive = true

        //spacerMiddleMiddleView.backgroundColor = UIColor.red
        
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
        
     //   usernameLabel.centerXAnchor.constraint(
       //     equalTo: middleView.centerXAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
       // passwordLabel.centerXAnchor.constraint(
         //   equalTo: middleView.centerXAnchor).isActive = true
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
        
        //PASSSWORD TEXT FIELD
        
        //top
        passwordTextField.topAnchor.constraint(
            equalTo: spacerMiddleMiddleView.bottomAnchor, constant: 5
            ).isActive = true
        
        
        passwordTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
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
    
    /*!
     @brief This simply dismisses the keyboard when enter is pressed.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
      self.view.endEditing(true)
      return false
    }
    
    /*!
     @brief Stores the given Username and NurserySchoolId within the defaults so they can be used later when making API calls.
     */
    func storeNurserySchoolIdWithinDefaults(username: String, nurserySchoolId: String)
    {
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "NurserySchoolUserName")
        defaults.set(nurserySchoolId, forKey: "NurserySchoolId")
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "AccessGrantedSegue") {
            
            //Settings the menu details.
            
            if let navController = segue.destination as? UINavigationController {
                
                if let vc = navController.topViewController as? MainMenuViewController {
                    //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                    
                    vc.images = [UIImage(named: "Register")!, UIImage(named: "Forecast")!, UIImage(named: "TimeCard")!, UIImage(named: "Information")!, UIImage(named: "SignOut")!]
                    
                    vc.segueIdList = ["GoToRegister", "GoToForecast", "GoToTimeStampsMenu", "GoToInformation", "GoToSignIn"]
                    
                    vc.DisplayTextList = ["Register",  "Forecast", "Time Stamps", "Informaiton", "Sign Out"]
                    
                    
                    
                    
                }
            }
            
        }
    }
    
    /*!
     @brief The user finished editing the username text field.
     */
    @IBAction func userNameEditingEnd(_ sender: Any) {
        //MoveToNextSceneIfCredentialsAreValid()
    }
    
    /*!
     @brief The user finished editing the password text field.
     */
    @IBAction func passWordEditEnd(_ sender: Any) {
       // MoveToNextSceneIfCredentialsAreValid()
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "GoToSignUp", sender: self)
        
    }
    
    
    /*!
     @brief If the credentials withi the text fields are valid, will move to the next secene.
     */
    func MoveToNextSceneIfCredentialsAreValid()
    {
        let nurserySchoolUserName = usernameTextField.text
        let nurserySchoolPassword = passwordTextField.text
        
        if nurserySchoolUserName?.isEmpty == true || nurserySchoolPassword?.isEmpty == true {
            
            //Removing the message we showed the user when they attempted to sign in.
            self._PopUpAlert.dismiss(animated: false, completion:
                {
                    let alert = UIAlertController(title: "Login failed.", message:
                        "In order to login, you will need to supply both a username and a password.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
      
            })
            
            
            return
        }
        
        //Make api call to check if credentials are valid.
        var nurserySchoolId = ""
        
        CommonRequests.sharedInstance.RetrieveNurserySchoolId(userName: nurserySchoolUserName!, passWord: nurserySchoolPassword!, onCompletion: { json in
            
            nurserySchoolId = json.rawString()!
            
            DispatchQueue.main.async(execute: {
                
                if nurserySchoolId.isEmpty == false
                {
                    
                    let callActionHandler = { () -> Void in
                        
                        //Store the nursery school Id
                        self.storeNurserySchoolIdWithinDefaults(username: nurserySchoolUserName!, nurserySchoolId: nurserySchoolId)
                        
                        self.performSegue(withIdentifier: "AccessGrantedSegue", sender: self)
                        
                    }
                    
                    //Removing the message we showed the user when they attempted to sign in.
                    self._PopUpAlert.dismiss(animated: false, completion: callActionHandler)
                    
                    
                    
                }
                else
                {
                    
                //Notify the user that the given credentials were incorrect.
                    
                    //Removing the message we showed the user when they attempted to sign in.
                    self._PopUpAlert.dismiss(animated: false, completion: {  let alert = UIAlertController(title: "Login failed.", message:
                        "Invalid credentials were supplied. Please try again making sure both your username and password are spelt correctly.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
})
                    
                    
                    
                }
                
            })
            
        })
    }

    /*!
     @brief The user has clicked the sign in button so moving to the next scene if the credentials supplied are valid.
     */
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        _PopUpAlert = self._CommonHelper.showOverlayMessage("Loading....")
        self.present(_PopUpAlert, animated: true, completion: nil)
        
        //Removing incase the user is trying to switch accounts.
        removeStoredNurserySchoolId()
        
        MoveToNextSceneIfCredentialsAreValid()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Removes the navigation bar from the top
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    

}
