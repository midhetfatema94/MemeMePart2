//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Midhet Sulemani on 14/11/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTable", for: indexPath) as! SentMemesTableViewCell
        cell.sentMeme.image = memes[indexPath.row].memedImage
        cell.memeTitle.text = memes[indexPath.row].topLine
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "viewMemes") as! ViewMemesViewController
        detailVC.memeImage = memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

class SentMemesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sentMeme: UIImageView!
    @IBOutlet weak var memeTitle: UILabel!
    
}
