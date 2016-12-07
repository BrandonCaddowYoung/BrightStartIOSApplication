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
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupConstraints()
        
        //Styling the sign in button
        signInButton.backgroundColor = .clear
        signInButton.layer.cornerRadius = 5
        signInButton.layer.borderWidth = 1
        signInButton.layer.borderColor = UIColor.white.cgColor
        
        let commonHelper = CommonHelper()
        
        view.backgroundColor = commonHelper.hexStringToUIColor(hex: "#37A0e6")
       
        //Making the pasword textfield secure
        passwordTextField.isSecureTextEntry = true;
        
        let defaults = UserDefaults.standard
        
        //Check for existing username.
        if let username = defaults.string(forKey: "NurserySchoolUsername")
        {
            usernameTextField.text = username;
        }
        
        //We could put the passwod in place if it exists however is a security risk.
        
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
            equalTo: view.bottomAnchor,
            constant: -20).isActive = true
        // no top
        
        //height
        bottomView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.20).isActive = true
        
        //IMAGE WITHIN BOTTOM VIEW
        
        //Sign in button
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.heightAnchor.constraint(
            equalTo: bottomView.heightAnchor,
            multiplier: 0.40).isActive = true
        
        signInButton.topAnchor.constraint(
            equalTo: middleView.bottomAnchor).isActive = true
        
        signInButton.trailingAnchor.constraint(
            equalTo: bottomView.trailingAnchor, constant: -15).isActive = true
        
        signInButton.leadingAnchor.constraint(
            equalTo: bottomView.leadingAnchor, constant: 15).isActive = true
        
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
        
        usernameTextField.heightAnchor.constraint(
            equalTo: middleView.heightAnchor,
            multiplier: 0.10).isActive = true

        //USER LABEL
        
        //bottom
        usernameLabel.bottomAnchor.constraint(
            equalTo: usernameTextField.topAnchor, constant: -5
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
            equalTo: passwordLabel.bottomAnchor, constant: 5
            ).isActive = true
        
        
        passwordTextField.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        passwordTextField.heightAnchor.constraint(
            equalTo: middleView.heightAnchor,
            multiplier: 0.10).isActive = true
        

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
            //Do any work before moving to the next scene.
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
    
    /*!
     @brief If the credentials withi the text fields are valid, will move to the next secene.
     */
    func MoveToNextSceneIfCredentialsAreValid()
    {
        let nurserySchoolUserName = usernameTextField.text
        let nurserySchoolPassword = passwordTextField.text
        
        if nurserySchoolUserName?.isEmpty == true || nurserySchoolPassword?.isEmpty == true {
            return
        }
        
        //Make api call to check if credentials are valid.
        var nurserySchoolId = ""
        
        CommonRequests.sharedInstance.RetrieveNurserySchoolId(userName: nurserySchoolUserName!, passWord: nurserySchoolPassword!, onCompletion: { json in
            
            nurserySchoolId = json.rawString()!
            
            DispatchQueue.main.async(execute: {
                
                if nurserySchoolId.isEmpty == false
                {
                    //Store the nursery school Id
                    self.storeNurserySchoolIdWithinDefaults(username: nurserySchoolUserName!, nurserySchoolId: nurserySchoolId)
                    
                    self.performSegue(withIdentifier: "AccessGrantedSegue", sender: self)
                    
                }
                else
                {
                //Notify the user that the given credentials were incorrect.
                }
                
            })
            
        })
    }

    /*!
     @brief The user has clicked the sign in button so moving to the next scene if the credentials supplied are valid.
     */
    @IBAction func signInButtonClicked(_ sender: Any) {
        
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
    
    

}
