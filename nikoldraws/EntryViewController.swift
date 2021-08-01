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
    
    var promptController: PromptController!
    
    let words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePrompt))
        
        let button = UIButton(frame: CGRect(x: 100,
                                            y: 300,
                                            width: 200,
                                            height: 60))
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapGenerate), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        savePrompt()
        
        return true
    }

    @objc func savePrompt() {
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
        UserDefaults().set(text, forKey: "prompt_\(newCount)")
        // call update if exists
        update?()
        // dismiss to root view controller
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didTapGenerate() {
        
        field.text?.removeAll()
        
//        print("Generating...")
        let newPrompt = promptController.generatePrompt(length: 3)
        
        field.text?.append(newPrompt)
        
    }
    
    // Called on button "Generate"
//    @IBAction func didTapGenerate() {
//
//        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
//        vc.title = "New Drawing"
//        // prioritise calling updateDrawings()
//        vc.update = {
//            DispatchQueue.main.async {
//                self.updateDrawings()
//            }
//        }
//        // go to entry view controller
//        navigationController?.pushViewController(vc, animated: true)
//    }

}
