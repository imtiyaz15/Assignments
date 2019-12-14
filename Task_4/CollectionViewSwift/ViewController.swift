//
//  ViewController.swift
//  Task_4
//
//  Created by Brahmastra on 20/11/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
     @IBOutlet weak var CView: UICollectionView!
    let players = [ "A","B", "C", "D","E","F","G","H","I","J","K","M"]
    let playersimages = [#imageLiteral(resourceName: "256x256"),#imageLiteral(resourceName: "256x256bb3"),#imageLiteral(resourceName: "_OP_Rumsey7006WorldAnimal1837-3_2_2"),#imageLiteral(resourceName: "256x256bb2"),#imageLiteral(resourceName: "256x256bb"),#imageLiteral(resourceName: "256x256bb1"),#imageLiteral(resourceName: "256x256bb2"),#imageLiteral(resourceName: "256x256bb2"),#imageLiteral(resourceName: "256x256bb2"),#imageLiteral(resourceName: "256x256"),#imageLiteral(resourceName: "256x256bb2"),#imageLiteral(resourceName: "256x256bb1"),#imageLiteral(resourceName: "18XmNTlk_400x400"),#imageLiteral(resourceName: "256x256bb1"),#imageLiteral(resourceName: "256x256") ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MyCollectionViewCell = CView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        cell.img.image = playersimages[indexPath.row]
        cell.captionLabel.text = players[indexPath.row]
        return cell
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
}

