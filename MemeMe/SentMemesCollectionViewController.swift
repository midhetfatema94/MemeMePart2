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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let space: CGFloat = 3.0
        let widthDimension = (self.view.frame.width - (2*space))/3.0
        let heightDimension = (self.view.frame.height - (2*space))/5.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
        
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "sentMemes")

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView!.reloadData()
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
