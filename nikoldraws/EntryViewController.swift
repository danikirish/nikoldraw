//
//  EntryViewController.swift
//  nikoldraws
//
//  Created by Daniyar Irishev on 19/07/2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    
    let defaultLabelText = "Number of words in the prompt: "
    
    var update: (() -> Void)?
    
    var promptController: PromptController!
    
    let words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePrompt))
        
        // "Generate" button
        self.button.frame(forAlignmentRect: CGRect(x: 10,
                                                   y: 300,
                                                   width: 200,
                                                   height: 60))
//        self.button.frame(: CGRect(x: 100,
//                                            y: 300,
//                                            width: 200,
//                                            height: 60))
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapGenerate), for: .touchUpInside)
//        self.view.addSubview(button)
        
        // Slider
//        let slider = UISlider(frame: CGRect(x: 0,
//                                            y: 100,
//                                            width: 300,
//                                            height: 20))
        slider.frame(forAlignmentRect: CGRect(x: -20,
                                              y: 50,
                                              width: 300,
                                              height: 20))
//        slider.center = self.view.center
        
//        self.view.addSubview(slider)
//
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.isContinuous = false
        slider.tintColor = UIColor.systemBlue
        slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        
        slider.setThumbImage(UIImage(named:"sliderThumb"), for: .normal)
        slider.setThumbImage(UIImage(named:"sliderThumb"), for: .highlighted)

        UIView.animate(withDuration: 0.8) {
            self.slider.setValue(3, animated: true)
        }
        
        // Label
        updateLabel()
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
    
    @objc func didTapGenerate() {
        
        field.text?.removeAll()
        
//        print("Generating...")
        let newPrompt = promptController.generatePrompt(length: Int(self.slider.value))
        
        field.text?.append(newPrompt)
        
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        
        
        let rounderStepValue = round(sender.value / 1) * 1
        sender.value = rounderStepValue
        
        updateLabel()
        
        print("Slider  value changed to \(Int(rounderStepValue))")
    }
    
    func updateLabel() {
        self.label.text = defaultLabelText + String(Int(self.slider.value))
    }

}
