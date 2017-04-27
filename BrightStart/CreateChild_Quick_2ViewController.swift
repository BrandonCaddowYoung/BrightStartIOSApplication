    //
    //  DoubleTemplateViewController.swift
    //  BrightStart
    //
    //  Created by Colleen Caddow on 21/03/2017.
    //  Copyright © 2017 dev. All rights reserved.
    //
    
    import UIKit
    
    class CreateChild_Quick_2ViewController: UIViewController {
        
        var _ApplicatoinColours: ApplicatoinColours!
        var _CommonHelper: CommonHelper!
        
        @IBOutlet weak var Top: UIView!
        
         @IBOutlet weak var HeadingLabel: UILabel!
        
        @IBOutlet weak var UpperHeading: UIView!
        
        @IBOutlet weak var UpperContent: UIView!
        
        @IBOutlet weak var Middle: UIView!
        
        @IBOutlet weak var LowerHeading: UIView!
        
        @IBOutlet weak var LowerContent: UIView!
        
        @IBOutlet weak var Bottom: UIView!
        
        @IBOutlet weak var NamesLabel: UILabel!
        
        @IBOutlet weak var MothersName: UITextField!
        @IBOutlet weak var FathersName: UITextField!
        
        @IBOutlet weak var MotherEmail: UITextField!
        @IBOutlet weak var FatherEMail: UITextField!
        
        @IBOutlet weak var EmailLabel: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.edgesForExtendedLayout = []
            
            self.hideKeyboardWhenTappedAround()
            
            _ApplicatoinColours = ApplicatoinColours()
            _CommonHelper = CommonHelper()
            
            setupConstraints()
            
            Top.backgroundColor = StyleManager.DarkBackground()
            
            UpperHeading.backgroundColor = StyleManager.theme2()
            
            UpperContent.backgroundColor = StyleManager.theme2()
            
            Middle.backgroundColor = StyleManager.theme2()
            
            LowerHeading.backgroundColor = StyleManager.theme2()
            
            LowerContent.backgroundColor = StyleManager.theme2()
            
            Bottom.backgroundColor = StyleManager.DarkBackground()
            
            //UpperContent.addBottomBorder(color: StyleManager.theme4(), margins: 1)
            LowerContent.addBottomBorder(color: StyleManager.theme4(), margins: 1)
            UpperHeading.addTopBorder(color: StyleManager.theme4(), margins: 1)
            
            HeadingLabel.font = _ApplicatoinColours.XlargeFont
            HeadingLabel.textColor = StyleManager.theme1()
            
            MothersName.font = _ApplicatoinColours.mediumFont
            FathersName.font = _ApplicatoinColours.mediumFont
            MotherEmail.font = _ApplicatoinColours.mediumFont
            FatherEMail.font = _ApplicatoinColours.mediumFont
            
            MothersName.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
            
            FathersName.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
            
            MotherEmail.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
            
            FatherEMail.setBottomBorder(backGroundColor: StyleManager.theme2().cgColor, underlineColor: StyleManager.theme4().cgColor, textColor: StyleManager.theme5(), palceHoldertextColor: StyleManager.theme3())
            
            NamesLabel.font = _ApplicatoinColours.largeFont
            EmailLabel.font = _ApplicatoinColours.largeFont
            
        }
        
        func setupConstraints() {
            
            //Middle
            
            Middle.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            Middle.centerYAnchor.constraint(
                equalTo: view.centerYAnchor).isActive = true
            
            Middle.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //height
            Middle.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.01).isActive = true
            
            
            
            //Top
            
            Top.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            Top.centerXAnchor.constraint(
                equalTo: view.centerXAnchor).isActive = true
            
            //width
            Top.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //top
            Top.topAnchor.constraint(
                equalTo: view.topAnchor).isActive = true
            
            //height
            Top.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
            
            
            
            
            //Heading label
            
            HeadingLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            HeadingLabel.centerYAnchor.constraint(
                equalTo: Top.centerYAnchor).isActive = true
            
            //center
            HeadingLabel.trailingAnchor.constraint(
                equalTo: Top.trailingAnchor, constant: -15).isActive = true
            
            HeadingLabel.widthAnchor.constraint(
                equalTo: Top.widthAnchor, multiplier: 0.70).isActive = true
            
            HeadingLabel.textAlignment = .right
            
            HeadingLabel.adjustsFontSizeToFitWidth = true
            
            //Upper Heading
            
            UpperHeading.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            UpperHeading.centerXAnchor.constraint(
                equalTo: view.centerXAnchor).isActive = true
            
            //width
            UpperHeading.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //top
            UpperHeading.topAnchor.constraint(
                equalTo: Top.bottomAnchor).isActive = true
            
            //height
            UpperHeading.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
            
            //Name Label
            
            NamesLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            NamesLabel.centerYAnchor.constraint(
                equalTo: UpperHeading.centerYAnchor).isActive = true
            
            //width
            NamesLabel.widthAnchor.constraint(
                equalTo: UpperHeading.widthAnchor).isActive = true
            
            //left
            NamesLabel.leadingAnchor.constraint(
                equalTo: UpperHeading.leadingAnchor, constant: 20 ).isActive = true
            
            //Upper Content
            
            UpperContent.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            UpperHeading.centerXAnchor.constraint(
                equalTo: view.centerXAnchor).isActive = true
            
            //width
            UpperContent.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //top
            UpperContent.topAnchor.constraint(
                equalTo: UpperHeading.bottomAnchor).isActive = true
            
            //height
            UpperContent.bottomAnchor.constraint(
                equalTo: Middle.topAnchor).isActive = true
            
            
            //First Name
            
            MothersName.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            MothersName.centerXAnchor.constraint(
                equalTo: UpperContent.centerXAnchor).isActive = true
            
            //width
            MothersName.widthAnchor.constraint(
                equalTo: UpperContent.widthAnchor, multiplier: 0.70).isActive = true
            
            //top
            MothersName.topAnchor.constraint(
                equalTo: UpperContent.topAnchor, constant: 15).isActive = true
            
            //height
            MothersName.heightAnchor.constraint(
                equalTo: UpperContent.heightAnchor, multiplier: 0.15).isActive = true
            
            //Middle Name
            
            FathersName.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            FathersName.centerXAnchor.constraint(
                equalTo: UpperContent.centerXAnchor).isActive = true
            
            //width
            FathersName.widthAnchor.constraint(
                equalTo: UpperContent.widthAnchor, multiplier: 0.70).isActive = true
            
            //top
            FathersName.topAnchor.constraint(
                equalTo: MothersName.bottomAnchor, constant: 15).isActive = true
            
            //height
            FathersName.heightAnchor.constraint(
                equalTo: UpperContent.heightAnchor, multiplier: 0.15).isActive = true
            
            //Bottom
            
            Bottom.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            Bottom.centerXAnchor.constraint(
                equalTo: view.centerXAnchor).isActive = true
            
            //width
            Bottom.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //bottom
            Bottom.bottomAnchor.constraint(
                equalTo: view.bottomAnchor).isActive = true
            
            //height
            Bottom.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
            
            //Lower Heading
            
            LowerHeading.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            LowerHeading.centerXAnchor.constraint(
                equalTo: view.centerXAnchor).isActive = true
            
            //width
            LowerHeading.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //bottom
            LowerHeading.topAnchor.constraint(
                equalTo: Middle.bottomAnchor).isActive = true
            
            //height
            LowerHeading.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
            
            
            //DOB Label
            
            EmailLabel.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            EmailLabel.centerYAnchor.constraint(
                equalTo: LowerHeading.centerYAnchor).isActive = true
            
            //width
            EmailLabel.widthAnchor.constraint(
                equalTo: LowerHeading.widthAnchor).isActive = true
            
            //left
            EmailLabel.leadingAnchor.constraint(
                equalTo: LowerHeading.leadingAnchor, constant: 20 ).isActive = true
            
            
            //Lower Content
            
            LowerContent.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            LowerContent.centerXAnchor.constraint(
                equalTo: view.centerXAnchor).isActive = true
            
            //width
            LowerContent.widthAnchor.constraint(
                equalTo: view.widthAnchor).isActive = true
            
            //bottom
            LowerContent.bottomAnchor.constraint(
                equalTo: Bottom.topAnchor).isActive = true
            
            //top
            LowerContent.topAnchor.constraint(
                equalTo: LowerHeading.bottomAnchor).isActive = true
            
            
            //First Name
            
            MotherEmail.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            MotherEmail.centerXAnchor.constraint(
                equalTo: LowerContent.centerXAnchor).isActive = true
            
            //width
            MotherEmail.widthAnchor.constraint(
                equalTo: LowerContent.widthAnchor, multiplier: 0.70).isActive = true
            
            //top
            MotherEmail.topAnchor.constraint(
                equalTo: LowerHeading.bottomAnchor, constant: 15).isActive = true
            
            //height
            MotherEmail.heightAnchor.constraint(
                equalTo: LowerContent.heightAnchor, multiplier: 0.15).isActive = true
            
            //Middle Name
            
            FatherEMail.translatesAutoresizingMaskIntoConstraints = false
            
            //center
            FatherEMail.centerXAnchor.constraint(
                equalTo: LowerContent.centerXAnchor).isActive = true
            
            //width
            FatherEMail.widthAnchor.constraint(
                equalTo: LowerContent.widthAnchor, multiplier: 0.70).isActive = true
            
            //top
            FatherEMail.topAnchor.constraint(
                equalTo: MotherEmail.bottomAnchor, constant: 15).isActive = true
            
            //height
            FatherEMail.heightAnchor.constraint(
                equalTo: LowerContent.heightAnchor, multiplier: 0.15).isActive = true
            
            
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

