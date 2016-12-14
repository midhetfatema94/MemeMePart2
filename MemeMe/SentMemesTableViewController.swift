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
        cell.memeTitle.text = "\(memes[indexPath.row].topLine) ... \(memes[indexPath.row].bottomLine)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "viewMemes") as! ViewMemesViewController
        detailVC.memeImage = memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    var memeToBeEdited: Meme!
    var isEdit = false
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") {(action, indexPath) in
            
            self.memeToBeEdited = self.memes[indexPath.row]
            let button = UIButton()
            button.tag = indexPath.row
            self.isEdit = true
            self.performSegue(withIdentifier: "presentEditor", sender: button)
            
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            let alert = UIAlertController(title: "Are you sure", message: "Delete this Meme!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {response in
                
                let object = UIApplication.shared.delegate
                let appDelegate = object as! AppDelegate
                appDelegate.memes.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return [edit, delete]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "presentEditor" && isEdit {
            
            let memeEditorVC = segue.destination as! MemeEditorViewController
            memeEditorVC.isEdited = true
            memeEditorVC.editingMeme = memeToBeEdited
            let button = sender as! UIButton
            memeEditorVC.editingIndex = button.tag
        }
        
    }
    
}

class SentMemesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sentMeme: UIImageView!
    @IBOutlet weak var memeTitle: UILabel!
    
}
