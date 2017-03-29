//
//  CreateChildPageViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 20/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//


import UIKit

class WizardPageViewController: UIPageViewController {
    
    var _ApplicatoinColours: ApplicatoinColours!
    var _CommonHelper: CommonHelper!
    
    var WizardPurpose: WizardPurpose!
    var successSegue: String!
    var cancelSegue: String!
    
    var onLastPage = false
    
    var WizardViewControllers: [String] = []
    
    weak var tutorialDelegate: WizardPageViewControllerDelegate?
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        return [self.newColoredViewController("CreateChild_Step1"), self.newColoredViewController("CreateChild_Step2")] //Add to this array for more Wizard steps!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
        //This needs to be passed in 
        WizardPurpose = .CreatQuickChild
        
        dataSource = self
        delegate = self
        
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
        
        tutorialDelegate?.wizardPageViewController(self,
                                                     didUpdatePageCount: orderedViewControllers.count)
        
        }
    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
        
        if(onLastPage)
        {
            var accountId = ""
            
            if(self.WizardPurpose == .CreatQuickChild)
            {
                if let step1 = orderedViewControllers[0] as? CreateChild_Quick_1ViewController {
                    if let step2 = orderedViewControllers[1] as? CreateChild_Quick_2ViewController {
                        
                        AccountRequests.sharedInstance.CreateAccount(mothersEmail: step2.MotherEmail.text!, fathersEmail: step2.FatherEMail.text!, mothersName: step2.MothersName.text!, fathersName: step2.FathersName.text!, onCompletion:
                            { json in
                              
                             accountId = (json["AccountId"].stringValue as NSString) as String
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    ChildHelperRequests.sharedInstance.CreateChild(childFirstName: step1.FirstNameTextField.text!, childMiddleName: step1.MiddleNameTextField.text!, childLastName: step1.LastNameTextField.text!, accountId:accountId, onCompletion:
                                        { json in
                                            
                                            DispatchQueue.main.async(execute: {
                                                
                                                 self.performSegue(withIdentifier: "GoToMenu", sender: nil)
                                                
                                            })
                                    })
                                })
                        })
                }
                }
            }
        }
        
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
       
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
       
        if(onLastPage)
        {
            if(self.WizardPurpose == .CreatQuickChild)
            {
               
            }
        }
        else{
            
        }
        
    }
    
    fileprivate func newColoredViewController(_ color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'tutorialDelegate' of the new index.
                            self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    fileprivate func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            
            if(index == orderedViewControllers.count-1){
                 self.onLastPage = true
            }
            else
            {
            self.onLastPage = false
            }
            
            tutorialDelegate?.wizardPageViewController(self, didUpdatePageIndex: index, onLastPage:  self.onLastPage)
            
            
            }
        
        
    }
    
}

// MARK: UIPageViewControllerDataSource

extension WizardPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //return orderedViewControllers.last
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        //Perform Validation
        
        if(self.Validation(currentIndex: viewControllerIndex) == false)
        {
            //Show error message.
            
            
            
            
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            //return orderedViewControllers.first
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
    func ShowErrorMsg(ttileMsg: String, errorMsg: String)
    {
        let alert = UIAlertController(title: ttileMsg, message:
            errorMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        //self.present(alert, animated: true, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func Validation(currentIndex: Int) -> Bool
    {
        if(self.WizardPurpose == .CreatQuickChild)
        {
            if let step1 = orderedViewControllers[currentIndex] as? CreateChild_Quick_1ViewController {
                
                if((step1.FirstNameTextField.text ?? "").isEmpty)
                {
                    ShowErrorMsg(ttileMsg: "Required field.", errorMsg: "The childs first name is a required field. Please enter the new childs name before proceeding.")
                    
                    return false
                }
                
                if((step1.LastNameTextField.text ?? "").isEmpty)
                {
                    ShowErrorMsg(ttileMsg: "Required field.", errorMsg: "The childs last name is a required field. Please enter the new childs name before proceeding.")                    
                    return false
                }
                
            }
            
            //Validate e-mail addresses.
            if let step2 = orderedViewControllers[currentIndex] as? CreateChild_Quick_2ViewController {
                
                if((step2.MotherEmail.text ?? "").isEmpty == false)
                {
                    //Make sure the email is valid
                  return isValidEmail(testStr: step2.MotherEmail.text!)
                   
                }
                
                if((step2.FatherEMail.text ?? "").isEmpty == false)
                {
                    //Make sure the email is valid
                    return isValidEmail(testStr: step2.FatherEMail.text!)
                }
                
            }
            
        }
        
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}

extension WizardPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
    
}

func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    
    if (segue.identifier == "GoToMenu") {
        
        if let vc = segue.destination as? MainMenuViewController {
            
            //In future we should go back to the calendar and select the date, however for now we should just go back to the main menu
            
            vc.selectedMenu = .RegisteredHours
            
        }
        
    }
    
}

protocol WizardPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func wizardPageViewController(_ WwzardPageViewController: WizardPageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func wizardPageViewController(_ wizardPageViewController: WizardPageViewController,
                                    didUpdatePageIndex index: Int, onLastPage : Bool)
    
}
