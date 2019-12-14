//
//  ViewController.swift
//  Task_5
//
//  Created by Thanos on 22/11/19.
//  Copyright © 2019 Thanos. All rights reserved.
/* Interface Builder
 
 Creating Outlets
 
 Creating Actions
 
 Storyboard
 
 Segue's Properties & methods
 
 Create app by using StoryBoard and pass data from one view controller to another
 
 https://fluffy.es/3-ways-to-pass-data-between-view-controllers */

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var img = [#imageLiteral(resourceName: "im1-3") ,#imageLiteral(resourceName: "image13") ,#imageLiteral(resourceName: "im1-3") ,#imageLiteral(resourceName: "image4") ,#imageLiteral(resourceName: "im2") ,#imageLiteral(resourceName: "image1") ,#imageLiteral(resourceName: "image0") ,#imageLiteral(resourceName: "images27") ,#imageLiteral(resourceName: "d26ea94759d6caa12804dc6bd92f40ff") ,#imageLiteral(resourceName: "image4") ,#imageLiteral(resourceName: "image1") ,#imageLiteral(resourceName: "image4") ,#imageLiteral(resourceName: "im1-3") , #imageLiteral(resourceName: "images27") ,#imageLiteral(resourceName: "image1") ]
    var lbl = ["Doggy_1","Doggy_2","Doggy_3","Doggy_4","Doggy_5","Doggy_6","Doggy_7","Doggy_8","Doggy_9","Doggy_10","Doggy_11","Doggy_12","Doggy_13","Doggy_14","Doggy_15",]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lbl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MyCollectionViewCell  = Cview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.cell_Img.image = img[indexPath.row]
        cell.cell_Label.text  = lbl[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var Cview: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let passingData:NextViewController = storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        self.navigationController?.pushViewController(passingData, animated: true)
       passingData.nextlbl_var = lbl[indexPath.row]
        passingData.nextImg_var = img[indexPath.row]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let  width  = view.frame.size.width / 6
//        
//        let layout = Cview.collectionViewLayout  as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: width, height: width)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

