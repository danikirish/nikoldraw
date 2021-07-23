//
//  EntryViewController.swift
//  nikoldraws
//
//  Created by Daniyar Irishev on 19/07/2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveDrawing))
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        saveDrawing()
        
        return true
    }

    @objc func saveDrawing() {
        //check not empty
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        // increment count
        let newCount = count + 1
        // save data
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "drawing_\(newCount)")
        // call update if exists
        update?()
        // dismiss to root view controller
        navigationController?.popViewController(animated: true)
    }

}
