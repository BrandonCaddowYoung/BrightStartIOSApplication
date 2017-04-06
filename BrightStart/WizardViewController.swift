//
//  TutorialViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

import UIKit

class WizardViewController: UIViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var WizardPurpose: WizardPurpose!
    var successSegue: String!
    var cancelSegue: String!
    
    var showNavigationBar = true
    
    @IBOutlet weak var Top: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var NextFinishButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var wizardPageViewController: WizardPageViewController? {
        didSet {
            wizardPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        pageControl.addTarget(self, action: #selector(WizardViewController.didChangePageControlValue), for: .valueChanged)
        
        setupConstraints()
        
        Top.backgroundColor = .clear
        
        let image = UIImage.outlinedEllipse(size: CGSize(width: 7.0, height: 7.0), color: _ApplicatoinColours.Orange)
        self.pageControl.pageIndicatorTintColor = UIColor.init(patternImage: image!)
        self.pageControl.currentPageIndicatorTintColor = .white
        
        //Stlying save button
        NextFinishButton.layer.cornerRadius = 5
        NextFinishButton.layer.borderWidth = 1
        NextFinishButton.layer.borderColor = _ApplicatoinColours.White.cgColor
        NextFinishButton.backgroundColor = _ApplicatoinColours.ButtonBackGroundColor
        
        NextFinishButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        NextFinishButton.setTitleColor(_ApplicatoinColours.Black, for: .normal)
    }
    
    func setupConstraints() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //center
        containerView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor).isActive = true
        
        containerView.widthAnchor.constraint(
            equalTo: view.widthAnchor).isActive = true
        
        containerView.heightAnchor.constraint(
            equalTo: view.heightAnchor).isActive = true
        
        
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
        
        //Top
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        //center horizontally
        pageControl.centerYAnchor.constraint(
            equalTo: Top.centerYAnchor).isActive = true
        
        pageControl.leadingAnchor.constraint(
            equalTo: Top.leadingAnchor, constant: 15).isActive = true
        
        //Top
        
        NextFinishButton.translatesAutoresizingMaskIntoConstraints = false
        
        //center horizontally
        NextFinishButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: -15).isActive = true
        
        NextFinishButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        
        NextFinishButton.widthAnchor.constraint(
            equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        
        NextFinishButton.heightAnchor.constraint(
            equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "GoToMenu") {
            if let vc = segue.destination as? MainMenuViewController {
                
                //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
                vc.selectedMenu = .Children
            }
        }
            
        else if (segue.identifier == "GoToSuccess") {
            if let vc = segue.destination as? WizardSuccessViewController {
                
                
            }
        }
        
        else if let wizardPageViewController = segue.destination as? WizardPageViewController {
            
            self.wizardPageViewController = wizardPageViewController
            
            wizardPageViewController.WizardPurpose = WizardPurpose
            wizardPageViewController.successSegue = successSegue
            wizardPageViewController.cancelSegue = cancelSegue
            
            if(WizardPurpose == .CreatQuickChild){
              wizardPageViewController.WizardViewControllers = ["CreateChild_Step1", "CreateChild_Step2"]
            }
            else if(WizardPurpose == .SetWeeklyRegisteredHours){
                wizardPageViewController.WizardViewControllers = ["RegisteredHoursWeekly_Step1", "RegisteredHoursWeekly_Step2"]
            }
    
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
         wizardPageViewController?.scrollToNextViewController()
        
        //Final page validation
        
       // if(self.tutorialPageViewController?.Validation(currentIndex: 1) == true)
        //{
          //   tutorialPageViewController?.scrollToNextViewController()
       // }
        
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        wizardPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    //Removes the navigation bar from the top
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(false, animated: animated);
        }
        else
        {
            self.navigationController?.setNavigationBarHidden(true, animated: animated);
        }
        
    }
    
    func NavBarMenuTapped(){
        self.performSegue(withIdentifier: "GoToMenu", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if(!showNavigationBar){
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        else
        {
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
            
            navigationController?.navigationBar.topItem?.title = ""
            navigationController?.navigationBar.backItem?.title = ""
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
}

extension WizardViewController: WizardPageViewControllerDelegate {
    
    func wizardPageViewController(_ tutorialPageViewController: WizardPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func wizardPageViewController(_ wizardPageViewController: WizardPageViewController,
                                    didUpdatePageIndex index: Int, onLastPage: Bool) {
        pageControl.currentPage = index
        
        if(onLastPage){
            NextFinishButton.setTitle("Finish", for: .normal)
        }
        else
        {
            NextFinishButton.setTitle("Next", for: .normal)
        }
    }
}

/// An extension to `UIImage` for creating images with shapes.
extension UIImage {
    
    /// Creates a circular outline image.
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
