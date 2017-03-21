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
    
    var loadingSpiiner: ProgressHUD!
    
    @IBOutlet weak var RememberUsernameLabel: UILabel!
    @IBOutlet weak var RememberUsernameSegment: UISegmentedControl!
    
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

        //view.translatesAutoresizingMaskIntoConstraints = false
        
        self.hideKeyboardWhenTappedAround()
        
        //We need this so that we can dismess the keyboard on enter.
        //passwordTextField.delegate = self
        //usernameTextField.delegate = self
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
       
        usernameTextField.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
        usernameTextField.delegate = self;
        
        passwordTextField.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
          passwordTextField.delegate = self;
        
        setupConstraints()
        
        topView.backgroundColor = _ApplicatoinColours.White
        middleView.backgroundColor = _ApplicatoinColours.White
        bottomView.backgroundColor = _ApplicatoinColours.White
       
        //Styling the sign in button
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        signInButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        signInButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)
        
        signInButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        RememberUsernameSegment.tintColor = _ApplicatoinColours.BackGroundColour
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
       
        //Making the pasword textfield secure
        passwordTextField.isSecureTextEntry = true;
        
        let defaults = UserDefaults.standard
        
        if(retrieveShouldRememberPassword())
        {
            RememberUsernameSegment.selectedSegmentIndex = 0
            usernameTextField.text = retrieveUserName();
        }
        else
        {
            RememberUsernameSegment.selectedSegmentIndex = 1
        }
        
        //Check for existing username.
        
        
        //We could put the passwod in place if it exists however is a security risk.
        
        #if DEBUG
            usernameTextField.text = "user1"
           passwordTextField.text = "user1"
        #endif
        
        usernameTextField.font = _ApplicatoinColours.mediumFont
         passwordTextField.font = _ApplicatoinColours.mediumFont
        
        SignUpButton.titleLabel!.font = _ApplicatoinColours.sshmediumlFont
        SignUpButton.setTitleColor(_ApplicatoinColours.Orange, for: .normal)
        
        signInButton.titleLabel!.font = _ApplicatoinColours.buttonFont
        
        spacerMiddleTopView.backgroundColor = _ApplicatoinColours.White
        spacerMiddleMiddleView.backgroundColor = _ApplicatoinColours.White
        spacerMiddleBottomView.backgroundColor = _ApplicatoinColours.White
        
        
    }
    
    
    @IBAction func Switched(_ sender: Any) {
        
        if RememberUsernameSegment.selectedSegmentIndex == 0 {
            storeShouldRememberUsername(should: true)
            storeUserName(userName: usernameTextField.text!)
        }
        
        if RememberUsernameSegment.selectedSegmentIndex == 1 {
            storeShouldRememberUsername(should: false)
        }
        
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
    
    func retrieveShouldRememberPassword() -> Bool
    {
        let defaults = UserDefaults.standard
        
        if let id = defaults.string(forKey: "ShouldRememberUsername")
        {
            return Bool(id)!
        }
        
        return false
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
        
       // bottomView.backgroundColor = .red
       
        //height
        bottomView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        bottomView.addSubview(FooterView)
        
    //bottomView.backgroundColor = .yellow
        
        //IMAGE WITHIN BOTTOM VIEW
        
        FooterView.translatesAutoresizingMaskIntoConstraints = false
        
        //FooterView.backgroundColor = .yellow
        
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
            equalTo: middleView.bottomAnchor).isActive = true
        //right
        FooterView.bottomAnchor.constraint(
            equalTo: bottomView.bottomAnchor).isActive = true

        DontHaveAnAccountLabel.textColor = _ApplicatoinColours.Black
        DontHaveAnAccountLabel.font = _ApplicatoinColours.sshmediumlFont
        
        RememberUsernameLabel.textColor = _ApplicatoinColours.Black
        RememberUsernameLabel.font = _ApplicatoinColours.sshmediumlFont
        
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
       
        //top
        SignUpButton.topAnchor.constraint(
            equalTo: DontHaveAnAccountLabel.topAnchor).isActive = true
        
        //left
        SignUpButton.bottomAnchor.constraint(
            equalTo: DontHaveAnAccountLabel.bottomAnchor).isActive = true
                
        //MIDDLE VIEW
        
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
         middleView.backgroundColor = .yellow
        
        //left
        middleView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        //right
        middleView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor).isActive = true
        //bottom
        middleView.bottomAnchor.constraint(
            equalTo: bottomView.topAnchor).isActive = true
    
        middleView.backgroundColor = .red
        
        //no top
        
        //height
        middleView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.45).isActive = true
        
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
        
             usernameTextField.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
     
        passwordTextField.centerXAnchor.constraint(
            equalTo: middleView.centerXAnchor).isActive = true
        
        //USER TEXT FIELD
        
        
        //bottom
        usernameTextField.topAnchor.constraint(
            equalTo: spacerMiddleTopView.bottomAnchor, constant: 50
            ).isActive = true
        
        //width
        usernameTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        //PASSSWORD TEXT FIELD
        
        //top
        passwordTextField.topAnchor.constraint(
            equalTo: usernameTextField.bottomAnchor, constant: 5
            ).isActive = true
        
        
        passwordTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        
        RememberUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        RememberUsernameLabel.leadingAnchor.constraint(
            equalTo: passwordTextField.leadingAnchor
            ).isActive = true
        
        RememberUsernameLabel.topAnchor.constraint(
            equalTo: passwordTextField.bottomAnchor, constant: 15
            ).isActive = true
        
        RememberUsernameSegment.translatesAutoresizingMaskIntoConstraints = false
        
        RememberUsernameSegment.leadingAnchor.constraint(
            equalTo: RememberUsernameLabel.leadingAnchor
            ).isActive = true
        
        RememberUsernameSegment.topAnchor.constraint(
            equalTo: RememberUsernameLabel.bottomAnchor
            , constant: 3).isActive = true
        
        //Sign in button
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signInButton.topAnchor.constraint(
            equalTo: RememberUsernameSegment.bottomAnchor, constant: 20).isActive = true
        
        
        //width
        signInButton.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        
        signInButton.centerXAnchor.constraint(
            equalTo: spacerMiddleMiddleView.centerXAnchor).isActive = true
        
       // bottomView.backgroundColor = .white
        
        
        
        
        
        
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
            multiplier: 0.35).isActive = true
        
        //topView.backgroundColor = .yellow
        
        //IMAGE WITHIN TOP VIEW
        
        logoImaveView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImaveView.centerXAnchor.constraint(
            equalTo: topView.centerXAnchor).isActive = true
        
        logoImaveView.widthAnchor.constraint(
            equalTo: topView.widthAnchor, multiplier: 0.40).isActive = true
        
        logoImaveView.heightAnchor.constraint(
            equalTo: topView.heightAnchor, multiplier: 0.50).isActive = true
        
        logoImaveView.bottomAnchor.constraint(
            equalTo: spacerMiddleTopView.topAnchor).isActive = true
        
        
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
        defaults.set(nurserySchoolId, forKey: "NurserySchoolId")
        defaults.set(username, forKey: "NurserySchoolUserName")
    }
    
    func storeUserName(userName: String)
    {
        UserDefaults.standard.set(userName, forKey: "NurserySchoolUserName")
    }
    
    func retrieveUserName() -> String
    {
        if let userName = UserDefaults.standard.string(forKey: "NurserySchoolUserName") {
            return userName
        }
        
        return ""
    }
    
    
    func storeShouldRememberUsername(should: Bool)
    {
        let defaults = UserDefaults.standard
        defaults.set(String(should), forKey: "ShouldRememberUsername")
        
        var test = retrieveShouldRememberPassword()
        
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        
        if (segue.identifier == "AccessGrantedSegue") {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
                vc.selectedMenu = .MainMenu
                vc.showNavigationBar = true
                
                
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
        //removeStoredNurserySchoolId()
        
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
        
        //Changes the color of the backgorund within the nav bar.
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.Black
        
        //Title color
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.Black]
        navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
        
        //Back color
        navigationController?.navigationBar.tintColor = _ApplicatoinColours.NavigationBarBackBackButtonColor //Orange
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.NavigationBarBackGroundColor // Grey
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        
        self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black
        
        navigationController?.navigationBar.topItem?.title = "Sign in"
        
        
        navigationController?.navigationBar.backItem?.title = ""
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func NavBarMenuTapped(){
        
    }

   

}


