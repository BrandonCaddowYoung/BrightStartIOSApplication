//
//  AuthyAuthenticateViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 12/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class AuthyAuthenticateViewController: UIViewController, UITextFieldDelegate {

     var showNavigationBar = true
    
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

         self.hideKeyboardWhenTappedAround()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        // Do any additional setup after loading the view.
        
        TokenTextFiled.setBottomBorder(backGroundColor: _ApplicatoinColours.BackGroundColour.cgColor, underlineColor: _ApplicatoinColours.Orange.cgColor, textColor: _ApplicatoinColours.White)
        
        TokenTextFiled.delegate = self;
        
        setupConstraints()
        
        CenterView.backgroundColor = _ApplicatoinColours.White
        
        view.backgroundColor = _ApplicatoinColours.BackGroundColour
        TopContainer.backgroundColor = _ApplicatoinColours.BackGroundColour
        BottomContainer .backgroundColor = _ApplicatoinColours.BackGroundColour
        
        SecondstoGoLabel.font = _ApplicatoinColours.MassiveFont
        
        SecondstoGoLabel.textColor = _ApplicatoinColours.Orange
        
        SecondsToGoLabel2.font = _ApplicatoinColours.sshmediumlFont
        SecondsToGoLabel2.textColor = _ApplicatoinColours.Black
        
        TopLabel.font = _ApplicatoinColours.MenuFont
        TopLabel.textColor = _ApplicatoinColours.FontColour
        
        DontHaveYourPhoneLabel.font = _ApplicatoinColours.MenuFont
        DontHaveYourPhoneLabel.textColor = _ApplicatoinColours.FontColour
        
    
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
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            
            SetNaviagationBarDetails()
            
        }
    }
    
    func SetNaviagationBarDetails()
    {
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: _ApplicatoinColours.Black]
        navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = _ApplicatoinColours.White
        
        self.navigationController?.navigationBar.topItem?.title = "Authy Settings";
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        
        self.navigationItem.rightBarButtonItem?.tintColor = _ApplicatoinColours.Black
        
    }
    
    
    func NavBarMenuTapped(){}
    
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

