//
//  MyProfileViewController.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 01/11/2016.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import Foundation
import UIKit
import TagListView

class MyProfileViewController:  UIViewController,
                                UINavigationControllerDelegate,
                                UIImagePickerControllerDelegate,
                                TagListViewDelegate,
                                UITextFieldDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var profilePictureButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var editingEnabled = false
    var tags = [String]()
    
    @IBAction func nameChanged(_ sender: Any) {
        if nameTextField.text == nil || nameTextField.text!.isEmpty {
            nameTextField.text = "anonymous"
        }
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if editingEnabled {
            editingEnabled = false
            reloadTagView(removeIconEnabled: false)
        } else {
            reloadTagView(removeIconEnabled: true)
            editingEnabled = true
        }
    }
    
    @IBAction func profilePictureTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTag(_ sender: Any) {
        editingEnabled = false
        reloadTagView(removeIconEnabled: false)
        
        let newTagAlert = UIAlertController(title: "Add New Tag", message: "Enter a single keyword and press \"Ok\"", preferredStyle:
            UIAlertControllerStyle.alert)
        
        newTagAlert.addTextField(configurationHandler: textFieldHandler)
        newTagAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
            if let fields = newTagAlert.textFields {
                if let tag = fields[0].text {
                    if self.isTagValid(tag: tag){
                        self.tags.append(tag)
                        self.tagView.addTag(tag)
                    } else {
                        AlertUtils.postAlert(viewController: self, title: "Tag not valid", message: "Enter a single word shorter than 20 characters.")
                    }
                }
            }
        }))
        
        newTagAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction) in }))
        
        self.present(newTagAlert, animated: true, completion: nil)
        tagView.reloadInputViews()
    }
    
    func isTagValid(tag: String) -> Bool {
        if !tag.contains(" ") && tag.characters.count < 20 && !tag.isEmpty { return true }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagView.delegate = self
        imagePicker.delegate = self
        nameTextField.delegate = self
        
        setTitle(titleText: "MY PROFILE")
        tagView.textFont = UIFont.systemFont(ofSize: 20)
        tagView.alignment = .left
        
        tagView.removeIconLineColor = UIColor.white
        tagView.removeIconLineWidth = CGFloat(integerLiteral: 1)
        tagView.removeButtonIconSize = CGFloat(integerLiteral: 10)
        
        //mock tags
        tags.append(contentsOf: ["technology", "automobile", "space", "flight", "science", "nature", "astronomy", "history", "startups"])
        reloadTagView(removeIconEnabled: false)
    
        applyButtonBorder(button: addTagButton)
        applyButtonBorder(button: editButton)
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
    }
    
    func reloadTagView(removeIconEnabled: Bool) {
        let sufix = removeIconEnabled ? " ✕" : ""
        tagView.removeAllTags()
        for tag in tags {
            tagView.addTag(tag + sufix)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if editingEnabled {
            sender.removeTag(title)
            if editingEnabled {
                tags = sender.tagViews.map({(x: TagView) -> String in String(x.titleLabel!.text!.characters.dropLast(2))})
            } else {
                tags = sender.tagViews.map({(x: TagView) -> String in x.titleLabel!.text!})
            }
        }
    }
    
    func textFieldHandler(textField: UITextField!) {
        if (textField) != nil {
            textField.text = ""
        }
    }
    
    func applyButtonBorder(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTitle(titleText: String) {
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 4/255, green: 135/255, blue: 1, alpha: 1)
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        if let navButtons = self.navigationController?.navigationBar.items {
            if navButtons.count > 0 {
                navButtons[0].title = ""
            }
        }
        
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = titleLable
        titleLable.text = titleText
        titleLable.textColor = UIColor.white
        titleLable.font = titleLable.font.withSize(CGFloat(24))
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
}

extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
