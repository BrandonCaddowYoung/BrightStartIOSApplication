//
//  TutorialViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var Top: UIView!
        @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var NextFinishButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.edgesForExtendedLayout = []
        
        pageControl.addTarget(self, action: #selector(TutorialViewController.didChangePageControlValue), for: .valueChanged)
        
        setupConstraints()
        
        Top.backgroundColor = .clear
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
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        tutorialPageViewController?.scrollToNextViewController()
        
        
        
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
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
