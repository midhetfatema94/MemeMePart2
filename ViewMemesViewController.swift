//
//  ViewMemesViewController.swift
//  MemeMe
//
//  Created by Midhet Sulemani on 14/11/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class ViewMemesViewController: UIViewController {

    @IBOutlet weak var meme: UIImageView!
    var memeImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meme.image = memeImage
        
    }
}
