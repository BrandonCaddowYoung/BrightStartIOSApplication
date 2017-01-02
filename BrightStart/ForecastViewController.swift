//
//  ForecastViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 01/01/2017.
//  Copyright © 2017 dev. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    
    //These are all the containers!
    @IBOutlet weak var TopLeftView: UIView!
    @IBOutlet weak var TopRightView: UIView!
    
    @IBOutlet weak var MiddleLeftView: UIView!
    @IBOutlet weak var MiddleRightView: UIView!
    
    @IBOutlet weak var MiddleView: UIView!
    
    @IBOutlet weak var BottomLeftView: UIView!
    @IBOutlet weak var BottomRightView: UIView!
    
    @IBOutlet weak var BottomView: UIView!
    
    //There are all the elements that go within the containers!
    
    //Top left
    @IBOutlet weak var yetToArriveChildren: UILabel!
    @IBOutlet weak var yetToArriveStaff: UILabel!
    
    //Top Right
    @IBOutlet weak var signedInChildren: UILabel!
    @IBOutlet weak var signedInStaff: UILabel!
    
    
    @IBOutlet weak var totalExpectedchildren: UILabel!
    @IBOutlet weak var totalExpectedStaff: UILabel!
    
    //Middle
    @IBOutlet weak var sliderTimeLabel: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    
    //Bototm left
    @IBOutlet weak var numberOfChilrenAtGivenTime: UILabel!
    
    //Bottom Right
    @IBOutlet weak var numberOfStaffAtGivenTime: UILabel!
    
    //Bottom
    @IBOutlet weak var numbersSlider: UISlider!
    
    //Spinner
    @IBOutlet weak var forecastSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        
        //Positioning the left subview
        
        
        TopLeftView.translatesAutoresizingMaskIntoConstraints = false
        TopRightView.translatesAutoresizingMaskIntoConstraints = false
        MiddleLeftView.translatesAutoresizingMaskIntoConstraints = false
        MiddleRightView.translatesAutoresizingMaskIntoConstraints = false
        MiddleView.translatesAutoresizingMaskIntoConstraints = false
        BottomLeftView.translatesAutoresizingMaskIntoConstraints = false
        BottomRightView.translatesAutoresizingMaskIntoConstraints = false
        BottomView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Positioning the top left subview
        
        //left
        TopLeftView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor).isActive = true
        
        //top
        TopLeftView.topAnchor.constraint(
            equalTo: view.topAnchor).isActive = true
        
        //height
        TopLeftView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 50).isActive = true
        
        //width
        TopLeftView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.25).isActive = true
        
        TopLeftView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        view.backgroundColor = .yellow
        
        //Positioning label within top left view
        
        //yetToArriveChildren.translatesAutoresizingMaskIntoConstraints = false
        
        // yetToArriveChildren.centerXAnchor.constraint(
        //   equalTo: TopLeftView.centerXAnchor
        // ).isActive = true
        
        // yetToArriveChildren.centerYAnchor.constraint(
        //   equalTo: TopLeftView.centerYAnchor
        // ).isActive = true
        
        
        //Positioning the top right subview
        
        //right
        //TopRightView.trailingAnchor.constraint(
            //equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        //top
        //TopRightView.topAnchor.constraint(
          //  equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        
        //height
        //TopRightView.heightAnchor.constraint(
          //  equalTo: view.heightAnchor,
            //multiplier: 0.25).isActive = true
        
        //TopRightView.backgroundColor =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        
        //Positioning label within top left view
        
        //signedInChildren.centerXAnchor.constraint(
        //  equalTo: TopRightView.centerXAnchor
        //).isActive = true
        
        //signedInChildren.centerYAnchor.constraint(
        //  equalTo: TopRightView.centerYAnchor
        //).isActive = true
        
        
        
        
        
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
