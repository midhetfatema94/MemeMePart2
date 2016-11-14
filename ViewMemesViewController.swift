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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
