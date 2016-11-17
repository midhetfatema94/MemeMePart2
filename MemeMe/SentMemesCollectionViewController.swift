//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Midhet Sulemani on 14/11/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotated()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "sentMemes")

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: nil, completion: {handler in
//            print("orientation changed")
//        })
//    }
    
//    override func viewWillTransitionToSize(to: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: to, with: coordinator)
//        coordinator.animate(alongsideTransition: nil, completion: {
//            _ in
//            
//            print("orientation changed")
//        })
//    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(SentMemesCollectionViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            print("landscape")
            setCollectionFlowLayout(orientation: "Landscape")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            print("Portrait")
            setCollectionFlowLayout(orientation: "Portrait")
        }
        
    }
    
    func setCollectionFlowLayout(orientation: String) {
        
        if orientation == "Portrait" {
            let space: CGFloat = 1.0
            let widthDimension = (self.view.frame.width - (2*space))/3.0
            let heightDimension = (self.view.frame.height - (2*space))/5.0
            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
            
        }
        else if orientation == "Landscape" {
            let space: CGFloat = 1.0
            let widthDimension = (self.view.frame.width - (2*space))/5.0
            let heightDimension = (self.view.frame.height - (2*space))/3.0
            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
//        self.removeObserver(defa, forKeyPath: )
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sentMemes", for: indexPath) as! SentMemesCollectionViewCell
        cell.sentMeme.image = memes[indexPath.item].memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "viewMemes") as! ViewMemesViewController
        detailVC.memeImage = memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }

}

class SentMemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sentMeme: UIImageView!
    
}
