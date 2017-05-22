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
        
        SetNavigationBarDetails()
        
         self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        pageControl.addTarget(self, action: #selector(WizardViewController.didChangePageControlValue), for: .valueChanged)
        
        setupConstraints()
        
        Top.backgroundColor = .clear
        
        let image = UIImage.outlinedEllipse(size: CGSize(width: 7.0, height: 7.0), color: StyleManager.theme4())
        self.pageControl.pageIndicatorTintColor = UIColor.init(patternImage: image!)
        self.pageControl.currentPageIndicatorTintColor = StyleManager.theme1()
        
        //Stlying save button
        NextFinishButton.layer.cornerRadius = 5
        NextFinishButton.layer.borderWidth = 1
        NextFinishButton.layer.borderColor = StyleManager.theme2().cgColor
        NextFinishButton.backgroundColor = StyleManager.buttonBackGround()
        
        NextFinishButton.titleLabel?.font = _ApplicatoinColours.buttonFont
        NextFinishButton.setTitleColor(StyleManager.theme4(), for: .normal)
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
                
                if(self.wizardPageViewController?.WizardPurpose == .CreatQuickChild)
                {
                vc.selectedMenu = .Children
                }
                else if(self.wizardPageViewController?.WizardPurpose == .CreateChild)
                {
                    vc.selectedMenu = .Children
                }
                else if(self.wizardPageViewController?.WizardPurpose == .EditChild)
                {
                    vc.selectedMenu = .Children
                }
                else if(self.wizardPageViewController?.WizardPurpose == .SetWeeklyRegisteredHours)
                {
                    vc.selectedMenu = .RegisteredHours
                }
                else if(self.wizardPageViewController?.WizardPurpose == .RegisteredHours_RollOver)
                {
                    vc.selectedMenu = .RegisteredHours
                }
            }
        }
            
        else if (segue.identifier == "GoToSuccess") {
            if segue.destination is WizardSuccessViewController {
                
                
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
                wizardPageViewController.WizardViewControllers = ["RegisteredHoursWeekly_Step1", "RegisteredHoursWeekly_Step2", "RegisteredHoursWeekly_Step3"]
            }
            else if(WizardPurpose == .RegisteredHours_RollOver){
                wizardPageViewController.WizardViewControllers = ["RegisteredHoursRollOver_Step1", "RegisteredHoursRollOver_Step2"]
            }
            else if(WizardPurpose == .Billing_CreatingInvoices){
                wizardPageViewController.WizardViewControllers = ["CreatingInvoices_Step1","CreatingInvoices_Step2", "CreatingInvoices_Step3", "CreatingInvoices_Step4"]
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
            //Shows the nav bar
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
    
    func SetNavigationBarDetails()
    {
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        self.navigationController?.navigationBar.topItem?.title = " "
        
        //Title color(Center)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: StyleManager.NavigationBarText()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        navigationController?.navigationBar.tintColor = StyleManager.NavigationBarBackButton()
        
        //Back ground color
        navigationController?.navigationBar.barTintColor = StyleManager.NavigationBarBackGround()
        
        let rightUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Home"), style: .plain, target: self, action: #selector(NavBarMenuTapped))
        
        //Right button
        self.navigationItem.rightBarButtonItem  = rightUIBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = StyleManager.NavigationBarText()
        
        if(self.wizardPageViewController?.WizardPurpose == .CreatQuickChild)
        {
            self.navigationItem.title="Quick Create"
        }
        else if(self.wizardPageViewController?.WizardPurpose == .CreateChild)
        {
            self.navigationItem.title="Create"
        }
        else if(self.wizardPageViewController?.WizardPurpose == .EditChild)
        {
            self.navigationItem.title="Edit"
        }
        else if(self.wizardPageViewController?.WizardPurpose == .SetWeeklyRegisteredHours)
        {
            self.navigationItem.title="Setting Registered Hours"
        }
        else if(self.wizardPageViewController?.WizardPurpose == .RegisteredHours_RollOver)
        {
            self.navigationItem.title="Roll Over"
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
