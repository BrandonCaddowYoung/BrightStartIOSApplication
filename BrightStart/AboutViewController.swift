//
//  AboutViewController.swift
//  BrightStart
//
//  Created by Brandon Young on 16/11/2016.
//  Copyright © 2016 Bright Start Software All rights reserved.
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
    var icons8Button: UIButton!
    
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
        bodyLabel.text = "We use Icons8 for our images. If your like their artwork, please pay them a visit. They can be found at www.icons8.com"
        
        bodyLabel.lineBreakMode = .byWordWrapping
        bodyLabel.numberOfLines = 5
        bodyLabel.textColor = _ApplicatoinColours.FontColour
        
        bodyLabel.font = UIFont(name: "Helvetica Neue", size: 21)
        bodyLabel.font = UIFont.systemFont(ofSize: 21, weight: UIFontWeightThin)
        
        view.addSubview(bodyLabel)
        
       icons8Button = UIButton(frame: CGRect(x: 20, y: 20, width: 200, height: 60))
        icons8Button.setTitle("Visit icons8.com", for: .normal)
        icons8Button.backgroundColor = _ApplicatoinColours.BackGroundColour
        icons8Button.setTitleColor(UIColor.black, for: .normal)
        icons8Button.addTarget(self, action: #selector(self.GoToIcons8), for: .touchUpInside)
        view.addSubview(icons8Button)
        
        
    setupConstraints()
        
}
    func GoToIcons8(){
    if let url = NSURL(string: "http://www.icons8.com"){
        UIApplication.shared.openURL(url as URL)
    }
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
    
    
    
    
    //Poisitioning the body label
    
    icons8Button.translatesAutoresizingMaskIntoConstraints = false
    
    //right
    icons8Button.trailingAnchor.constraint(
        equalTo: RightSpacer.leadingAnchor).isActive = true
    
    
    //left
   icons8Button.leadingAnchor.constraint(
        equalTo: LeftSpacer.trailingAnchor).isActive = true
    
    icons8Button.topAnchor.constraint(
        equalTo: bodyLabel.bottomAnchor).isActive = true
    
    
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
