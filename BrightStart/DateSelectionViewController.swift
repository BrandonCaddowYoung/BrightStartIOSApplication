//
//  DateSelectionViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/12/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
//

import UIKit

class DateSelectionViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    
    var TopThirdView: UIView!
    var HeadingLabel: UILabel!
    var MiddleThirdView: UIView!
    var DatePicker: UIDatePicker!
    var BottomThirdView: UIView!
    var SaveButton: UIButton!
    
    var OptionText: NSString!
    var Purpose: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TopThirdView = UIView()
        HeadingLabel = UILabel()
        
        HeadingLabel.text = "Select your date."
        HeadingLabel.textAlignment = NSTextAlignment.center;
        
        TopThirdView.addSubview(HeadingLabel)
        
         DatePicker = UIDatePicker()
        
        MiddleThirdView = UIView()
       MiddleThirdView.addSubview(DatePicker)
        
        BottomThirdView = UIView()
        
        SaveButton = UIButton()
        BottomThirdView.addSubview(SaveButton)
        
        SaveButton.setTitle("Search for time stamps.", for: .normal)
        SaveButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        
        self.view.addSubview(TopThirdView)
        self.view.addSubview(MiddleThirdView)
        self.view.addSubview(BottomThirdView)
        
         _ApplicatoinColours = ApplicatoinColours()
        
        setupConstraints()
        
        view.backgroundColor = StyleManager.DarkBackground()
        
        DatePicker.datePickerMode = UIDatePickerMode.date
       
        DatePicker.maximumDate = NSDate() as Date
        
    }
    
    func buttonClicked() {
        self.performSegue(withIdentifier: "GoToSearchPerson", sender: nil)
    }
    
    func setupConstraints() {
        
        //Positioning the left subview
        
        TopThirdView.translatesAutoresizingMaskIntoConstraints = false
        HeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        MiddleThirdView.translatesAutoresizingMaskIntoConstraints = false
        DatePicker.translatesAutoresizingMaskIntoConstraints = false
        BottomThirdView.translatesAutoresizingMaskIntoConstraints = false
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Positioning top view
        
        //TopThirdView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let margins = view.layoutMarginsGuide
        
        TopThirdView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        TopThirdView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        TopThirdView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
        TopThirdView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.33).isActive = true
        
        
        
        //Positioning date picker
        
        HeadingLabel.leadingAnchor.constraint(equalTo: TopThirdView.leadingAnchor).isActive = true
        HeadingLabel.trailingAnchor.constraint(equalTo: TopThirdView.trailingAnchor).isActive = true
        
        //top
        HeadingLabel.topAnchor.constraint(
            equalTo: TopThirdView.topAnchor).isActive = true
        
        //height
        HeadingLabel.heightAnchor.constraint(
            equalTo: TopThirdView.heightAnchor,
            multiplier: 0.25).isActive = true

        //Positioning middle view
        
        MiddleThirdView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        MiddleThirdView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        //top
        MiddleThirdView.topAnchor.constraint(
            equalTo: TopThirdView.bottomAnchor).isActive = true
        
        //height
        MiddleThirdView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.33).isActive = true
        
        //MiddleThirdView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        //Positioning date picker
        
        DatePicker.leadingAnchor.constraint(equalTo: MiddleThirdView.leadingAnchor).isActive = true
        DatePicker.trailingAnchor.constraint(equalTo: MiddleThirdView.trailingAnchor).isActive = true
        
        //top
        DatePicker.topAnchor.constraint(
            equalTo: MiddleThirdView.topAnchor).isActive = true
        
        //height
        DatePicker.heightAnchor.constraint(
            equalTo: MiddleThirdView.heightAnchor).isActive = true
        
        //Positioning bottom view
        
        BottomThirdView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        BottomThirdView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        //top
        BottomThirdView.topAnchor.constraint(
            equalTo: MiddleThirdView.bottomAnchor).isActive = true
        
        BottomThirdView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
      //  BottomThirdView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        //height
        SaveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //left
        SaveButton.leadingAnchor.constraint(
            equalTo: BottomThirdView.leadingAnchor, constant: 5).isActive = true
        
        //right
        SaveButton.trailingAnchor.constraint(
            equalTo: BottomThirdView.trailingAnchor, constant: -5).isActive = true
        
        //bottom
        SaveButton.bottomAnchor.constraint(
            equalTo: BottomThirdView.bottomAnchor, constant: -10).isActive = true
        
        //Stlying save button
        SaveButton.layer.cornerRadius = 5
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.borderColor = StyleManager.FontColour().cgColor
        SaveButton.backgroundColor = StyleManager.buttonBackGround()
        
        SaveButton.setTitleColor(StyleManager.buttonForeGround(), for: .normal)
        
        SaveButton.titleLabel?.font = _ApplicatoinColours.buttonFont
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //PAss in date here!

    /*!
     @brief Preparing to segue.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (segue.identifier == "GoToSearchPerson") {
            
            //Settings the menu details.
            
            if let vc = segue.destination as? PersonSearchTableViewController {
                
                vc.OptionText = OptionText
                vc.targetDate = DatePicker.date
                vc.Purpose = Purpose
                
            }
        }
        
        
        if (segue.identifier == "GoToMainMenu") {
            
            //Settings the menu details.
            
            // if let navController = segue.destination as? UINavigationController {
            
            if let vc = segue.destination as? MainMenuViewController {
                
                //TODO: access here chid VC  like childVC.yourTableViewArray = localArrayValue
                
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
