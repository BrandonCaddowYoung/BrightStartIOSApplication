//
//  AboutViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 09/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var _ApplicatoinColours: ApplicatoinColours!
    
    var TopSpacer: UIView!
    var BottomSpacer: UIView!
    var RightSpacer: UIView!
    var LeftSpacer: UIView!
  
    var bodyLabel: UILabel!
    
    var backButton: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        _ApplicatoinColours = ApplicatoinColours()
        
        TopSpacer = UIView()
        view.addSubview(TopSpacer)
        
        BottomSpacer = UIView()
        view.addSubview(BottomSpacer)
        
        RightSpacer = UIView()
        view.addSubview(RightSpacer)
        
        LeftSpacer = UIView()
        view.addSubview(LeftSpacer)
        
        bodyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bodyLabel.text = "We use Icons8 for our images. If your like our artwork, please pay them a visit."
        
        bodyLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        bodyLabel.numberOfLines = 3
        bodyLabel.textColor = _ApplicatoinColours.FontColour
        
        view.addSubview(bodyLabel)
        
    setupConstraints()
        
}

func setupConstraints()
{
    view.backgroundColor = _ApplicatoinColours.BackGroundColour
    
    LeftSpacer.translatesAutoresizingMaskIntoConstraints = false
    LeftSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
    
    //left
    LeftSpacer.leadingAnchor.constraint(
        equalTo: view.leadingAnchor).isActive = true
    //top
    LeftSpacer.topAnchor .constraint(
        equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    //bottom
    LeftSpacer.bottomAnchor .constraint(
        equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    
    LeftSpacer.widthAnchor.constraint(
        equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    
    
        RightSpacer.translatesAutoresizingMaskIntoConstraints = false
    RightSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour

    
    //right
    RightSpacer.trailingAnchor.constraint(
        equalTo: view.trailingAnchor).isActive = true
    //top
    RightSpacer.topAnchor .constraint(
        equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    //bottom
    RightSpacer.bottomAnchor .constraint(
        equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    
    RightSpacer.widthAnchor.constraint(
        equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
    
    //Positioning the top spacer
    
        TopSpacer.translatesAutoresizingMaskIntoConstraints = false
    TopSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
    
    //right
    TopSpacer.trailingAnchor.constraint(
        equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    
    //left
    TopSpacer.leadingAnchor.constraint(
        equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    
    //top
    TopSpacer.topAnchor .constraint(
        equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    
    TopSpacer.heightAnchor.constraint(
        equalTo: view.heightAnchor, multiplier: 0.10).isActive = true

   //Positioning the bottom spacer
    
    BottomSpacer.translatesAutoresizingMaskIntoConstraints = false
    BottomSpacer.backgroundColor = _ApplicatoinColours.BackGroundColour
    //right
    BottomSpacer.trailingAnchor.constraint(
        equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    
    //left
    BottomSpacer.leadingAnchor.constraint(
        equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    
    //bottom
    BottomSpacer.bottomAnchor .constraint(
        equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    
    BottomSpacer.heightAnchor.constraint(
        equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
    
    //Poisitioning the body label
    
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    
    //right
    bodyLabel.trailingAnchor.constraint(
        equalTo: RightSpacer.leadingAnchor).isActive = true

    
    //left
    bodyLabel.leadingAnchor.constraint(
        equalTo: LeftSpacer.trailingAnchor).isActive = true
    
    bodyLabel.centerYAnchor.constraint(
        equalTo: view.centerYAnchor).isActive = true
  
    bodyLabel.centerXAnchor.constraint(
        equalTo: view.centerXAnchor).isActive = true
    
    
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
