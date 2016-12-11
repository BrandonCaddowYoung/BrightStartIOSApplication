//
//  AboutViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 09/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var _CommonHelper: CommonHelper!
    
    var TopSpacer: UIView!
    var BottomSpacer: UIView!
    var RightSpacer: UIView!
    var LeftSpacer: UIView!
    
    var headingLabel: UILabel!
    
    var bodyLabel: UILabel!
    
    var backButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TopSpacer = UIView()
        view.addSubview(TopSpacer)
        
        BottomSpacer = UIView()
        view.addSubview(BottomSpacer)
        
        RightSpacer = UIView()
        view.addSubview(RightSpacer)
        
        LeftSpacer = UIView()
        view.addSubview(LeftSpacer)
        
        headingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        headingLabel.text = "ABOUT US."
        headingLabel.font = headingLabel.font.withSize(20)
        
        headingLabel.textColor = .white
        
        view.addSubview(headingLabel)
        
        bodyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bodyLabel.text = "We use Icons8 for our images. If your like our artwork, please pay them a visit."
        
        bodyLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        bodyLabel.numberOfLines = 3
        bodyLabel.textColor = .white
        
        view.addSubview(bodyLabel)
        
               
        // Do any additional setup after loading the view.
    _CommonHelper = CommonHelper()
    
    setupConstraints()
        
}

func setupConstraints()
{
    view.backgroundColor = _CommonHelper.hexStringToUIColor(hex: "#37A0e6")
    
    LeftSpacer.translatesAutoresizingMaskIntoConstraints = false
    LeftSpacer.backgroundColor = _CommonHelper.hexStringToUIColor(hex: "#37A0e6")
    
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
    RightSpacer.backgroundColor = _CommonHelper.hexStringToUIColor(hex: "#37A0e6")

    
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
    
    
    
    
    
        TopSpacer.translatesAutoresizingMaskIntoConstraints = false
    TopSpacer.backgroundColor = _CommonHelper.hexStringToUIColor(hex: "#37A0e6")

    
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

   

    
    
    
    BottomSpacer.translatesAutoresizingMaskIntoConstraints = false
    BottomSpacer.backgroundColor = _CommonHelper.hexStringToUIColor(hex: "#37A0e6")
    
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
    

    
    
    
    
    
    headingLabel.translatesAutoresizingMaskIntoConstraints = false
    
    //right
    headingLabel.trailingAnchor.constraint(
    equalTo: RightSpacer.leadingAnchor).isActive = true
    
    //left
    headingLabel.leadingAnchor.constraint(
    equalTo: LeftSpacer.trailingAnchor).isActive = true
    
    //left
    headingLabel.topAnchor.constraint(
    equalTo: TopSpacer.bottomAnchor).isActive = true
    
    headingLabel.centerXAnchor.constraint(
    equalTo: view.centerXAnchor).isActive = true
    
    
    
    //backButton.translatesAutoresizingMaskIntoConstraints = false
    
    
    //left
   // headingLabel.leadingAnchor.constraint(
     //   equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    
    //top
    //headingLabel.topAnchor.constraint(
      //  equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    
    
    
    
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
