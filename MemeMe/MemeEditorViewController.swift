//
//  ViewController.swift
//  MemeMe
//
//  Created by Midhet Sulemani on 08/11/16.
//  Copyright © 2016 MCreations. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let imagePicker = UIImagePickerController()
    var activeField: UITextField?
    var isShared = false
    var isEdited = false
    var editingIndex = 0
    var editingMeme: Meme!
    
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var fill: UIColor!
    var font: Font!
    var stroke: Stroke!
    
    @IBAction func customizeFont(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "customise", sender: self)
    }
    @IBAction func cameraClicked(_ sender: UIBarButtonItem) {
        
        pick(source: .camera)
    }
    
    @IBAction func albumClicked(_ sender: UIBarButtonItem) {
        
        pick(source: .photoLibrary)
    }
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
        
        var sharingItems = [AnyObject]()
        
        //Converts UIView into UIImage
        //Code reference: Stack Overflow
        let renderer = UIGraphicsImageRenderer(size: memeView.bounds.size)
        let image = renderer.image { ctx in
            memeView.drawHierarchy(in: memeView.bounds, afterScreenUpdates: true)
        }
        
        sharingItems.append(image)
        
        CustomPhotoAlbum.sharedInstance.saveImage(image: image)
        isShared = true
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        //Code Reference: Stack Overflow
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
            if success && (activity != nil) {
                
                let saveMeme = Meme(topLine: self.topTextField.text!, bottomLine: self.bottomTextField.text!, memedImage: image, originalImage: self.memeImage.image!)
                
                let object = UIApplication.shared.delegate
                let appDelegate = object as! AppDelegate
                
                if self.isEdited {
                    
                    appDelegate.memes[self.editingIndex] = saveMeme
                    
                }
                else {
                    
                    appDelegate.memes.append(saveMeme)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelClicked(_ sender: UIBarButtonItem) {
        
        //Checks whether the image is shared otherwise popup appears
        if isShared {
            
            self.dismiss(animated: true, completion: nil)
        }
        else {
         
            //Clears all the content if user chooses to restart
            let alert = UIAlertController(title: "Cancel Memification!", message: "Are you sure you want to clear all the changes?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                
                self.topTextField.text = "Top Line"
                self.bottomTextField.text = "Bottom Line"
                self.memeImage.image = nil
                alert.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {action in
                
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
        
        bottomTextField.delegate = self
        bottomTextField.tag = 1
        topTextField.delegate = self
        
        //Code reference: Stack Overflow
        if UIImagePickerController.availableCaptureModes(for: .rear) == nil {
            cameraButton.isEnabled = false
        }
        
        fill = UIColor.white
        font = Font(name: "Impact", size: 56)
        stroke = Stroke(color: UIColor.black, width: 4.0)
        makeFont(tf: topTextField, fontSize: 56)
        makeFont(tf: bottomTextField, fontSize: 50)
        
        if isEdited {
            
            topTextField.text = editingMeme.topLine
            bottomTextField.text = editingMeme.bottomLine
            memeImage.image = editingMeme.originalImage
        }
        
    }
    
    //Function to change the attributes of the text
    func makeFont(tf: UITextField, fontSize: Int) {
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: stroke.color,
            NSFontAttributeName: UIFont(name: font.name, size: CGFloat(fontSize))!,
            NSForegroundColorAttributeName: fill,
            NSStrokeWidthAttributeName: -(CGFloat(stroke.width))]
        tf.defaultTextAttributes = memeTextAttributes
        tf.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        activeField = nil
        canShare()
        
        return true
    }
    
    func canShare() {
        
        if topTextField.text != "" && topTextField.text != "Top Line" && bottomTextField.text != "" && bottomTextField.text != "Bottom Line" && memeImage.image != nil {
            
            shareButton.isEnabled = true
        }
    }
    
    func pick(source:UIImagePickerControllerSourceType){
        
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = (((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) {
            
            if  activeField != nil {
                
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if activeField != nil {
                
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "Top Line" {
            textField.text = ""
        }
        
        if textField.tag == 1 {
            
            activeField = textField
            
            if textField.text == "Bottom Line" {
                textField.text = ""
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.contentMode = .scaleAspectFit
            memeImage.image = pickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
        canShare()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "customise" {
            
            let next = segue.destination as! CustomizeFontViewController
            next.prevVC = self
        }
    }
    
}

struct Meme {
    let topLine: String
    let bottomLine: String
    let memedImage: UIImage
    let originalImage: UIImage
}

struct Font {
    var name: String!
    var size: Double!
}

struct Stroke {
    var color: UIColor!
    var width: Double!
}
