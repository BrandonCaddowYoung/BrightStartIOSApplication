//
//  CreateChildPageViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 20/03/2017.
//  Copyright © 2017 dev. All rights reserved.
//


import UIKit
import SVProgressHUD

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
        
        var WizardConrollerArray: [UIViewController] = []
        
        return WizardConrollerArray
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        for item in WizardViewControllers
        {
            orderedViewControllers.append(self.newWizardViewController(item))
        }
        
        self.edgesForExtendedLayout = []
        
        _ApplicatoinColours = ApplicatoinColours()
        _CommonHelper = CommonHelper()
        
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
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.show()
            
            var accountId = ""
            
            if(self.WizardPurpose == .CreatQuickChild)
            {
                //loadingSpiiner.show()
                
                if let step1 = orderedViewControllers[0] as? CreateChild_Quick_1ViewController {
                    if let step2 = orderedViewControllers[1] as? CreateChild_Quick_2ViewController {
                        
                        step2.MotherEmail.text = step2.MotherEmail.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        step2.FatherEMail.text = step2.MotherEmail.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        
                        step1.FirstNameTextField.text = step1.FirstNameTextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).capitalizingFirstLetter()
                        
                        step1.MiddleNameTextField.text = step1.MiddleNameTextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).capitalizingFirstLetter()
                        
                        step1.LastNameTextField.text = step1.LastNameTextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).capitalizingFirstLetter()
                        
                        AccountRequests.sharedInstance.CreateAccount(mothersEmail: step2.MotherEmail.text!, fathersEmail: step2.FatherEMail.text!, mothersName: step2.MothersName.text!, fathersName: step2.FathersName.text!, onCompletion:
                            { json in
                              
                             accountId = (json["AccountId"].stringValue as NSString) as String
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    ChildHelperRequests.sharedInstance.CreateChild(childFirstName: step1.FirstNameTextField.text!, childMiddleName: step1.MiddleNameTextField.text!, childLastName: step1.LastNameTextField.text!, dob: step1.DateOfBirthDatePicker.date as NSDate, accountId:accountId, onCompletion:
                                        { json in
                                            
                                            DispatchQueue.main.async(execute: {
                                                
                                                
                                                
                                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                                   self.performSegue(withIdentifier: "GoToSuccess", sender: nil)                                                    
                                                    
                                                } )
                                                
                                                
                                              
                                                
                                            })
                                    })
                                })
                        })
                }
                }
            }
           else if(self.WizardPurpose == .SetWeeklyRegisteredHours)
            {
                
                if let step1 = orderedViewControllers[0] as? RegisteredHoursWeekly_Step1ViewController {
                    if let step2 = orderedViewControllers[1] as? RegisteredHoursWeekly_Step2ViewController {
                        if let step3 = orderedViewControllers[2] as? RegisteredHoursWeekly_Step3ViewController {
                        
                            var selectedChildArray = [String]()
                            
                            for child in step1.selectedChildrenArray {
                                selectedChildArray.append(child.ChildId as String)
                            }
                            
                            //Getting time for Monday
                            
                            var mondayStartTime = ""
                            var mondayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 1 }) {
                                mondayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[0].StartTime as Date)
                                mondayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[0].EndTime as Date)
                            }
                            
                            //Getting time for Tuesday
                            
                            var tuesdayStartTime = ""
                            var tuesdayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 2 }) {
                                tuesdayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[1].StartTime as Date)
                                tuesdayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[1].EndTime as Date)
                            }
                            
                            //Getting time for Wednesday
                            
                            var wednesdayStartTime = ""
                            var wednesdayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 3 }) {
                                wednesdayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[2].StartTime as Date)
                                wednesdayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[2].EndTime as Date)
                            }
                            
                            //Getting time for Thursday
                            
                            var thursdayStartTime = ""
                            var thursdayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 4 }) {
                                thursdayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[3].StartTime as Date)
                                thursdayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[3].EndTime as Date)
                            }
                           
                            //Getting time for Friday
                            
                            var fridayStartTime = ""
                            var fridayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 5 }) {
                                fridayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[4].StartTime as Date)
                                fridayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[4].EndTime as Date)
                            }
                            
                            //Getting time for Saturday
                            
                            var saturdayStartTime = ""
                            var saturdayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 6 }) {
                                saturdayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[5].StartTime as Date)
                                saturdayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[5].EndTime as Date)
                            }
                            
                            //Getting time for Sunday
                            
                            var sundayStartTime = ""
                            var sundayEndTime = ""
                            
                            if step3.selectedDaysOfTheWeekArray.contains(where: { $0.DayNumber == 7 }) {
                                sundayStartTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[6].StartTime as Date)
                                sundayEndTime = _CommonHelper.GetTimeAsStringFromDate(targetDate: step3.daysOfTheWeekArray[6].EndTime as Date)
                            }
                            
                            let targetYear = step2.lastSelectedYear
                            let targetMonth = _CommonHelper.GetMonthAsInt(monthAsString: step2.lastSelectedMonth)
                                                       
                            PerformSetWeeklyRegisteredHoursRecursively(targetChildren: selectedChildArray, chosenYear: String(targetYear), chosenMonth: String(targetMonth), mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime, onCompletion: { json in
                                
                                DispatchQueue.main.async(execute: {
                                    
                                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                                        self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                        
                                    } )
                                    
                                    
                                })
                            })                    }
                }
                }
            }
           else if(self.WizardPurpose == .RegisteredHours_RollOver)
            {
                if let step1 = orderedViewControllers[0] as? RegisteredHoursRollOver_Step1ViewController {
                    if let step2 = orderedViewControllers[1] as? RegisteredHoursRollOver_Step2ViewController {
                        
                            var selectedChildArray = [String]()
                            
                            for child in step1.selectedChildrenArray {
                                selectedChildArray.append(child.ChildId as String)
                            }
                        
                            let targetYear = step2.lastSelectedTargetYear
                            let targetMonth = _CommonHelper.GetMonthAsInt(monthAsString: step2.lastSelectedTargetMonth)
                        
                        let destinationYear = step2.lastSelectedDestinationYear
                        let destinationMonth = _CommonHelper.GetMonthAsInt(monthAsString: step2.lastSelectedDestinationMonth)
                        
                        PerformRollOverRecursively(targetChildren: selectedChildArray, targetYear: String(targetYear), targetMonth: String(targetMonth), destinationYear: String(destinationYear), destinationMonth: String(destinationMonth),  onCompletion: { json in
                            
                            DispatchQueue.main.async(execute: {
                            
                                
                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                    self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                    
                                } )
                            
                             })
                             })
                    }
                }
            }
            
            else if(self.WizardPurpose == .Billing_CreatingInvoices)
            {
                if let step1 = orderedViewControllers[0] as? CreatingInvoices_Step1ViewController {
                    if let step2 = orderedViewControllers[1] as? CreatingInvoices_Step2ViewController {
                        if let step3 = orderedViewControllers[2] as? CreatingInvoices_Step3ViewController {
                            if let step4 = orderedViewControllers[3] as? CreatingInvoices_Step4ViewController {
                                
                        var selectedChildArray = [String]()
                        
                        for child in step1.selectedChildrenArray {
                            selectedChildArray.append(child.ChildId as String)
                        }
                        
                                let registeredHoursStartDate = step2.lastSelectedRegisteredHoursStartDate
                                let registeredHoursEndDate = step2.lastSelectedRegisteredHoursEndDate
                                
                                let extraHoursStartDate = step3.lastSelectedExtraStartDate
                                let extraHoursEndDate = step3.lastSelectedExtraEndDate
                                
                                let nonRegisteredHoursStartDate = step4.lastSelectedNonRegisteredHoursStartDate
                                let nonRegisteredHoursEndDate = step4.lastSelectedNonRegisteredHoursEndDate
                                
                                var fifteenDaysfromNow: Date {
                                    return (Calendar.current as NSCalendar).date(byAdding: .day, value: 15, to: Date(), options: [])!
                                }
                                
                        PerformCreatingInvoicesRecursively(targetChildren: selectedChildArray, registeredHoursStartDate: registeredHoursStartDate,registeredHoursEndDate: registeredHoursEndDate,extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate,nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: fifteenDaysfromNow, onCompletion: { json in
                            
                            DispatchQueue.main.async(execute: {
                                
                              
                                SVProgressHUD.dismiss(withDelay: 1, completion: {
                                    self.performSegue(withIdentifier: "GoToSuccess", sender: nil)
                                    
                                } )

                            
                                
                            })
                        })
                    }
                }
            }
                }
            }
            
        }
        
    }
    
    func PerformCreatingInvoicesRecursively(targetChildren: [String], registeredHoursStartDate: Date, registeredHoursEndDate: Date, extraHoursStartDate: Date, extraHoursEndDate: Date,  nonRegisteredHoursStartDate: Date, nonRegisteredHoursEndDate: Date, dueDate: Date, onCompletion: @escaping () -> Void)
    {
        
        var childrenList = targetChildren
        
        
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        BillingRequests.sharedInstance.CreateInvoices(targetChildren: lastItem as! [String], registeredHoursStartDate: registeredHoursStartDate, registeredHoursEndDate: registeredHoursEndDate, extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate, nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: dueDate, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Remove the guy we just completed
                    childrenList.removeLast()
                    
                    //Check if we are all done!
                    if(childrenList.count == 0)
                    {
                        onCompletion()
                        
                        return
                    }
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: String(childrenList.count) + " more to go!")
                    
                    //Do the next
                    self.PerformCreatingInvoicesRecursively(targetChildren: childrenList, registeredHoursStartDate: registeredHoursStartDate, registeredHoursEndDate: registeredHoursEndDate,  extraHoursStartDate: extraHoursStartDate, extraHoursEndDate: extraHoursEndDate, nonRegisteredHoursStartDate: nonRegisteredHoursStartDate, nonRegisteredHoursEndDate: nonRegisteredHoursEndDate, dueDate: dueDate, onCompletion: onCompletion)
                })
        })
    }
    
    func PerformRollOverRecursively(targetChildren: [String], targetYear: String, targetMonth: String, destinationYear: String, destinationMonth: String, onCompletion: @escaping () -> Void)
    {
       
        var childrenList = targetChildren
        
       
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        RegistrationHoursRequests.sharedInstance.RollOverRegisteredHours(targetChildren: lastItem as! [String], targetYear: String(targetYear)!, targetMonth: String(targetMonth)!, destinationYear: String(destinationYear)!, destinationMonth: String(destinationMonth)!, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Remove the guy we just completed
                    childrenList.removeLast()
                    
                    //Check if we are all done!
                    if(childrenList.count == 0)
                    {
                        onCompletion()
                        
                    return
                    }
                    
                    self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: String(childrenList.count) + " more to go!")
                    
                    //Do the next
                    self.PerformRollOverRecursively(targetChildren: childrenList, targetYear: targetYear, targetMonth: targetMonth, destinationYear: destinationYear, destinationMonth: destinationMonth, onCompletion: onCompletion)
                    
                })
        })
        
    }
    
    func PerformSetWeeklyRegisteredHoursRecursively(targetChildren: [String], chosenYear: String, chosenMonth: String,mondayStartTime : String, mondayEndTime : String,tuesdayStartTime : String, tuesdayEndTime : String,wednesdayStartTime : String, wednesdayEndTime : String, thursdayStartTime : String, thursdayEndTime : String,fridayStartTime : String, fridayEndTime : String, saturdayStartTime : String, saturdayEndTime : String, sundayStartTime : String, sundayEndTime : String, onCompletion: @escaping () -> Void)
    {
        
        var childrenList = targetChildren
        
        //Get the last item
        let lastItem = [childrenList.last]
        
        RegistrationHoursRequests.sharedInstance.SetWeeklyRegisteredHours(targetChildren: lastItem as! [String], chosenYear: String(chosenYear)!, chosenMonth: String(chosenMonth)!, mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime, onCompletion:
            { json in
                
                DispatchQueue.main.async(execute: {
                    
                    //Remove the guy we just completed
                    childrenList.removeLast()
                    
                    //Check if we are all done!
                    if(childrenList.count == 0)
                    {
                        onCompletion()
                        
                        return
                    }
                    
                     self._CommonHelper.ShowSuccessMessage(title: "All done!", subsTtitle: String(childrenList.count) + " more to go!")
                    
                    //Do the next
                    self.PerformSetWeeklyRegisteredHoursRecursively(targetChildren: childrenList, chosenYear: String(chosenYear), chosenMonth: String(chosenMonth), mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime, onCompletion: onCompletion)
                    
                })
        })
        
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
    
    fileprivate func newWizardViewController(_ controllerName: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(controllerName)ViewController")
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
