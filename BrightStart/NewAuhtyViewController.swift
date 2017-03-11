//
//  NewAuhtyViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 02/02/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class NewAuhtyViewController: UIViewController, UITextFieldDelegate {

    var showNavigationBar = true
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var createdAuthyId :NSString!
    
    var selectedChildId: NSString!
    
    @IBOutlet weak var TopContainer: UIView!
    
    @IBOutlet weak var HeadingLabel: UILabel!
    @IBOutlet weak var MiddleContainer: UIView!
    
    @IBOutlet weak var NameTextBox: UITextField!
    
    @IBOutlet weak var RelationshipTextBox: UITextField!
    
    @IBOutlet weak var MobileNumberTextBox: UITextField!
    
    @IBOutlet weak var CountryCodeTextBox: UITextField!
    
    @IBOutlet weak var EmailAddresTextBox: UITextField!
    
    @IBOutlet weak var BottomContainer: UIView!
    
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBAction func CreateUserClick(_ sender: Any) {
        
        //Retrieve all children
        AuthyRequests.sharedInstance.RegisterUser(email: EmailAddresTextBox.text!, phoneNumber: MobileNumberTextBox.text!, countryCode: CountryCodeTextBox.text!, name: NameTextBox.text!, relationship: RelationshipTextBox.text!, childId: selectedChildId as String, onCompletion:  { json in
            
           self.createdAuthyId = json.rawString() as NSString!
            
            //Should get the authy id back from this create call.
            //Pass authy id into the new view incase the user wants to do a test.
            
            DispatchQueue.main.async(execute: {
                
                self.performSegue(withIdentifier: "GoToNewUserComplete", sender: self)
                
            })
            
        })
        
    }
    
    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToNewUserComplete") {
          
            if let vc = segue.destination as? AuthyNewUserCompleteViewController {
                
              vc.targetAuthyId = createdAuthyId
                
            }
                    }
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
    
    func SetNavigationBarDetails()
    {
        //Changes the color of the backgorund within the nav bar.
        //navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.White]
        navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.Blue
        
        var rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.White
        
        self.navigationController?.navigationBar.topItem?.title = "New Authy User";
        
    }
    
    func NavBarMenuTapped(){
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
       self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //Styling button
        SubmitButton.layer.cornerRadius = 5
        SubmitButton.layer.borderWidth = 1
        SubmitButton.layer.borderColor = _ApplicatoinColours.FontColour.cgColor
        SubmitButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        SubmitButton.setTitleColor(_ApplicatoinColours.ButtonForeGroundColor, for: .normal)

        SubmitButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        
        view.backgroundColor = _ApplicatoinColours.White
        
        RelationshipTextBox.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
        RelationshipTextBox.delegate = self;
        
        NameTextBox.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
        NameTextBox.delegate = self;
        
        CountryCodeTextBox.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
        CountryCodeTextBox.delegate = self;
        
         EmailAddresTextBox.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
        EmailAddresTextBox.delegate = self;
        
        MobileNumberTextBox.setBottomBorder(backGroundColor: _ApplicatoinColours.White.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.Black)
        
        MobileNumberTextBox.delegate = self;
        
        HeadingLabel.font = _ApplicatoinColours.largeFont
        HeadingLabel.textColor = _ApplicatoinColours.White
        
         setupConstraints()
    
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
    
    
    /*!
     @brief Sets up all constraints for the view.
     */
    func setupConstraints() {
        
        //Positioning the left subview
        
        TopContainer.translatesAutoresizingMaskIntoConstraints = false
        
        HeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        MiddleContainer.translatesAutoresizingMaskIntoConstraints = false
        BottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        TopContainer.backgroundColor = _ApplicatoinColours.White
        MiddleContainer.backgroundColor = _ApplicatoinColours.White
        BottomContainer.backgroundColor = _ApplicatoinColours.White
        
        NameTextBox.translatesAutoresizingMaskIntoConstraints = false
        RelationshipTextBox.translatesAutoresizingMaskIntoConstraints = false
        MobileNumberTextBox.translatesAutoresizingMaskIntoConstraints = false
        CountryCodeTextBox.translatesAutoresizingMaskIntoConstraints = false
        EmailAddresTextBox.translatesAutoresizingMaskIntoConstraints = false
        SubmitButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            multiplier: 0.10).isActive = true
        
        
        
        
        
        
        //HeadingLabel
        
        //left
        HeadingLabel.centerYAnchor.constraint(
            equalTo: TopContainer.centerYAnchor).isActive = true
        
        //Right
        HeadingLabel.centerXAnchor.constraint(
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
            multiplier: 0.50).isActive = true
        
        
        
        
        //MobileNumber text box
        
        //X
        MobileNumberTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        //Y
        MobileNumberTextBox.centerYAnchor.constraint(
            equalTo: MiddleContainer.centerYAnchor).isActive = true
        
        MobileNumberTextBox.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        MobileNumberTextBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
        
       
        //Relationship text box
        
        //Bottom
        RelationshipTextBox.bottomAnchor.constraint(
            equalTo: MobileNumberTextBox.topAnchor, constant: -10).isActive = true
        
        //X
        RelationshipTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true

        RelationshipTextBox.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        RelationshipTextBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Country code
      
        //Top
        CountryCodeTextBox.topAnchor.constraint(
            equalTo: MobileNumberTextBox.bottomAnchor, constant: 10).isActive = true
        
        //X
        CountryCodeTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        CountryCodeTextBox.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        CountryCodeTextBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Email addres
        
        //Top
        EmailAddresTextBox.topAnchor.constraint(
            equalTo: CountryCodeTextBox.bottomAnchor, constant: 10).isActive = true
        
        //X
        EmailAddresTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        EmailAddresTextBox.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        EmailAddresTextBox.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        //Email addres
        
       
        //bottom
        NameTextBox.bottomAnchor.constraint(
            equalTo: RelationshipTextBox.topAnchor, constant: -10).isActive = true
        
        //X
        NameTextBox.centerXAnchor.constraint(
            equalTo: MiddleContainer.centerXAnchor).isActive = true
        
        NameTextBox.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.70).isActive = true
        
        NameTextBox.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
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
        
        //Country code
        
        //width
        SubmitButton.widthAnchor.constraint(
            equalTo: BottomContainer.widthAnchor, multiplier: 0.60).isActive = true
        //Y
        SubmitButton.centerYAnchor.constraint(
            equalTo: BottomContainer.centerYAnchor, constant: 10).isActive = true
        
        //X
        SubmitButton.centerXAnchor.constraint(
            equalTo: BottomContainer.centerXAnchor).isActive = true

        
        
      
    }
}
