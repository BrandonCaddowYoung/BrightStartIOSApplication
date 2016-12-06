//
//  MainMenuViewController.swift
//  BrightStart
//
//  Created by Colleen Caddow on 05/12/2016.
//  Copyright © 2016 dev. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    var collectionView: UICollectionView!
    
    var images = [UIImage(named: "Billing"), UIImage(named: "TimeStamps"),UIImage(named: "RegisteredHours"),UIImage(named: "Register")]
    let DisplayTextList = ["Billing", "TimeStamps", "RegisteredHours", "Register"]

    let segueIdList = ["GoToBilling", "GoToTimeStamps", "GoToRegisteredHours", "GoToRegister"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Initialising a collection view and addit it to the view controllers current view
    func setupCollectionView()
    {
    
        let commonHelper = CommonHelper()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 25
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(MainMenuButtonCollectionViewCell.self, forCellWithReuseIdentifier: "mainMenuButtonCell")
       collectionView.backgroundColor = commonHelper.hexStringToUIColor(hex: "#37A0e6")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
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

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Specifying the number of sections in the collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Specifying the number of cells in the given section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //We use this method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainMenuButtonCell", for: indexPath) as! MainMenuButtonCollectionViewCell
        cell.awakeFromNib()
        cell.delegate = self
        
        cell.setDisplayText(newDisplayText: DisplayTextList[indexPath.row])
        cell.segueText = segueIdList[indexPath.row]
        
        
        return cell
    }
    
    //We use this method to populate the data of a given cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let foodCell = cell as! MainMenuButtonCollectionViewCell
        foodCell.button.setBackgroundImage(images[indexPath.row], for: .normal)
    }
    
    //Sets the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}

extension MainMenuViewController: MainMenuButtonCollectionViewCellDelegate {
    
    func changeColorOfButton(forCell: MainMenuButtonCollectionViewCell) {
        //forCell.button.backgroundColor = UIColor.blue
    }
    
    func performSegue(segueId: String) {
        self.performSegue(withIdentifier: segueId, sender: self)
    }
}
